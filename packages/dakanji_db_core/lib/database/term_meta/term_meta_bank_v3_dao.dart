// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "/database/general_tables/reading_tables.dart";
import "/database/general_tables/term_tables.dart";
import "/database/term_meta/term_meta_bank_entry.dart";
import "/database/term_meta/term_meta_bank_ipa_entry.dart";
import "/database/term_meta/term_meta_bank_pitch_entry.dart";
import "/database/term_meta/term_meta_bank_relation_tables.dart";
import "/database/term_meta/term_meta_bank_v3_tables.dart";
import "../dakanji_db.dart";

part 'term_meta_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    TermTable, ReadingTable,
    TermMetaBankV3Table,
    TermMetaBankV3PitchTable, TermMetaBankV3PitchTagRelationsTable, TermMetaBankV3PitchRelationsTable,
    TermMetaBankV3IpaTable, TermMetaBankV3IpaTagRelationsTable, TermMetaBankV3IpaRelationsTable,
    TermMetaBankV3TagTable
])
class TermMetaBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$TermMetaBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  TermMetaBankV3Dao(super.db);
  

  /// Returns all term entries that match contain any of the given terms
  Future<List<TermMetaBankV3Entry>> getTermMetaBankEntriesFromTerm(String term) async {
  
    List<TermMetaBankV3Entry> ret = [];

    final tagsPitch  = alias(termMetaBankV3TagTable, 'tagsPitch');
    final tagsIpa    = alias(termMetaBankV3TagTable, 'tagsIpa');

    final query = (selectOnly(termMetaBankV3Table)
      ..join([
        // term
        innerJoin(
          termTable,
          termMetaBankV3Table.termId.equalsExp(termTable.id)
        ),
        // type
        innerJoin(
          termMetaBankV3TypeTable,
          termMetaBankV3Table.typeId.equalsExp(termMetaBankV3TypeTable.id)
        ),
        // reading
        leftOuterJoin(
          readingTable,
          termMetaBankV3Table.readingId.equalsExp(readingTable.id)
        ),
        // pitch
        leftOuterJoin(
          termMetaBankV3PitchRelationsTable,
          termMetaBankV3Table.id.equalsExp(termMetaBankV3PitchRelationsTable.termMetaId)
        ),
        leftOuterJoin(
          termMetaBankV3PitchTable,
          termMetaBankV3PitchRelationsTable.pitchId.equalsExp(termMetaBankV3PitchTable.id)
        ),
        // pitch tags
        leftOuterJoin(
          termMetaBankV3PitchTagRelationsTable,
          termMetaBankV3PitchTable.id.equalsExp(termMetaBankV3PitchTagRelationsTable.pitchId)
        ),
        leftOuterJoin(
          tagsPitch,
          termMetaBankV3PitchTagRelationsTable.tagId.equalsExp(tagsPitch.id)
        ),
        // ipa
        leftOuterJoin(
          termMetaBankV3IpaRelationsTable,
          termMetaBankV3Table.id.equalsExp(termMetaBankV3IpaRelationsTable.termMetaId)
        ),
        leftOuterJoin(
          termMetaBankV3IpaTable,
          termMetaBankV3IpaRelationsTable.ipaId.equalsExp(termMetaBankV3IpaTable.id)
        ),
        // ipa tags
        leftOuterJoin(
          termMetaBankV3IpaTagRelationsTable,
          termMetaBankV3IpaTable.id.equalsExp(termMetaBankV3IpaTagRelationsTable.ipaId)
        ),
        leftOuterJoin(
          tagsIpa,
          termMetaBankV3IpaTagRelationsTable.tagId.equalsExp(tagsIpa.id)
        ),
        
      ]))
      ..where(db.termTable.term.equals(term))
      ..groupBy([
        db.termMetaBankV3Table.id,
        db.termMetaBankV3PitchTable.id,
        db.termMetaBankV3IpaTable.id,
      ])
      ..addColumns([
        db.termMetaBankV3Table.id,
        db.termTable.term,
        db.termMetaBankV3TypeTable.type,
        db.readingTable.reading,
        db.termMetaBankV3Table.freqValue,
        db.termMetaBankV3Table.freqDisplayValue,

        db.termMetaBankV3PitchTable.position,
        db.termMetaBankV3PitchTable.devoice,
        db.termMetaBankV3PitchTable.nasal,
        tagsPitch.tag.groupConcat(),

        termMetaBankV3IpaTable.ipa,
        tagsIpa.tag.groupConcat()
      ])
      ..orderBy([OrderingTerm(expression: db.termMetaBankV3Table.id)])
      ;

    // Fetching data from the query
    final result = await query.get();

    // Process and return the result
    List<TermMetaBankV3PitchEntry>? pitchs; List<TermMetaBankV3IpaEntry>? ipas;
    for (int i = 0; i < result.length; i++) {
      TypedResult row = result[i];

      int? position = row.read<int>(termMetaBankV3PitchTable.position);
      if(position != null){
        pitchs ??= [];
        pitchs.add(
          TermMetaBankV3PitchEntry(
            position : position,
            devoice  : row.read<int>(termMetaBankV3PitchTable.devoice),
            nasal    : row.read<int>(termMetaBankV3PitchTable.nasal),
            tags     : row.read<String>(tagsPitch.tag.groupConcat())?.split(",")
          )
        );
      }

      String? ipa = row.read<String>(termMetaBankV3IpaTable.ipa);
      if(ipa != null){
        ipas ??= [];
        ipas.add(TermMetaBankV3IpaEntry(
          ipa: ipa,
          tags: row.read<String>(tagsIpa.tag.groupConcat())?.split(",")
        ));
      }

      if(i == result.length-1 || (result[i].read<int>(termMetaBankV3Table.id)!
        != result[i+1].read<int>(termMetaBankV3Table.id)!)){
        ret.add(TermMetaBankV3Entry(
          term:      row.read<String>(termTable.term)!,
          type:      row.read<String>(termMetaBankV3TypeTable.type)!,
          reading:   row.read<String>(readingTable.reading),
          frequency: row.read<int>(termMetaBankV3Table.freqValue),
          frequencyDisplayValue: row.read<String>(termMetaBankV3Table.freqDisplayValue),
          pitchs: pitchs,
          ipas: ipas
        ));
        pitchs = null; ipas = null;
      }
    }

    return ret;
  }



  // ---------------------------------------------------------------------------
  /// Get all types and their ids 
  Future<List<TermMetaBankV3TypeTableData>> getAllTypes() async {
    return await select(termMetaBankV3TypeTable).get();
  }

  /// Get all pitchs and their ids 
  Future<List<TermMetaBankV3PitchTableData>> getAllPitchs() async {
    return await select(termMetaBankV3PitchTable).get();
  }

  /// Get all ipa transcriptions and their ids 
  Future<List<TermMetaBankV3IpaTableData>> getAllIpas() async {
    return await select(termMetaBankV3IpaTable).get();
  }

  /// Get all tags and their ids 
  Future<List<TermMetaBankV3TagTableData>> getAllTags() async {
    return await select(termMetaBankV3TagTable).get();
  }

  // ---------------------------------------------------------------------------
  /// Get the maximum type id 
  Future<int> maxTermMetaBankV3TypeId() async {
    
    final query = await (selectOnly(termMetaBankV3TypeTable)
        ..addColumns([termMetaBankV3TypeTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3TypeTable.id.max()) ?? 0;

  }

  /// Get the maximum pitch id 
  Future<int> maxTermMetaBankV3PitchId() async {
    
    final query = await (selectOnly(termMetaBankV3PitchTable)
        ..addColumns([termMetaBankV3PitchTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3PitchTable.id.max()) ?? 0;

  }

  /// Get the maximum ipa id 
  Future<int> maxTermMetaBankV3IpaId() async {
    
    final query = await (selectOnly(termMetaBankV3IpaTable)
        ..addColumns([termMetaBankV3IpaTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3IpaTable.id.max()) ?? 0;

  }

  /// Get the maximum tag id 
  Future<int> maxTermMetaBankV3TagId() async {
    
    final query = await (selectOnly(termMetaBankV3TagTable)
        ..addColumns([termMetaBankV3TagTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3TagTable.id.max()) ?? 0;

  }

}
