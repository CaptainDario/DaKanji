# 1.2.1
- Add `BorderSide` param in `TargetFocus`. [PR #96](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/96)
- Added right property for custom alignment. [PR #101](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/101)

# 1.2.0
- Add `pulseEnable` param in `TutorialCoachMark` to enable/disable pulse animation. [PR #88](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/88)
- Add `padding` param in `TargetContent` to customize target padding. [PR #84](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/84)
- Add optional param `rootOverlay` in `TutorialCoachMark.show()`. Suggestion date in issue [93](https://github.com/RafaelBarbosatec/tutorial_coach_mark/issues/93)
- The methods `onClickTarget` and `onClickOverlay` now they can be asynchronous and the next target will only be called after processing something added to it.

# 1.1.1
- Fiz error [issue 82](https://github.com/RafaelBarbosatec/tutorial_coach_mark/issues/82)

# 1.1.0
- Add web support! [PR #79](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/79) Thanks [Will Reppun
](https://github.com/wreppun)

# 1.0.3
- Fix blink when start tutorial with shape `ShapeLightFocus.RRec`

# 1.0.2
- Adds builder(BuildContext context, TutorialCoachMarkController controller) in `TargetContent`.
Now you can create a widget of the `TargetContent` with `child` or `builder`.

# 1.0.1

- Merged PR [72](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/72)

# 1.0.0

- Migrate to Null-Safety
- Merged PR [55](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/55)
- Merged PR [57](https://github.com/RafaelBarbosatec/tutorial_coach_mark/pull/57)

# 0.6.0+1

- update README

# 0.6.0

- Improvements in the project structure
- BREAKING CHANGE: rename `onClickSkip` to `onSkip`
- BREAKING CHANGE: rename `CustomTargetPosition` to `CustomTargetContentPosition`
- BREAKING CHANGE: rename `AlignContent` to `ContentAlign`
- BREAKING CHANGE: rename `ContentTarget` to `TargetContent`

# 0.5.3

- Fix issue #33. Thanks [cwyu-Ivan](https://github.com/cwyu-Ivan)
- Fix issue #47. Thanks [percula](https://github.com/percula)

# 0.5.2

- add `focusAnimationDuration` and `pulseAnimationDuration` to settings animations duration.
- add `paddingFocus` and `alignSkip` in `TargetFocus`. Now you can configure Skip alignment and focus padding individually.

# 0.5.1

- Fix issue #34

# 0.5.0

- Add `enableOverlayTab` and `enableTargetTab` in TargetFocus;
- Add `next`and `previous` in TutorialCoachMark;

# 0.4.0

- Add `radius` and `Color` in TargetFocus;
- Add custom align in `ContentTarget`;
- Click to progress only in target;
- BREAKING CHANGE: rename `finish` to `onFinish`
- BREAKING CHANGE: rename `clickSkip` to `onClickSkip`
- BREAKING CHANGE: rename `clickTarget` to `onClickTarget`

# 0.3.0

- Fix Issue #14
- Fix Issue #11
- Fix Issue #18
- Accepts contributions from grandpa-guru and Vanethos

# 0.2.0

- Fix Issue #4
- add LightBulb RRect

# 0.1.0

- Add change opacity shadow

# 0.0.1

- First version
