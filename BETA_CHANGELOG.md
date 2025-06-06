# DaKanji Beta - changelog

## v3.5.0b7 - 改善 (09.04.2025)

- Deep Links on Windows
- Added setting to control the speed of the falling words

## v3.5.0b6 - 改善 (28.03.2025)

- Deep Links on Android

## v3.5.0b5 - 改善 (26.03.2025)

- Dictionary: searches with spaces

## v3.5.0b4 - 改善 (07.03.2025)

- Text
  - Close Popup by
    - tapping outside of text
    - double tapping popup header
  - Changing selection with native controls does not update lookup
  - Android selection buggy

## v3.5.0b3 - 改善 (3.03.2025)

### Added
  
- Dictionary
  - Handwriting input on android

### Improvements

- Text(MAJOR overhaul!)
  - Text input renders furigana (no need for two text widgets!)
  - Conjugations are now grouped together (食べ、たかっ、た -> 食べたかった)
  - Vastly improved selection handling
  - Only show furigana for kanjis
  - Space text instead of resizing furigana

### Fixed

- Dictionary
  - Wildcard search

-------------------------------------------------------------------------

## v3.5.0b2 - 改善 (31.01.2025)

Added:

- Dictionary:
  - Search result sorting priority setting
  - Show search separation headers setting
  - Limit search results setting

Fixed:

- Dictionary
  - Some searches breaking search
  - Search results wrong
  - Change serach result prioritization
  - Missing translations

-------------------------------------------------------------------------

## v3.5.0b1 - 改善 (31.12.2024)

The release of 3.4.6 took so long and contains so many new features that
a release as 3.5.0 makes more sense.

Improvements:

- Dictionary
  - Verb conjugation tables are synced across tabs
  - Some parts of search where case-sensitive

Fixed:

- Dictionary

-------------------------------------------------------------------------

## v3.4.6b6 - ワードリストと暗記改善 (23.10.2024)

Fixed:

- Dictionary
  - Do not show duplicate entries in the search history
  - First search is slow on android
  - When opening from the drawing screen tapping a search result does not close the search results

-------------------------------------------------------------------------

## v3.4.6b5 - ワードリストと暗記改善 (15.10.2024)

Fixed:

- Dictionary - Searched for: should not show the same term multiple times

-------------------------------------------------------------------------

## v3.4.6b4 - ワードリストと暗記改善 (15.10.2024)

Fixed:

- Dictionary
  - Webview does not scroll in the dictionary
  - Android: Kana table no sound
  - Scrolling floating words is too fast with s-pen
  - Searched for: should not show the same term multiple times

-------------------------------------------------------------------------

## v3.4.6b3 - ワードリストと暗記改善 (13.10.2024)

Fixed:

- Sorting of search results

-------------------------------------------------------------------------

## v3.4.6b2 - ワードリストと暗記改善 (11.10.2024)

Fixed:

- Dictionary
  - Search results overlaying
  - Floating words appear with entry open
  - Different searching bugs fixed
  - Colors of the "searched for"-snackbar improved to make it clearer that they are tappable

-------------------------------------------------------------------------

## v3.4.6b1 - ワードリストと暗記改善 (11.10.2024)

See normal changelog

-------------------------------------------------------------------------

## v3.4.5b1 - ワードリストと暗記改善 (11.09.2024)

Improvements:

- Images and DeepL on macOS

Fixed:

- Windows drawing recognition does not work

-------------------------------------------------------------------------

## v3.4.4b1 - ワードリストと暗記改善 (25.07.2024)

Fixed:

- Windows drawing recognition does not work
- DoJG search does not work
- Falling words block UI interaction

-------------------------------------------------------------------------

## v3.4.3b1 - ワードリストと暗記改善

Improvements:

- Dictionary
  - Back gesture clears the current search
  - Falling words
    - Not all controlled at the same time
- Use fvp for media playback

- Fixed:
  - App does not work in MS Store
  - DoJG: Impossible to scroll back when image full screen on desktop

-------------------------------------------------------------------------

## v3.4.2b3 - ワードリストと暗記改善 (05.07.2024)

Fixed:

- Does not start on Windows
- Pressing "rate" on linux causes an exception
- File picker not opening in snap
- Importing the dojg deck
- DoJG deep links
- DoJG screen search text color
- Potential race condition in SQLite when restarting the app
- MacOS: closing the app did not terminate the app

-------------------------------------------------------------------------

## v3.4.2b2 - ワードリストと暗記改善 (01.07.2024)

Fixed:

- Does not start on Windows
- Pressing "rate" on Linux causes exception
- File picker not opening in snap
- Importing the DoJG deck
- DoJG deep links
- DoJG screen search text color
- Potential race condition in SQLite when restarting the app

Fixed:

- Dictionary
  - macOS
    - When typing in Japanese, writing suggestions could not be selected using keyboard
- Kana table
  - Kana cut off on some aspect ratios
- Drawing
  - #73 Kanji search bar is not cleared
- Settings
  - Misc
    - Advanced
      - Optimize neural networks
- Deep Links:
  - Android https:// links

Removed:

- Search result navigation with arrow keys

-------------------------------------------------------------------------

## v3.4.2b1 - ワードリストと暗記改善 (21.06.2024)

Fixed:

- Pressing "rate" on Linux causes exception
- File picker not opening in snap
- Importing the DoJG deck
- DoJG deep links
- DoJG screen search text color
- Potential race condition in SQLite when restarting the app

-------------------------------------------------------------------------

## v3.4.1+102b1 - ワードリストと暗記 (15.05.2024)

Fixed:

