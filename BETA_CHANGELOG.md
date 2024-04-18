# DaKanji Beta - changelog

## v3.4.0+78b5 - 仮名 (19.04.2024)

* Improvments:
  * Removed grey lines from Anki manual
* Added:
  * Anki:
    * Back side also shows front side
    * Separator line between front and back content
    * Unneccesary new lines
* Fixed:
  * Anki card template
  * When opening and closing the search on the kanji page the animation status is reset

## v3.4.0+77b4 - 仮名 (14.04.2024)

* Changed: Anki manual platform sections are collapsed
* Updated: Anki setup instructions
* Added: Settings localization
* Updated flutter to 3.19 and all dependencies
* Changed: when clicking on deep links, only allow one DaKanji instance
* Fixed: Anki manual links open a non working webview

## v3.4.0+77b3 - 仮名 (11.04.2024)

* Fixed: Anki setup "no deck selected" message was not localized
* Changed: Exported cards have translations on the front
* Added: DaKanji note type has a note field on the front and back
* Added: Setting to disable the add to anki dialog

## v3.4.0+77b2 - 仮名 (10.04.2024)

* Deep links
  * Fixed: android https:// links
* Fixed: Renaming word lists using Japanese keyboard
* Fixed: moving word list node to the bottom of the tree

## v3.4.0+77b1 - 仮名 (10.04.2024)

See normal changelog

## v3.3.0+77b3 - 仮名 (13.01.2024)

* Removed unused dependencies
* Responsive manual buttons
* Initial deep link is only read once

## v3.3.0+76b2 - 仮名 (09.01.2024)

Beta 2 - Changes

* Use new dictionary files
  * Decreased examples size by 50%
    * Updated settings UI
  * Some fresh paint with Material 3 and Flutter 3.16
  * Fixed
    * Various UI fixes
    * Text screen selection buttons when no text is selected / available
    * DoJG asking twice to import

## v3.3.0+75b1 - 仮名 (26.11.2023)

New Features:

* Kana chart
  * Includes all common (and not-so-common) kana
  * Mnemonics for the main kana
  * Sounds for all available kana

## v3.2.0+71b12 - 文法 (19.11.2023)

* No separator between pitch accent patterns
* Opening virtual keyboard resets the matrix-style words
* Improved DoJG searching
* Improved DoJG navigation and updated manual

## v3.2.0+70b11 - 文法 (7.11.2023)

* DoJG
  * Import screen raised parent data exception

## v3.2.0+69b10 - 文法 (9.11.2023)

* Onboarding
  * Improved rendering performance EVEN MORE when swiping as SVGs led to stuttering
* DoJG
  * Text misaligned
  * Allow zooming in images of DoJG
  * Double tap to open DoJG image in fullscreen

## v3.2.0+68b9 - 文法 (7.11.2023)

Improvements

* Onboarding
  * Faster transition between pages
  * Improved rendering performance when swiping as SVGs led to stuttering
  * Animates back when stop swiping instead of a hard reset
  * Onboarding images scale down a bit when transitioning in / out

Fixed:

* Text
  * DeepL not loading
  * Tapping popup closed it when it was already open

## v3.2.0+67b8 - 文法 (5.11.2023)

Improvements:

* Dictionary
  * Radical search
    * Speed of searching kanjis that use all current radicals improved
    * Show **only** radicals (no kanjis) when no radical is selected

## v3.2.0+66b7 - 文法 (4.11.2023)

Improvements:

* Text screen:
  * Buttons show ripple effect
* Dictionary
  * Radical search
    * Speed of searching radicals, that can be combined with current ones, dramatically improved

Fixed:

* Init
  * Asset unpacking became very slow with archive > 3.3.2
* Dictionary
  * Radical search
    * Manually clearing all selected radicals showed all available kanji instead of none
  * Examples
    * Opening an example in the text screen raised an excpetion
  * Search bar
    * Separator line does not always disappear when closing the search bar
    * When closing searchbar using back button, divider disappeared immediately

## v3.2.0+65b6 - 文法 (3.11.2023)

* Text screen selection buttons
  * cannot shrink selection at the end of text
* Dictionary
  * Added animated kanji stroke order diagrams
* Deep links
  * Android https scheme not working
  * Fixed: clipboard deep link
  * Fixed: opening the draw screen when it is already open breaks it  

## v3.2.0+64b5 - 文法 (29.10.2023)

* Text screen selection buttons
  * Enabled by default
  * Manual incorrect
* Onboarding
  * images broken
  * Image size
* Dictionary
  * Filter / Radical popup excess margin on mobile removed
* Dictionary / Text / Clipboard deconjugation message shown at top of the screen
* Make text screen buttons fade at the side to indicate that they are scrollable
* Manual not scrollable on tiny/narrow screens

## v3.2.0+63b4 - 文法 (29.10.2023)

* Text screen selection buttons slow
* The deconjugate message covers the text selection buttons
* When shrinking the selection while at the beginning of the text do nothing
* Fixed: selecting the previous word when next is punctuation
* Do not allow shrinking selection when only one character is selected
