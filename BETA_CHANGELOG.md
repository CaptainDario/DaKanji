# DaKanji Beta - changelog

## v3.2.0+69b10 - 辞書開発 (9.11.2023)

- Onboarding
  - Improved rendering performance EVEN MORE when swiping as SVGs led to stuttering
- DoJG
  - Text misaligned
  - Allow zooming in images of DoJG
  - Double tap to open DoJG image in fullscreen

## v3.2.0+68b9 - 辞書開発 (7.11.2023)

Improvements

- Onboarding
  - Faster transition between pages
  - Improved rendering performance when swiping as SVGs led to stuttering
  - Animates back when stop swiping instead of a hard reset
  - Onboarding images scale down a bit when transitioning in / out

Fixed:

- Text
  - DeepL not loading
  - Tapping popup closed it when it was already open

## v3.2.0+67b8 - 辞書開発 (5.11.2023)

Improvements:

- Dictionary
  - Radical search
    - Speed of searching kanjis that use all current radicals improved
    - Show **only** radicals (no kanjis) when no radical is selected

## v3.2.0+66b7 - 辞書開発 (4.11.2023)

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
  - Search bar
    - Separator line does not always disappear when closing the search bar
    - When closing searchbar using back button, divider disappeared immediately

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
