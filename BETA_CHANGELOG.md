# DaKanji Beta - changelog

## v3.2.0+66b7 - 辞書開発 (4.11.2023)

New Features:

Improvements:

- Text screen:
  - Buttons show ripple effect
- Dictionary
  - Radical search
    - Speed of searching radicals, that can be combined with current ones, dramatically improved

Fixed:

- Init
  - Asset unpacking became very slow with archive > 3.3.2
- Dictionary
  - Radical search
    - Manually clearing all selected radicals showed all available kanji instead of none
  - Examples
    - Opening an example in the text screen raised an excpetion

## v3.2.0+65b6 - 辞書開発 (3.11.2023)

- Text screen selection buttons
  - cannot shrink selection at the end of text
- Dictionary
  - Added animated kanji stroke order diagrams
- Deep links
  - Android https scheme not working
  - Fixed: clipboard deep link
  - Fixed: opening the draw screen when it is already open breaks it  

## v3.2.0+64b5 - 辞書開発 (29.10.2023)

- Text screen selection buttons
  - Enabled by default
  - Manual incorrect
- Onboarding
  - images broken
  - Image size
- Dictionary
  - Filter / Radical popup excess margin on mobile removed
- Dictionary / Text / Clipboard deconjugation message shown at top of the screen
- Make text screen buttons fade at the side to indicate that they are scrollable
- Manual not scrollable on tiny/narrow screens

## v3.2.0+63b4 - 辞書開発 (29.10.2023)

- Text screen selection buttons slow
- The deconjugate message covers the text selection buttons
- When shrinking the selection while at the beginning of the text do nothing
- Fixed: selecting the previous word when next is punctuation
- Do not allow shrinking selection when only one character is selected