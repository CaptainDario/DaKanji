//based on conotes.csv which was scraped from
//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data



/// A map from the id to a note regarding conjugation of a word
const Map<int, String> conotes = {
	1 : '"Irregular conjugation.  Note that this not the same as the definitionof ""irregular verb"" commonly found in textbooks (typically する and来る).  It denotes okurigana that is different than other words ofthe same class.  Thus the past tense of 行く (行った) is an irregularconjugation because other く (v5k) verbs use いた as the okurigana forthis conjugation.  します is not an irregular conjugation because ifwe take する to behave as a v1 verb the okurigana is the same as otherv1 verbs despite the sound change of the stem (す) part of the verbto し."',
	2 : 'na-adjectives and nouns are usually used with the なら nara conditional, instead of with であれば de areba. なら is a contracted and more common form of ならば.',
	3 : 'では is often contracted to じゃ in colloquial speech.',
	4 : 'The (first) non-abbreviated form is obtained by applying sequentially the causative, then passive conjugations.',
	5 : 'The -まい negative form is literary and rather rare.',
	6 : 'The ら is sometimes dropped from -られる, etc. in the potential form in conversational Japanese, but it is not regarded as grammatically correct.',
	7 : '""n" and "adj-na" words when used as predicates are followed by thecopula <a href=""entr.py?svc=jmdict&sid=&q=2089020.jmdict"">だ</a> which is what is conjugated (<a href=""conj.py?svc=jmdict&sid=&q=2089020.jmdict"">conjugations</a>)."',
	8 : 'vs words are followed by <a href="entr.py?svc=jmdict&sid=&q=1157170.jmdict">する</a> which is what is conjugated (<a href=""conj.py?svc=jmdict&sid=&q=1157170.jmdict"">conjugations</a>).',
};