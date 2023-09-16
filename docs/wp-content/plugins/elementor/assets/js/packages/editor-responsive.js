/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "react":
/*!************************!*\
  !*** external "React" ***!
  \************************/
/***/ (function(module) {

module.exports = window["React"];

/***/ }),

/***/ "@elementor/editor-app-bar":
/*!*****************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editorAppBar"] ***!
  \*****************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editorAppBar"];

/***/ }),

/***/ "@elementor/editor-v1-adapters":
/*!*********************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editorV1Adapters"] ***!
  \*********************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editorV1Adapters"];

/***/ }),

/***/ "@elementor/icons":
/*!**********************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","icons"] ***!
  \**********************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["icons"];

/***/ }),

/***/ "@elementor/store":
/*!**********************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","store"] ***!
  \**********************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["store"];

/***/ }),

/***/ "@elementor/ui":
/*!*******************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","ui"] ***!
  \*******************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["ui"];

/***/ }),

/***/ "@wordpress/i18n":
/*!******************************!*\
  !*** external ["wp","i18n"] ***!
  \******************************/
/***/ (function(module) {

module.exports = window["wp"]["i18n"];

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
/*!******************************************************************!*\
  !*** ./node_modules/@elementor/editor-responsive/dist/index.mjs ***!
  \******************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _elementor_store__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @elementor/store */ "@elementor/store");
/* harmony import */ var _elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @elementor/editor-v1-adapters */ "@elementor/editor-v1-adapters");
/* harmony import */ var _wordpress_i18n__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @wordpress/i18n */ "@wordpress/i18n");
/* harmony import */ var _elementor_editor_app_bar__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @elementor/editor-app-bar */ "@elementor/editor-app-bar");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! react */ "react");
/* harmony import */ var _elementor_ui__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @elementor/ui */ "@elementor/ui");
/* harmony import */ var _elementor_icons__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @elementor/icons */ "@elementor/icons");
// src/store/index.ts

var initialState = {
  entities: {},
  activeId: null
};
var slice = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.createSlice)({
  name: "breakpoints",
  initialState,
  reducers: {
    init(state, action) {
      state.activeId = action.payload.activeId;
      state.entities = normalizeEntities(action.payload.entities);
    },
    activateBreakpoint(state, action) {
      if (state.entities[action.payload]) {
        state.activeId = action.payload;
      }
    }
  }
});
function normalizeEntities(entities) {
  return entities.reduce((acc, breakpoint) => {
    return {
      ...acc,
      [breakpoint.id]: breakpoint
    };
  }, {});
}

// src/sync/sync-store.ts



function syncStore() {
  syncInitialization();
  syncOnChange();
}
function syncInitialization() {
  const { init: init2 } = slice.actions;
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.v1ReadyEvent)(),
    () => {
      (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(init2({
        entities: getBreakpoints(),
        activeId: getActiveBreakpoint()
      }));
    }
  );
}
function syncOnChange() {
  const { activateBreakpoint } = slice.actions;
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    deviceModeChangeEvent(),
    () => {
      const activeBreakpoint = getActiveBreakpoint();
      (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(activateBreakpoint(activeBreakpoint));
    }
  );
}
function getBreakpoints() {
  const { breakpoints } = window.elementor?.config?.responsive || {};
  if (!breakpoints) {
    return [];
  }
  const entities = Object.entries(breakpoints).filter(([, breakpoint]) => breakpoint.is_enabled).map(([id, { value, direction, label }]) => {
    return {
      id,
      label,
      width: value,
      type: direction === "min" ? "min-width" : "max-width"
    };
  });
  entities.push({
    id: "desktop",
    label: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_2__.__)("Desktop", "elementor")
  });
  return entities;
}
function getActiveBreakpoint() {
  const extendedWindow = window;
  return extendedWindow.elementor?.channels?.deviceMode?.request?.("currentMode") || null;
}
function deviceModeChangeEvent() {
  return (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.windowEvent)("elementor/device-mode/change");
}

// src/init.ts


// src/components/breakpoints-switcher.tsx



// src/hooks/use-breakpoints.ts


// src/store/selectors.ts

