


enum DrawScreenLayout {
  portrait,
  portraitWithWebview,
  landscape,
  landscapeWithWebview,
}

bool drawScreenIsLandscape(DrawScreenLayout drawScreenLayout){
  return (drawScreenLayout == DrawScreenLayout.landscape || 
    drawScreenLayout == DrawScreenLayout.landscapeWithWebview);
}

bool drawScreenIsPortrait(DrawScreenLayout drawScreenLayout){
  return (drawScreenLayout == DrawScreenLayout.portrait ||
    drawScreenLayout == DrawScreenLayout.portraitWithWebview);
}

bool drawScreenIncludesWebview(DrawScreenLayout drawScreenLayout){
  return (drawScreenLayout == DrawScreenLayout.portraitWithWebview || 
    drawScreenLayout == DrawScreenLayout.portraitWithWebview);
}