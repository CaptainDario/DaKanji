

/// Compares `a` to `b`, if the strings are the same.
/// If `b` is shorter than `a`, the comparison only checks
/// the first elements
bool compareMecabOut(List<String> a, List<String?> b,){

  bool isSame = true;

  if(a[0] != b[0]){
    isSame = false;
  }
  else if(b.length > 1 && a[1] != b[1]){
    isSame = false;
  }
  else if(b.length > 2 && a[2] != b[2]){
    isSame = false;
  }
  else if(b.length > 3 && a[3] != b[3]){
    isSame = false;
  }

  return isSame;

}

/// Compares one mecab output to a list of mecab outputs.
/// If any of them are equal returns true
bool compareMecabOuts(List<String> a, List<List<String>> mecabOuts){

  for (var mecabOut in mecabOuts) {
    
    if(compareMecabOut(a, mecabOut)) return true;

  }

  return false;
}
