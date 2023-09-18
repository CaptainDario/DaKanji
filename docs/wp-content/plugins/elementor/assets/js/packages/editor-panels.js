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

/***/ "@elementor/editor":
/*!***********************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editor"] ***!
  \***********************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editor"];

/***/ }),

/***/ "@elementor/editor-v1-adapters":
/*!*********************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editorV1Adapters"] ***!
  \*********************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editorV1Adapters"];

/***/ }),

/***/ "@elementor/locations":
/*!**************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","locations"] ***!
  \**************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["locations"];

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
/*!**************************************************************!*\
  !*** ./node_modules/@elementor/editor-panels/dist/index.mjs ***!
  \**************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "Panel": function() { return /* binding */ Panel; },
/* harmony export */   "PanelBody": function() { return /* binding */ PanelBody; },
/* harmony export */   "PanelHeader": function() { return /* binding */ PanelHeader; },
/* harmony export */   "PanelHeaderTitle": function() { return /* binding */ PanelHeaderTitle; },
/* harmony export */   "createPanel": function() { return /* binding */ createPanel; },
/* harmony export */   "registerPanel": function() { return /* binding */ registerPanel; }
/* harmony export */ });
/* harmony import */ var _elementor_editor__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @elementor/editor */ "@elementor/editor");
/* harmony import */ var _elementor_store__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @elementor/store */ "@elementor/store");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! react */ "react");
/* harmony import */ var _elementor_locations__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @elementor/locations */ "@elementor/locations");
/* harmony import */ var _elementor_ui__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @elementor/ui */ "@elementor/ui");
/* harmony import */ var _elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @elementor/editor-v1-adapters */ "@elementor/editor-v1-adapters");
// src/init.ts



// src/components/internal/panels.tsx


// src/hooks/use-open-panel-injection.ts


// src/location.ts

var {
  inject: injectIntoPanels,
  useInjections: usePanelsInjections
} = (0,_elementor_locations__WEBPACK_IMPORTED_MODULE_3__.createLocation)();

// src/store/selectors.ts
var selectOpenId = (state) => state.panels.openId;

// src/store/slice.ts

var initialState = {
  openId: null
};
var slice_default = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.createSlice)({
  name: "panels",
  initialState,
  reducers: {
    open(state, action) {
      state.openId = action.payload;
    },
    close(state, action) {
      if (!action.payload || state.openId === action.payload) {
        state.openId = null;
      }
    }
  }
});

// src/hooks/use-open-panel-injection.ts

function useOpenPanelInjection() {
  const injections = usePanelsInjections();
  const openId = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.useSelector)(selectOpenId);
  return (0,react__WEBPACK_IMPORTED_MODULE_2__.useMemo)(
    () => injections.find((injection) => openId === injection.id),
    [injections, openId]
  );
}

// src/components/internal/portal.tsx




// src/sync.ts


var V2_PANEL = "panel/v2";
function getPortalContainer() {
  return document.querySelector("#elementor-panel-inner");
}
function useV1PanelStatus() {
  return (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.useRouteStatus)(V2_PANEL, {
    blockOnKitRoutes: true,
    blockOnPreviewMode: true
  });
}
function sync() {
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.windowEvent)("elementor/panel/init"),
    () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.registerRoute)(V2_PANEL)
  );
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.routeOpenEvent)(V2_PANEL),
    () => {
      getV1PanelElements().forEach((el) => {
        el.setAttribute("hidden", "hidden");
        el.setAttribute("aria-hidden", "true");
      });
    }
  );
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.routeCloseEvent)(V2_PANEL),
    () => selectOpenId((0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.getState)()) && (0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.dispatch)(slice_default.actions.close())
  );
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.routeCloseEvent)(V2_PANEL),
    () => {
      getV1PanelElements().forEach((el) => {
        el.removeAttribute("hidden");
        el.removeAttribute("aria-hidden");
      });
    }
  );
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.windowEvent)("elementor/panel/init"),
    () => subscribe({
      on: (state) => selectOpenId(state),
      when: ({ prev, current }) => !!(!prev && current),
      // is panel opened
      callback: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.openRoute)(V2_PANEL)
    })
  );
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.windowEvent)("elementor/panel/init"),
    () => subscribe({
      on: (state) => selectOpenId(state),
      when: ({ prev, current }) => !!(!current && prev),
      // is panel closed
      callback: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.isRouteActive)(V2_PANEL) && (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_5__.openRoute)(getDefaultRoute())
    })
  );
}
function getV1PanelElements() {
  const v1ElementsSelector = [
    "#elementor-panel-header-wrapper",
    "#elementor-panel-content-wrapper",
    "#elementor-panel-state-loading",
    "#elementor-panel-footer"
  ].join(", ");
  return document.querySelectorAll(v1ElementsSelector);
}
function getDefaultRoute() {
  const defaultRoute = window?.elementor?.documents?.getCurrent?.()?.config?.panel?.default_route;
  return defaultRoute || "panel/elements/categories";
}
function subscribe({
  on,
  when,
  callback
}) {
  let prev;
  (0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.subscribe)(() => {
    const current = on((0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.getState)());
    if (when({ prev, current })) {
      callback({ prev, current });
    }
    prev = current;
  });
}

