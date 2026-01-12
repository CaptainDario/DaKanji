/// Generates the Yomitan-compatible CSS string with dynamic theming.
String getStructuredContentCss({required bool darkMode}) {
  // Define theme variables based on the boolean
  final textColor = darkMode ? '#d4d4d4' : '#000000';
  final textColorLight = darkMode ? '#888888' : '#888888';
  final backgroundColor = darkMode ? '#1e1e1e' : '#ffffff';
  final borderColor = darkMode ? '#888888' : '#777777'; // Darker border for visibility
  final linkColor = darkMode ? '#68b5e9' : '#005cc5'; // Example accent colors
  final tableHeaderBg = darkMode ? '#2d2d2d' : '#eeeeee';
  final imageOverlayColor = darkMode ? '#cccccc' : '#888888';

  return """
:root {
  --font-size-no-units: 16;
  --line-height: 1.5;
  --text-color: $textColor;
  --text-color-light: $textColorLight;
  --background-color: $backgroundColor;
  --border-color: $borderColor;
  --link-color: $linkColor;
}

body {
  color: var(--text-color);
  background-color: var(--background-color);
}

/* --- IMAGES --- */

.gloss-image-container {
  display: inline-block;
  white-space: nowrap;
  max-width: 100%;
  max-height: 100vh;
  position: relative;
  vertical-align: top;
  line-height: 0;
  overflow: hidden;
  font-size: 1px;
}

.gloss-image-link {
  cursor: inherit;
  display: inline-block;
  position: relative;
  line-height: 1;
  max-width: 100%;
  color: inherit;
}

.gloss-image-container-overlay {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  font-size: calc(1em * var(--font-size-no-units));
  line-height: var(--line-height);
  display: table;
  table-layout: fixed;
  white-space: normal;
  color: $imageOverlayColor;
}

.gloss-image-link[data-has-image=true][data-image-load-state=load-error] .gloss-image-container-overlay::after {
  content: 'Image failed to load';
  display: table-cell;
  width: 100%;
  height: 100%;
  vertical-align: middle;
  text-align: center;
  padding: 0.25em;
}

.gloss-image-background {
  --image: none;
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  -webkit-mask-repeat: no-repeat;
  -webkit-mask-position: center center;
  -webkit-mask-mode: alpha;
  -webkit-mask-size: contain;
  -webkit-mask-image: var(--image);
  mask-repeat: no-repeat;
  mask-position: center center;
  mask-mode: alpha;
  mask-size: contain;
  mask-image: var(--image);
  background-color: currentColor;
}

.gloss-image {
  display: inline-block;
  vertical-align: top;
  object-fit: contain;
  border: none;
  outline: none;
}

.gloss-image-link[data-has-aspect-ratio=true] .gloss-image {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
}

/* Consolidated Image Rendering */
.gloss-image-link[data-image-rendering=pixelated] .gloss-image,
.gloss-image-link[data-image-rendering=crisp-edges] .gloss-image {
  image-rendering: pixelated;
  image-rendering: -webkit-optimize-contrast;
  image-rendering: crisp-edges;
}

.gloss-image-link[data-has-aspect-ratio=true] .gloss-image-sizer {
  display: inline-block;
  width: 0;
  vertical-align: top;
  font-size: 0;
}

.gloss-image-link-text {
  display: none;
  line-height: var(--line-height);
}

.gloss-image-link-text::before {
  content: '[';
}

.gloss-image-link-text::after {
  content: ']';
}

.gloss-image-description {
  display: block;
  white-space: pre-line;
  color: $textColorLight;
}

/* Monochrome Images */
.gloss-image-link[data-appearance=monochrome] .gloss-image {
  --shadow-settings: 0 0 0.01px var(--text-color);
  filter: grayscale(1) opacity(0.5) drop-shadow(var(--shadow-settings)) drop-shadow(var(--shadow-settings)) saturate(1000%) brightness(1000%);
  opacity: 0;
}

.gloss-image-link[data-size-units=em] .gloss-image-container {
  font-size: 1em;
}

.gloss-image-link[data-vertical-align=baseline] { vertical-align: baseline; }
.gloss-image-link[data-vertical-align=sub] { vertical-align: sub; }
.gloss-image-link[data-vertical-align=super] { vertical-align: super; }
.gloss-image-link[data-vertical-align=text-top] { vertical-align: top; }
.gloss-image-link[data-vertical-align=text-bottom] { vertical-align: bottom; }
.gloss-image-link[data-vertical-align=middle] { vertical-align: middle; }
.gloss-image-link[data-vertical-align=top] { vertical-align: top; }
.gloss-image-link[data-vertical-align=bottom] { vertical-align: bottom; }

/* Collapsed State Logic */
.gloss-image-link[data-collapsed=true] { vertical-align: baseline; }
.gloss-image-link[data-collapsed=true] .gloss-image-container { display: none; }
.gloss-image-link[data-collapsed=true] .gloss-image-link-text { display: inline; }
.gloss-image-link[data-collapsed=true]~.gloss-image-description { display: inline; }

.gloss-link-external-icon {
  display: none;
}

.gloss-image-link:not([data-appearance=monochrome]) .gloss-image-background {
  display: none;
}

/* --- TABLES --- */

.gloss-sc-table-container {
  display: block;
  overflow-x: auto;
}

.gloss-sc-table {
  table-layout: auto;
  border-collapse: collapse;
  border-spacing: 0;
  color: var(--text-color);
}

.gloss-sc-thead, .gloss-sc-tfoot, .gloss-sc-th {
  font-weight: bold;
}

.gloss-sc-th, .gloss-sc-td {
  border: 1px solid $borderColor;
  padding: 0.25em;
  vertical-align: top;
}

.gloss-sc-th {
  background-color: $tableHeaderBg;
}

/* --- LINKS --- */
a {
  color: var(--link-color);
  text-decoration: none;
}
""";
}