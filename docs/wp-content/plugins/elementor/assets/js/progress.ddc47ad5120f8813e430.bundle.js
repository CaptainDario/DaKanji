/*! elementor - v3.15.0 - 20-08-2023 */
"use strict";
(self["webpackChunkelementor"] = self["webpackChunkelementor"] || []).push([["progress"],{

/***/ "../assets/dev/js/frontend/handlers/progress.js":
/*!******************************************************!*\
  !*** ../assets/dev/js/frontend/handlers/progress.js ***!
  \******************************************************/
/***/ ((__unused_webpack_module, exports) => {



Object.defineProperty(exports, "__esModule", ({
  value: true
}));
exports["default"] = void 0;
class Progress extends elementorModules.frontend.handlers.Base {
  getDefaultSettings() {
    return {
      selectors: {
        progressNumber: '.elementor-progress-bar'
      }
    };
  }
  getDefaultElements() {
    const selectors = this.getSettings('selectors');
    return {
      $progressNumber: this.$element.find(selectors.progressNumber)
    };
  }
  onInit() {
    super.onInit();
    elementorFrontend.waypoint(this.elements.$progressNumber, () => {
      const $progressbar = this.elements.$progressNumber;
      $progressbar.css('width', $progressbar.data('max') + '%');
    });
  }
}
exports["default"] = Progress;

/***/ })

}]);
//# sourceMappingURL=progress.ddc47ad5120f8813e430.bundle.js.map