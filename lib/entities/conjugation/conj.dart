//based on conj.csv which was scraped from
//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data



/// Enum containing the conjugation forms
enum Conj {
	nonPast,
	past,
	conjunctive,
	provisional,
	potential,
	passive,
	causative,
	causativePassive,
	volitional,
	imperative,
	conditional,
	alternative,
	continuative,
}

/// A map from the id to the conjugation form enum
const Map<int, Conj> conjIdToConjEnum = {
	1 : Conj.nonPast,
	2 : Conj.past,
	3 : Conj.conjunctive,
	4 : Conj.provisional,
	5 : Conj.potential,
	6 : Conj.passive,
	7 : Conj.causative,
	8 : Conj.causativePassive,
	9 : Conj.volitional,
	10 : Conj.imperative,
	11 : Conj.conditional,
	12 : Conj.alternative,
	13 : Conj.continuative,
};

/// A map from the conjugation form enum to the id
const Map<Conj, int> conjEnumToConjId = {
	Conj.nonPast : 1,
	Conj.past : 2,
	Conj.conjunctive : 3,
	Conj.provisional : 4,
	Conj.potential : 5,
	Conj.passive : 6,
	Conj.causative : 7,
	Conj.causativePassive : 8,
	Conj.volitional : 9,
	Conj.imperative : 10,
	Conj.conditional : 11,
	Conj.alternative : 12,
	Conj.continuative : 13,
};

/// A map from the conjugation form enum to a string description
const Map<Conj, String> conjEnumToConjDescription = {
	Conj.nonPast : 'Non-past',
	Conj.past : 'Past (~ta)',
	Conj.conjunctive : 'Conjunctive (~te)',
	Conj.provisional : 'Provisional (~eba)',
	Conj.potential : 'Potential',
	Conj.passive : 'Passive',
	Conj.causative : 'Causative',
	Conj.causativePassive : 'Causative-Passive',
	Conj.volitional : 'Volitional',
	Conj.imperative : 'Imperative',
	Conj.conditional : 'Conditional (~tara)',
	Conj.alternative : 'Alternative (~tari)',
	Conj.continuative : 'Continuative (~i)',
};