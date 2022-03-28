


enum DrawScreenLayout {
  Portrait,
  PortraitWithWebview,
  Landscape,
  LandscapeWithWebview,
}

bool drawScreenIsLandscape(DrawScreenLayout drawScreenLayout){
  return (drawScreenLayout == DrawScreenLayout.Landscape || 
    drawScreenLayout == DrawScreenLayout.LandscapeWithWebview);
}

bool drawScreenIsPortrait(DrawScreenLayout drawScreenLayout){
  return (drawScreenLayout == DrawScreenLayout.Portrait ||
    drawScreenLayout == DrawScreenLayout.PortraitWithWebview);
}

bool drawScreenIncludesWebview(DrawScreenLayout drawScreenLayout){
  return (drawScreenLayout == DrawScreenLayout.PortraitWithWebview || 
    drawScreenLayout == DrawScreenLayout.PortraitWithWebview);
}