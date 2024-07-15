
# DaKanji - changelog

## v3.4.3 - ワードリストと暗記改善 (10.07.2024)

Added:

- I am in the matrix

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

## v3.4.2 - ワードリストと暗記改善 (05.07.2024)

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

## v3.4.1 - ワードリストと暗記改善 (09.06.2024)

Added:

- Added drawer manual
- Show word frequency in dictionary if selected
- Quick send to anki
- Quick add to wordlist

Fixed / Improved:

- Improved performance with Flutter 3.22
- iOS keyboard is not dismissible on text screen
- Spaces between PoS elements of dictionary entries
- Updated sentry for better handled / unhandled tags
- Word list sorting text hard to read in light mode
- Anki integration on windows
- Katakana origins images not loading
- Mecab not loading on iOS/MacOS/certain configurations
- Sharing entries as image does not respect the current theme
- Onboarding: Pressing the next button does not trigger animations
- Drawing: when pressing repeatedly the undo button the predictions are not cleared
- Exception when checking for new release
- Some texts used Chinese characters instead of Japanese
- Kanji tab starts scrolled part-way down #95

-------------------------------------------------------------------------

## v3.4.0 - ワードリストと暗記 (9.5.2024)

New Features:

- Anki integration: Send words and word lists to Anki
- Dictionary
  - Share images of entry and kanji cards
  - Image search query customizable
  - Characters from drawing are now added at the cursor's position
- Word Lists
  - Sort lists in folders
  - Search in lists
  - Lists for JLPT
  - Export: PDF, CSV Images
  - Screen saver
- Kana Table
  - Added kana origins

Improvements:

- Dictionary
  - Fancy slide-in of search results
- Settings
  - Misc
    - Advanced
      - Optimize neural networks UI
