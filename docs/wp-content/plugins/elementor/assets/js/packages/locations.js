/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "react":
/*!************************!*\
  !*** external "React" ***!
  \************************/
/***/ (function(module) {

module.exports = window["React"];

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	!function() {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = function(exports, definition) {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	!function() {
/******/ 		__webpack_require__.o = function(obj, prop) { return Object.prototype.hasOwnProperty.call(obj, prop); }
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	!function() {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = function(exports) {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	}();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be isolated against other modules in the chunk.
!function() {
/*!**********************************************************!*\
  !*** ./node_modules/@elementor/locations/dist/index.mjs ***!
  \**********************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "createLocation": function() { return /* binding */ createLocation; },
/* harmony export */   "flushAllInjections": function() { return /* binding */ flushAllInjections; }
/* harmony export */ });
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react */ "react");
// src/api.tsx


// src/components/filler-wrapper.tsx



// src/components/error-boundary.tsx

var ErrorBoundary = class extends react__WEBPACK_IMPORTED_MODULE_0__.Component {
  state = {
    hasError: false
  };
  static getDerivedStateFromError() {
    return { hasError: true };
  }
  render() {
    if (this.state.hasError) {
      return this.props.fallback;
    }
    return this.props.children;
  }
};

// src/components/filler-wrapper.tsx
function FillerWrapper({ children }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ErrorBoundary, { fallback: null }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(react__WEBPACK_IMPORTED_MODULE_0__.Suspense, { fallback: null }, children));
}

// src/api.tsx

var DEFAULT_PRIORITY = 10;
var flushInjectionsFns = [];
function createLocation() {
  const injections = /* @__PURE__ */ new Map();
  const getInjections = createGetInjections(injections);
  const useInjections = createUseInjections(getInjections);
  const Slot = createSlot(useInjections);
  const inject = createInject(injections);
  flushInjectionsFns.push(() => injections.clear());
  return {
    inject,
    getInjections,
    useInjections,
    Slot
  };
}
function flushAllInjections() {
  flushInjectionsFns.forEach((flush) => flush());
}
function wrapFiller(FillerComponent) {
  return (props) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(FillerWrapper, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(FillerComponent, { ...props }));
}
function createSlot(useInjections) {
  return (props) => {
    const injections = useInjections();
    return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(react__WEBPACK_IMPORTED_MODULE_0__.Fragment, null, injections.map(({ id, filler: Component2 }) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Component2, { ...props, key: id })));
  };
}
function createGetInjections(injections) {
  return () => [...injections.values()].sort((a, b) => a.priority - b.priority);
}
function createInject(injections) {
  return ({ filler, id, options = {} }) => {
    if (injections.has(id) && !options?.overwrite) {
      console.error(
        `An injection with the id "${id}" already exists. Did you mean to use "options.overwrite"?`
      );
      return;
    }
    injections.set(id, {
      id,
      filler: wrapFiller(filler),
      priority: options.priority ?? DEFAULT_PRIORITY
    });
  };
}
function createUseInjections(getInjections) {
  return () => (0,react__WEBPACK_IMPORTED_MODULE_0__.useMemo)(() => getInjections(), []);
}

//# sourceMappingURL=index.mjs.map
}();
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).locations = __webpack_exports__;
/******/ })()
;