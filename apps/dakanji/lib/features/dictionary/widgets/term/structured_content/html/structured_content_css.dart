/// Generates the Yomitan-compatible CSS string with dynamic theming.
String getStructuredContentCss({required bool darkMode}) {
  // Define theme variables based on the boolean
  final textColor = darkMode ? '#d4d4d4' : '#000000';
  final textColorLight = darkMode ? '#888888' : '#888888';
  final backgroundColor = darkMode ? '#1e1e1e' : '#ffffff';
  final borderColor = darkMode ? '#888888' : '#777777'; 
  final linkColor = darkMode ? '#68b5e9' : '#005cc5'; 
  final tableHeaderBg = darkMode ? '#2d2d2d' : '#eeeeee';

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

.dk-sc-image {
  display: inline-block;
  vertical-align: top;
  object-fit: contain;
  border: none;
  outline: none;
}

.dk-sc-image-description {
  display: block;
  white-space: pre-line;
  color: var(--text-color-light);
}

/* --- TABLES --- */

.dk-sc-table-container {
  display: block;
  overflow-x: auto;
}

.dk-sc-table {
  table-layout: auto;
  border-collapse: collapse;
  border-spacing: 0;
  color: var(--text-color);
}

.dk-sc-thead, .dk-sc-tfoot, .dk-sc-th {
  font-weight: bold;
}

.dk-sc-th, .dk-sc-td {
  border: 1px solid var(--border-color);
  padding: 0.25em;
  vertical-align: top;
}

.dk-sc-th {
  background-color: $tableHeaderBg;
}

/* --- LINKS --- */
a {
  color: var(--link-color);
  text-decoration: none;
}
""";
}