// src/components/internal/portal.tsx
function Portal(props) {
  const containerRef = (0,react__WEBPACK_IMPORTED_MODULE_2__.useRef)(getPortalContainer);
  if (!containerRef.current) {
    return null;
  }
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_4__.Portal, { container: containerRef.current, ...props });
}

// src/components/internal/panels.tsx
function Panels() {
  const openPanel = useOpenPanelInjection();
  const Component = openPanel?.filler ?? null;
  if (!Component) {
    return null;
  }
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(Portal, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(Component, null));
}

// src/init.ts
function init() {
  sync();
  (0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.registerSlice)(slice_default);
  (0,_elementor_editor__WEBPACK_IMPORTED_MODULE_0__.injectIntoTop)({ id: "panels", filler: Panels });
}

// src/api.ts

function createPanel({ id, component }) {
  const usePanelStatus = createUseStatus(id);
  const usePanelActions = createUseActions(id, usePanelStatus);
  return {
    panel: {
      id,
      component
    },
    usePanelStatus,
    usePanelActions
  };
}
function registerPanel({ id, component }) {
  injectIntoPanels({
    id,
    filler: component
  });
}
function createUseStatus(id) {
  return () => {
    const openPanelId = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.useSelector)(selectOpenId);
    const v1PanelStatus = useV1PanelStatus();
    return {
      isOpen: openPanelId === id && v1PanelStatus.isActive,
      isBlocked: v1PanelStatus.isBlocked
    };
  };
}
function createUseActions(id, useStatus) {
  return () => {
    const dispatch2 = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_1__.useDispatch)();
    const { isBlocked } = useStatus();
    return {
      open: async () => {
        if (isBlocked) {
          return;
        }
        dispatch2(slice_default.actions.open(id));
      },
      close: async () => {
        if (isBlocked) {
          return;
        }
        dispatch2(slice_default.actions.close(id));
      }
    };
  };
}

// src/components/external/panel.tsx


function Panel({ children, sx, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_4__.Drawer,
    {
      open: true,
      variant: "persistent",
      anchor: "left",
      PaperProps: {
        sx: {
          position: "relative",
          width: "100%",
          bgcolor: "background.default",
          border: "none"
        }
      },
      sx: { height: "100%", ...sx },
      ...props
    },
    children
  );
}

// src/components/external/panel-header.tsx


var Header = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_4__.styled)(_elementor_ui__WEBPACK_IMPORTED_MODULE_4__.Box)(({ theme }) => ({
  height: theme?.sizing?.["600"] || "48px",
  display: "flex",
  alignItems: "center",
  justifyContent: "center"
}));
function PanelHeader({ children, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(react__WEBPACK_IMPORTED_MODULE_2__.Fragment, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(Header, { component: "header", ...props }, children), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_4__.Divider, null));
}

// src/components/external/panel-header-title.tsx


var Title = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_4__.styled)(_elementor_ui__WEBPACK_IMPORTED_MODULE_4__.Typography)(({ theme }) => ({
  "&.MuiTypography-root": {
    fontWeight: "bold",
    fontSize: theme.typography.body1.fontSize
  }
}));
function PanelHeaderTitle({ children, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(
    Title,
    {
      component: "h2",
      variant: "body1",
      ...props
    },
    children
  );
}

// src/components/external/panel-body.tsx


function PanelBody({ children, sx, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_2__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_4__.Box,
    {
      component: "main",
      sx: {
        overflowY: "auto",
        height: "100%",
        ...sx
      },
      ...props
    },
    children
  );
}

// src/index.ts
init();

//# sourceMappingURL=index.mjs.map
}();
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).editorPanels = __webpack_exports__;
/******/ })()
;