- Onboarding animations
- The folder where DaKanji stores necessary data has been moved to a location that a user usually does not use [#85](https://github.com/CaptainDario/DaKanji/issues/85)
- Dramatically decreased startup time in certain scenarios

Fixed:

- Dictionary
  - MacOS
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

## v3.3.3 - 仮名 (21.12.2023)

New Features:

- Kana chart
  - Includes all common (and not-so-common) kana
  - Mnemonics for the main kana
  - Sounds for all available kana

Improvements:

- Better organized settings
- Some fresh paint with Material 3 and Flutter 3.16
- New dictionary data
  - Examples 50% smaller

Fixed:

- Various UI fixes
- Text screen selection buttons when no text is selected / available
- DoJG asking twice to import

-------------------------------------------------------------------------

## v3.3.2 - 仮名 (19.12.2023)

New Features:

- Kana chart
  - Includes all common (and not-so-common) kana
  - Mnemonics for the main kana
  - Sounds for all available kana

Improvements:

- Better organized settings
- Some fresh paint with Material 3 and Flutter 3.16
- New dictionary data
  - Examples 50% smaller

Fixed:

- Various UI fixes
- Text screen selection buttons when no text is selected / available
- DoJG asking twice to import

-------------------------------------------------------------------------

## v3.3.1 - 仮名 (14.12.2023)

New Features:

- Kana chart
  - Includes all common (and not-so-common) kana
  - Mnemonics for the main kana
  - Sounds for all available kana

Improvements:

- Better organized settings
- Some fresh paint with Material 3 and Flutter 3.16
- New dictionary data
  - Examples 50% smaller

Fixed:

- Various UI fixes
- Text screen selection buttons when no text is selected / available
- DoJG asking twice to import

-------------------------------------------------------------------------

## v3.3.0 - 仮名 (14.12.2023)

New Features:

- Kana chart
  - Includes all common (and not-so-common) kana
  - Mnemonics for the main kana
  - Sounds for all available kana

Improvements:

- Better organized settings
- Some fresh paint with Material 3 and Flutter 3.16
- New dictionary data
  - Examples 50% smaller

Fixed:

- Various UI fixes
- Text screen selection buttons when no text is selected / available
- DoJG asking twice to import

-------------------------------------------------------------------------

## v3.2.0+74 - 文法 (4.12.2023)

New Features:

- Deep Links:
  - Directly open dakanji with dakanji:// or https://dakanji.app/app/
  - Share dictionary and DoJG entries
  - See the manual for more info
- Dictionary
  - Animated Kanji stroke order diagrams
- Text
  - Selection buttons
  - Copy button
  - Paste button
  - Automatic DoJG lookup
  - Added settings
- Brand new website [dakanji.app](https://dakanji.app)
- Import Dictionary of Japanese Grammar (DoJG) anki deck to effortlessly look up grammar

- By popular request:
  - flatpak support

Improvements:

- Radical ui layout on narrow screens
- Improved data unpacking: UI does not freeze and progress message is shown
- Warn the user when downgrading versions
- Radical search speed improved
- Onboarding UI and performance
- Various UI and performance improvements

Fixed:

- #64 Examples sometimes repeating
- #62 Pitch accent still bugged
- #67 Clipboard screen: search not closable

-------------------------------------------------------------------------

## v3.1.1+60 - 辞書開発 (18.9.2023)

Hotfixes:

- Drawing not working on android devices

-------------------------------------------------------------------------

## v3.1.0+58 - 辞書開発 (13.9.2023)

New Features:

- Kanji charts: filter and sort kanjis by categories such as JLPT, 漢検, KLC and more
- Clipboard screen to lookup words that are in the OS's clipboard
- Drawer elements reorderable
- Periodically, check for updates at app start
- Dictionary
  - Mark the current word in example sentences (#31)
  - English dictionary can be disabled (#30)
  - Show more kanji information
    - KLC, new JLPT, RTK, 漢検
    - antonyms, synonyms, lookalikes
  - Radical lookup
    - Clear selection
    - Selection from clipboard
    - Sort kanji by stroke order
    - Improved radical rendering
    - UI improvements
  - Navigate search results with keyboard
- Sentry for feedback collection
- マトリックス (#39)

Fixed:

- Pitch accent not correct for words that include 2 character mora (#29)
- Radical popup does not close (#27)
- Navigating dictionary -> drawing -> dictionary
- Some Searches lead to seemingly incorrect results (#49)
- Sometimes radicals were missing
- JLPT data for some entries wrong

-------------------------------------------------------------------------

## v3.0.0 - 辞書 (4.6.2023)

New Features:

- Inbuilt dictionary
  - Search with kanji, kana or romaji
  - Search Kanji by radical or draw them
  - Multi-language support: English, German, French, Spanish, ...
  - Conjugation of verbs, adjectives, copula
  - Detailed information about Kanjis
  - 6000+ audios
  - Pitch accent
  - Example sentences
- Text processing screen
  - Add furigana to any text
  - Look up unknown words using the inbuilt dictionary
  - Colorize words based on their Part of Speech
  - Translate using DeepL
- Easy way of providing feedback

Changes:

- updated to Flutter 3 (stable Linux, Mac)

Fixed:

- After tapping outside of the rate dialog stuck with a blank screen
- Rate dialog "close"-button does not work
- TF Lite not working on some SoCs
- many more...

-------------------------------------------------------------------------

## v2.1.0 - 仕上げ (19.7.2022)

new Features:

- improved character recognition
- credits page
- (desktop) set a startup window size
- new languages supported: ru, ja, zh, it, fr

Changes:

- updated to Flutter 3 (stable Linux, Mac)

Fixed:

- Selecting an inference backend (iOS, Android)

-------------------------------------------------------------------------

## v2.0.1 - 隈なく (24.04.2022)

new Features:

- Windows, MacOS, Linux support
- Onboarding
- New UI design (responsive!)
- Use a web dictionary side by side with drawing screen (mobile only)

Changes:

- Updated Flutter to 2.10.x (stable windows support)
- Updated dart to 2.16.x (null safety)

Fixed:

- Tutorial highlights
- number of characters in the multi-char search

-------------------------------------------------------------------------

## v1.4.0 - 現地化 (09.11.2021)

new Features:

- responsive design (try with a dictionary side by side!)
- iOS support
  - supported app dictionaries: shirabe jisho, Japanese, imiha, midori
- localization:
  - English, German
  - if you want to see DaKanji in more languages please [help translate it](https://github.com/CaptainDario/DaKanji-Mobile/wiki/Internationalization-and-localization)
- ask for a rating from time to time

Changes:

- require android 6 or newer
- awesome new popup dialogues
- new drawer open/close animation
- loading indicator for webview
- setting to select inference backend
- updated to flutter 2.5.3

Fixed:

- show "what's new"-popup only when the app was installed before
- predictions not showing up on some devices

-------------------------------------------------------------------------

## v1.3.0 - 漢字検定 (25.06.2021)

new Features:

- recognize:

  - all 漢字 from 漢字検定
  - ひらがな (also historical ones: ゑ, etc.)
  - カタカナ (also historical ones: ヱ, etc.)

Changes:

- smaller model
- faster inference

Fixed:

- Chinese font was used
- clearing canvas while deleting a stroke did not play an animation

-------------------------------------------------------------------------

## v1.2.2 - アニメ (21.05.2021)

Fixed:

- double tap to clear canvas

-------------------------------------------------------------------------

## v1.2.1 - アニメ (20.05.2021)

Fixed:

- deleting strokes sometimes disabled drawing

-------------------------------------------------------------------------

## v 1.2.0 - アニメ (18.05.2021)

new Features:

- *extremely* fast startup
- inference in separate thread therefore no UI jank on low end devices
- [deep linking 'dakanji://dakanji/'](https://github.com/CaptainDario/DaKanji-Mobile#deep-linking)
- animated:
  - double tap on prediction / kanji box
  - character added/deleted to/from kanji box
  - opening a prediction in a web dictionary
  - deleting stroke(s) from canvas
  - drawer
- splash screen

Changes:

- improved drawing experience
- kanji box now shows the last added characters
- use webview instead of default browser
- drawer now indicates current location
- color when pressing on kanji box

-------------------------------------------------------------------------

## v1.1.0 - 熟語 (06.04.2021)

New Features:

- multi character search
- open prediction in akebi (app)
- open prediction in aedict (app)
- Settings: invert long press/short press behavior
- Settings: delete drawing after double tap
- What's new message

Changes:

- beautiful new icon
- updated themes
- renamed to DaKanji
- Refactoring
- Provide apk on GitHub
- added close button to app download dialogues

Fixes:

- "character copied" message on some devices not showing up
- UI layout on certain aspect ratios
- show tutorial **only** if there are new features
- blurry buttons in light mode

-------------------------------------------------------------------------

## v1.0.4 (17.03.2021)

Fixed:

- a localized link to the play store

-------------------------------------------------------------------------

## v 1.0.3 (16.03.2021)

Fixed:

- opening web dictionaries not working on most devices

-------------------------------------------------------------------------

## v 1.0.2 (13.03.2021)

Fixed:

- minor fixes to make app release ready

-------------------------------------------------------------------------

## v 1.0.1 (11.03.2021)

changes:

- use improved AI from DaKanjiRecognizer v1.1
- better image processing before feeding images to CNN

-------------------------------------------------------------------------

## v 1.0.0 - 初め (23.02.2021)

features:

- recognize ~3000 kanji characters
  