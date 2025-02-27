# fixerupper

* [convert legacy scrollable area to listbox](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/scrollable_area_to_listbox.4dm) [^satolb]
* [convert legacy grouped radio buttons](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/add_radio_group.4dm) [^rbg]
* [make b/w form objects dark mode aware](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/set_automatic_fill_and_stroke.4dm) [^bwauto]
* [SVG based highlight buttons](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/highlight_button_to_svg.4dm) [^hb]
* [replace _O_ENABLE_BUTTON](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/macro_replace_enable_button.4dm) [^eb]
* [replace _O_OBJECT SET COLOR](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/macro_replace_object_set_color.4dm) [^sc]
* [unselect on close box form event](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/remove_close_box_event.4dm)

> after migrating from `Open window` to `Open form window`, you might want to unselect this form event so that the window naturally closes when the user clicks the close button. the code does not check whether the event is implemented in the form method. the assumption is that the event is not used in legacy databases that uses `Open window`.

* [unset_fixed window size](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/unset-fixed-window-size.4dm) [^fixed]

> after migrating from binary to project, you may want to allow modern resizing for forms that lost the legacy "with constraints" property. **Note**: This method applies to all forms. For a more granular implementation you may want to cross match against the conversion log.

* [remove old fonts](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/remove-old-fonts.4dm)

> after activating DirectWrite rendering on Windows, bitmap fonts may be trimmed on the edge.

* [convert PICT images to PNG](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/pict_to_png.4dm) [^pict]

* [remove mandatory field attribute](https://github.com/miyako/fixerupper/blob/main/FixerUpper/Project/Sources/Methods/set_mandatory.4dm) [^sm]
  
[^satolb]: [4D Forums, 14 Aug 2024](https://discuss.4d.com/t/tip-replace-legacy-connected-scrollable-areas/32072)
[^rbg]: [4D Forums, 9 Aug 2024](https://discuss.4d.com/t/tip-add-radio-group-to-converted-radio-buttons/32035)
[^bwauto]: [4D Forums, 9 Aug 2024](https://discuss.4d.com/t/tip-support-dark-mode-in-legacy-forms/32033)
[^hb]: [4D Forums, 11 Jul 2024](https://discuss.4d.com/t/replace-highlight-buttons-with-custom-svg-buttons/31719)
[^eb]: [4D Forums, 7 Aug 2024](https://discuss.4d.com/t/tip-translate-o-enable-button/32020)
[^sc]: [4D Forums, 30 Jul 2024](https://discuss.4d.com/t/tip-translate-o-object-set-color/31940)
[^fixed]: see [Form properties in Design Reference](https://doc.4d.com/4Dv19/4D/19/Form-properties.300-5416670.en.html)
[^pict]: [4D Forums, 17 Dec 2024](https://discuss.4d.com/t/tip-convert-pict-images-to-png/33546?u=keisuke_miyako)
[^sm]: [4D Forums, 7 Jun, 2023](https://discuss.4d.com/t/field-mandatory/27736/4?u=keisuke_miyako)