- Anki integration on windows
- Katakana origins images not loading
- Word list sorting text hard to read in light mode
- Updated sentry for better handled / unhandled tags
- Spaces between PoS elements of dictionary entries
- Mecab not loading on iOS/MacOS
- Sharing entries as image does not respect the current theme

-------------------------------------------------------------------------

## v3.4.0+100b7 - ワードリストと暗記 (05.05.2024)

- Improvements
  - Word lists:
    - When a folder does not contain any word lists make it unselectable
    - If deselecting all word lists in a folder uncheck it

-------------------------------------------------------------------------

## v3.4.0+99b6 - ワードリストと暗記 (29.04.2024)

- Improvements
  - The folder where DaKanji stores necessary data has been moved to a location that a user usually does not use [#85](https://github.com/CaptainDario/DaKanji/issues/85)

-------------------------------------------------------------------------

## v3.4.0+98b5 - ワードリストと暗記 (19.04.2024)

- Improvements:
  - Removed grey lines from Anki manual
  - Small stutter when opening a word list
  - Dictionary
    - Share image: improved sharpness
  - Onboarding animations
  - Anki
    - Removed empty lines at the end of notes
    - Increased Kanji font size
- Added:
  - Anki:
    - Back side also shows front side
    - Separator line between front and back content
    - Unneccesary new lines
- Fixed:
  - Anki card template
  - Opening the radical/filter popup while the virtual keyboard is open
  - Long anki deck names makes the text of all settings small
  - When opening and closing the search on the kanji page the animation status is reset
  - Permission to connect with anki is requested multiple times and causes exceptions
  - Exporting word list crash on Android
  - Export to anki dialog not closing when pressing cancle

-------------------------------------------------------------------------

## v3.4.0+97b4 - ワードリストと暗記 (14.04.2024)

- Changed: Anki manual platform sections are collapsed
- Updated: Anki setup instructions
- Added: Settings localization
- Updated flutter to 3.19 and all dependencies
- Changed: when clicking on deep links, only allow one DaKanji instance
- Fixed: Anki manual links open a non working webview

-------------------------------------------------------------------------

## v3.4.0+96b3 - ワードリストと暗記 (11.04.2024)

- Fixed: Anki setup "no deck selected" message was not localized
- Changed: Exported cards have translations on the front
- Added: DaKanji note type has a note field on the front and back
- Added: Setting to disable the add to anki dialog

-------------------------------------------------------------------------

## v3.4.0+95b2 - ワードリストと暗記 (10.04.2024)

- Deep links
  - Fixed: android https:// links
- Fixed: Renaming word lists using Japanese keyboard
- Fixed: moving word list node to the bottom of the tree

-------------------------------------------------------------------------

## v3.4.0+94b1 - ワードリストと暗記 (10.04.2024)

See normal changelog

-------------------------------------------------------------------------

## v3.3.0+77b3 - 仮名 (13.01.2024)

- Removed unused dependencies
- Responsive manual buttons
- Initial deep link is only read once

-------------------------------------------------------------------------

## v3.3.0+76b2 - 仮名 (09.01.2024)

Beta 2 - Changes

- Use new dictionary files
  - Decreased examples size by 50%
    - Updated settings UI
  - Some fresh paint with Material 3 and Flutter 3.16
  - Fixed
    - Various UI fixes
    - Text screen selection buttons when no text is selected / available
    - DoJG asking twice to import

-------------------------------------------------------------------------

## v3.3.0+75b1 - 仮名 (26.11.2023)

New Features:

- Kana chart
  - Includes all common (and not-so-common) kana
  - Mnemonics for the main kana
  - Sounds for all available kana

-------------------------------------------------------------------------

## v3.2.0+71b12 - 文法 (19.11.2023)

- No separator between pitch accent patterns
- Opening virtual keyboard resets the matrix-style words
- Improved DoJG searching
- Improved DoJG navigation and updated manual

-------------------------------------------------------------------------

## v3.2.0+70b11 - 文法 (7.11.2023)

- DoJG
  - Import screen raised parent data exception

-------------------------------------------------------------------------

## v3.2.0+69b10 - 文法 (9.11.2023)

- Onboarding
  - Improved rendering performance EVEN MORE when swiping as SVGs led to stuttering
- DoJG
  - Text misaligned
  - Allow zooming in images of DoJG
  - Double tap to open DoJG image in fullscreen

-------------------------------------------------------------------------

## v3.2.0+68b9 - 文法 (7.11.2023)

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

-------------------------------------------------------------------------

## v3.2.0+67b8 - 文法 (5.11.2023)

Improvements:

- Dictionary
  - Radical search
    - Speed of searching kanjis that use all current radicals improved
    - Show **only** radicals (no kanjis) when no radical is selected

-------------------------------------------------------------------------

## v3.2.0+66b7 - 文法 (4.11.2023)

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

-------------------------------------------------------------------------

## v3.2.0+65b6 - 文法 (3.11.2023)

- Text screen selection buttons
  - cannot shrink selection at the end of text
- Dictionary
  - Added animated kanji stroke order diagrams
- Deep links
  - Android https scheme not working
  - Fixed: clipboard deep link
  - Fixed: opening the draw screen when it is already open breaks it  

-------------------------------------------------------------------------

## v3.2.0+64b5 - 文法 (29.10.2023)

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

-------------------------------------------------------------------------

## v3.2.0+63b4 - 文法 (29.10.2023)

- Text screen selection buttons slow
- The deconjugate message covers the text selection buttons
- When shrinking the selection while at the beginning of the text do nothing
- Fixed: selecting the previous word when next is punctuation
- Do not allow shrinking selection when only one character is selected
