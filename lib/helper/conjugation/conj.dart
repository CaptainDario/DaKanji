//based on conj.csv which was scraped from
//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data



/// Enum containing the conjugation forms
enum Conj {
	Non_past,
	Past,
	Conjunctive,
	Provisional,
	Potential,
	Passive,
	Causative,
	Causative_Passive,
	Volitional,
	Imperative,
	Conditional,
	Alternative,
	Continuative,
}

/// A map from the id to the conjugation form enum
const Map<int, Conj> idToConj = {
	1 : Conj.Non_past,
	2 : Conj.Past,
	3 : Conj.Conjunctive,
	4 : Conj.Provisional,
	5 : Conj.Potential,
	6 : Conj.Passive,
	7 : Conj.Causative,
	8 : Conj.Causative_Passive,
	9 : Conj.Volitional,
	10 : Conj.Imperative,
	11 : Conj.Conditional,
	12 : Conj.Alternative,
	13 : Conj.Continuative,
};

/// A map from the conjugation form enum to the id
const Map<Conj, int> conjToId = {
	Conj.Non_past : 1,
	Conj.Past : 2,
	Conj.Conjunctive : 3,
	Conj.Provisional : 4,
	Conj.Potential : 5,
	Conj.Passive : 6,
	Conj.Causative : 7,
	Conj.Causative_Passive : 8,
	Conj.Volitional : 9,
	Conj.Imperative : 10,
	Conj.Conditional : 11,
	Conj.Alternative : 12,
	Conj.Continuative : 13,
};

/// A map from the conjugation form enum to a string description
const Map<Conj, String> conjToDescription = {
	Conj.Non_past : 'Non-past',
	Conj.Past : 'Past (~ta)',
	Conj.Conjunctive : 'Conjunctive (~te)',
	Conj.Provisional : 'Provisional (~eba)',
	Conj.Potential : 'Potential',
	Conj.Passive : 'Passive',
	Conj.Causative : 'Causative',
	Conj.Causative_Passive : 'Causative-Passive',
	Conj.Volitional : 'Volitional',
	Conj.Imperative : 'Imperative',
	Conj.Conditional : 'Conditional (~tara)',
	Conj.Alternative : 'Alternative (~tari)',
	Conj.Continuative : 'Continuative (~i)',
};