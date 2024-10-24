//based on conjo_notes.csv which was scraped from
//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data

// Project imports:
import '../../entities/conjugation/conjo_note.dart';

// convenience vars  
const String f = 'f';
const String t = 't';

/// list containing example `ConjoNote`s from the JMDict project 
const List conjoNotes = [
	ConjoNote(2, 1, f, f, 1, 7),
	ConjoNote(15, 1, t, f, 1, 3),
	ConjoNote(15, 1, t, t, 1, 3),
	ConjoNote(15, 1, t, t, 2, 3),
	ConjoNote(15, 2, t, f, 1, 3),
	ConjoNote(15, 2, t, t, 1, 3),
	ConjoNote(15, 3, t, f, 1, 3),
	ConjoNote(15, 4, f, f, 1, 2),
	ConjoNote(15, 11, t, f, 1, 3),
	ConjoNote(15, 11, t, t, 1, 3),
	ConjoNote(17, 1, f, f, 1, 7),
	ConjoNote(28, 5, f, f, 2, 6),
	ConjoNote(28, 5, f, t, 2, 6),
	ConjoNote(28, 5, t, f, 2, 6),
	ConjoNote(28, 5, t, t, 2, 6),
	ConjoNote(28, 9, t, f, 1, 5),
	ConjoNote(28, 9, t, t, 1, 5),
	ConjoNote(29, 5, f, f, 2, 6),
	ConjoNote(29, 5, f, t, 2, 6),
	ConjoNote(29, 5, t, f, 2, 6),
	ConjoNote(29, 5, t, t, 2, 6),
	ConjoNote(29, 9, t, f, 1, 5),
	ConjoNote(29, 9, t, t, 1, 5),
	ConjoNote(29, 10, f, f, 1, 1),
	ConjoNote(30, 1, f, t, 1, 1),
	ConjoNote(30, 1, t, t, 1, 1),
	ConjoNote(30, 2, f, t, 1, 1),
	ConjoNote(30, 2, t, t, 1, 1),
	ConjoNote(30, 3, f, t, 1, 1),
	ConjoNote(30, 3, t, t, 1, 1),
	ConjoNote(30, 4, f, t, 1, 1),
	ConjoNote(30, 4, f, t, 2, 1),
	ConjoNote(30, 4, t, t, 1, 1),
	ConjoNote(30, 4, t, t, 2, 1),
	ConjoNote(30, 9, f, t, 1, 1),
	ConjoNote(30, 9, t, f, 1, 5),
	ConjoNote(30, 9, t, t, 1, 5),
	ConjoNote(30, 10, f, f, 1, 1),
	ConjoNote(30, 10, f, t, 1, 1),
	ConjoNote(30, 10, t, t, 1, 1),
	ConjoNote(30, 11, f, t, 1, 1),
	ConjoNote(30, 11, t, t, 1, 1),
	ConjoNote(30, 12, f, t, 1, 1),
	ConjoNote(30, 13, f, f, 1, 1),
	ConjoNote(31, 9, t, f, 1, 5),
	ConjoNote(31, 9, t, t, 1, 5),
	ConjoNote(32, 9, t, f, 1, 5),
	ConjoNote(32, 9, t, t, 1, 5),
	ConjoNote(33, 9, t, f, 1, 5),
	ConjoNote(33, 9, t, t, 1, 5),
	ConjoNote(34, 2, f, f, 1, 1),
	ConjoNote(34, 3, f, f, 1, 1),
	ConjoNote(34, 9, t, f, 1, 5),
	ConjoNote(34, 9, t, t, 1, 5),
	ConjoNote(34, 11, f, f, 1, 1),
	ConjoNote(34, 12, f, f, 1, 1),
	ConjoNote(35, 9, t, f, 1, 5),
	ConjoNote(35, 9, t, t, 1, 5),
	ConjoNote(36, 9, t, f, 1, 5),
	ConjoNote(36, 9, t, t, 1, 5),
	ConjoNote(37, 9, t, f, 1, 5),
	ConjoNote(37, 9, t, t, 1, 5),
	ConjoNote(38, 1, t, f, 1, 1),
	ConjoNote(38, 2, t, f, 1, 1),
	ConjoNote(38, 3, t, f, 1, 1),
	ConjoNote(38, 3, t, f, 2, 1),
	ConjoNote(38, 9, t, f, 1, 5),
	ConjoNote(38, 9, t, t, 1, 5),
	ConjoNote(38, 11, t, f, 1, 1),
	ConjoNote(38, 12, t, f, 1, 1),
	ConjoNote(39, 9, t, f, 1, 5),
	ConjoNote(39, 9, t, t, 1, 5),
	ConjoNote(40, 9, t, f, 1, 5),
	ConjoNote(40, 9, t, t, 1, 5),
	ConjoNote(41, 9, t, f, 1, 5),
	ConjoNote(41, 9, t, t, 1, 5),
	ConjoNote(42, 2, f, f, 1, 1),
	ConjoNote(42, 3, f, f, 1, 1),
	ConjoNote(42, 9, t, f, 1, 5),
	ConjoNote(42, 9, t, t, 1, 5),
	ConjoNote(42, 11, f, f, 1, 1),
	ConjoNote(42, 12, f, f, 1, 1),
	ConjoNote(45, 5, f, f, 2, 6),
	ConjoNote(45, 5, f, t, 2, 6),
	ConjoNote(45, 5, t, f, 2, 6),
	ConjoNote(45, 5, t, t, 2, 6),
	ConjoNote(45, 9, t, f, 1, 5),
	ConjoNote(45, 9, t, t, 1, 5),
	ConjoNote(45, 10, f, f, 1, 1),
	ConjoNote(46, 1, f, f, 1, 8),
	ConjoNote(47, 5, f, f, 1, 1),
	ConjoNote(47, 5, f, t, 1, 1),
	ConjoNote(47, 5, t, f, 1, 1),
	ConjoNote(47, 5, t, t, 1, 1),
	ConjoNote(47, 6, f, f, 1, 1),
	ConjoNote(47, 6, f, t, 1, 1),
	ConjoNote(47, 6, t, f, 1, 1),
	ConjoNote(47, 6, t, t, 1, 1),
	ConjoNote(47, 7, f, f, 1, 1),
	ConjoNote(47, 7, f, f, 2, 1),
	ConjoNote(47, 7, f, t, 1, 1),
	ConjoNote(47, 7, f, t, 2, 1),
	ConjoNote(47, 7, t, f, 1, 1),
	ConjoNote(47, 7, t, f, 2, 1),
	ConjoNote(47, 7, t, t, 1, 1),
	ConjoNote(47, 7, t, t, 2, 1),
	ConjoNote(47, 8, f, f, 1, 1),
	ConjoNote(47, 8, f, t, 1, 1),
	ConjoNote(47, 8, t, f, 1, 1),
	ConjoNote(47, 8, t, t, 1, 1),
	ConjoNote(47, 9, t, f, 1, 5),
	ConjoNote(47, 9, t, t, 1, 5),
	ConjoNote(47, 10, f, f, 2, 1),
	ConjoNote(48, 5, f, f, 1, 1),
	ConjoNote(48, 5, f, t, 1, 1),
	ConjoNote(48, 5, t, f, 1, 1),
	ConjoNote(48, 5, t, t, 1, 1),
	ConjoNote(48, 6, f, f, 1, 1),
	ConjoNote(48, 6, f, t, 1, 1),
	ConjoNote(48, 6, t, f, 1, 1),
	ConjoNote(48, 6, t, t, 1, 1),
	ConjoNote(48, 7, f, f, 1, 1),
	ConjoNote(48, 7, f, f, 2, 1),
	ConjoNote(48, 7, f, t, 1, 1),
	ConjoNote(48, 7, f, t, 2, 1),
	ConjoNote(48, 7, t, f, 1, 1),
	ConjoNote(48, 7, t, f, 2, 1),
	ConjoNote(48, 7, t, t, 1, 1),
	ConjoNote(48, 7, t, t, 2, 1),
	ConjoNote(48, 8, f, f, 1, 1),
	ConjoNote(48, 8, f, t, 1, 1),
	ConjoNote(48, 8, t, f, 1, 1),
	ConjoNote(48, 8, t, t, 1, 1),
	ConjoNote(48, 9, t, f, 1, 5),
	ConjoNote(48, 9, t, t, 1, 5),
	ConjoNote(48, 10, f, f, 2, 1),
];
