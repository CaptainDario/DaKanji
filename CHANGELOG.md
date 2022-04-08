
# Da Kanji - changelog

## v 2.0.0 - 隈なく

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

## v 1.4.0 - 現地化

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

## v 1.3.0 - 漢字検定

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

## v 1.2.2 - アニメ

Fixed:

- double tap to clear canvas

## v 1.2.1 - アニメ

Fixed:

- deleting strokes sometimes disabled drawing

## v 1.2.0 - アニメ

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

## v 1.1.0 - 熟語

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

## v 1.0.4

Fixed:

- a localized link to the play store

## v 1.0.3

Fixed:

- opening web dictionaries not working on most devices

## v 1.0.2

Fixed:

- minor fixes to make app release ready

## v 1.0.1

changes:

- use improved AI from DaKanjiRecognizer v1.1
- better image processing before feeding images to CNN

## v 1.0.0 - 初め

features:

- recognize ~3000 kanji characters
  