var selectEntities = (state) => state.breakpoints.entities;
var selectActiveId = (state) => state.breakpoints.activeId;
var selectActiveBreakpoint = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.createSelector)(
  selectEntities,
  selectActiveId,
  (entities, activeId) => activeId && entities[activeId] ? entities[activeId] : null
);
var selectSortedBreakpoints = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.createSelector)(
  selectEntities,
  (entities) => {
    const byWidth = (a, b) => {
      return a.width && b.width ? b.width - a.width : 0;
    };
    const all = Object.values(entities);
    const defaults = all.filter((breakpoint) => !breakpoint.width);
    const minWidth = all.filter((breakpoint) => breakpoint.type === "min-width");
    const maxWidth = all.filter((breakpoint) => breakpoint.type === "max-width");
    return [
      ...minWidth.sort(byWidth),
      ...defaults,
      ...maxWidth.sort(byWidth)
    ];
  }
);

// src/hooks/use-breakpoints.ts
function useBreakpoints() {
  const all = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.useSelector)(selectSortedBreakpoints);
  const active = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.useSelector)(selectActiveBreakpoint);
  return {
    all,
    active
  };
}

// src/components/breakpoints-switcher.tsx



// src/hooks/use-breakpoints-actions.ts


function useBreakpointsActions() {
  const activate = (0,react__WEBPACK_IMPORTED_MODULE_4__.useCallback)((device) => {
    return (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.runCommand)("panel/change-device-mode", { device });
  }, []);
  return {
    activate
  };
}

// src/components/breakpoints-switcher.tsx
function BreakpointsSwitcher() {
  const { all, active } = useBreakpoints();
  const { activate } = useBreakpointsActions();
  if (!all.length || !active) {
    return null;
  }
  const onChange = (_, value) => activate(value);
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_4__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_5__.Tabs, { value: active.id, onChange, "aria-label": (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_2__.__)("Switch Device", "elementor") }, all.map(({ id, label, type, width }) => {
    const Icon = iconsMap[id];
    const title = labelsMap[type || "default"].replace("%s", label).replace("%d", width?.toString() || "");
    return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_4__.createElement(
      _elementor_ui__WEBPACK_IMPORTED_MODULE_5__.Tab,
      {
        value: id,
        key: id,
        "aria-label": title,
        icon: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_4__.createElement(Tooltip, { title }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_4__.createElement(Icon, null))
      }
    );
  }));
}
function Tooltip(props) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_4__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_5__.Tooltip,
    {
      PopperProps: {
        sx: {
          "&.MuiTooltip-popper .MuiTooltip-tooltip.MuiTooltip-tooltipPlacementBottom": {
            mt: 7
          }
        }
      },
      ...props
    }
  );
}
var iconsMap = {
  widescreen: _elementor_icons__WEBPACK_IMPORTED_MODULE_6__.WidescreenIcon,
  desktop: _elementor_icons__WEBPACK_IMPORTED_MODULE_6__.DesktopIcon,
  laptop: _elementor_icons__WEBPACK_IMPORTED_MODULE_6__.LaptopIcon,
  tablet_extra: _elementor_icons__WEBPACK_IMPORTED_MODULE_6__.TabletLandscapeIcon,
  tablet: _elementor_icons__WEBPACK_IMPORTED_MODULE_6__.TabletPortraitIcon,
  mobile_extra: _elementor_icons__WEBPACK_IMPORTED_MODULE_6__.MobileLandscapeIcon,
  mobile: _elementor_icons__WEBPACK_IMPORTED_MODULE_6__.MobilePortraitIcon
};
var labelsMap = {
  default: "%s",
  // translators: %s: Breakpoint label, %d: Breakpoint size.
  "min-width": (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_2__.__)("%s (%dpx and up)", "elementor"),
  // translators: %s: Breakpoint label, %d: Breakpoint size.
  "max-width": (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_2__.__)("%s (up to %dpx)", "elementor")
};

// src/init.ts

function init() {
  initStore();
  registerAppBarUI();
}
function initStore() {
  (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.registerSlice)(slice);
  syncStore();
}
function registerAppBarUI() {
  (0,_elementor_editor_app_bar__WEBPACK_IMPORTED_MODULE_3__.injectIntoResponsive)({
    id: "responsive-breakpoints-switcher",
    filler: BreakpointsSwitcher,
    options: {
      priority: 20
      // After document indication.
    }
  });
}

// src/index.ts
init();
//# sourceMappingURL=index.mjs.map
}();
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).editorResponsive = __webpack_exports__;
/******/ })()
;