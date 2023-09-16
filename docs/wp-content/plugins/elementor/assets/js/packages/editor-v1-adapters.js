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
/*!*******************************************************************!*\
  !*** ./node_modules/@elementor/editor-v1-adapters/dist/index.mjs ***!
  \*******************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "commandEndEvent": function() { return /* binding */ commandEndEvent; },
/* harmony export */   "commandStartEvent": function() { return /* binding */ commandStartEvent; },
/* harmony export */   "dispatchReadyEvent": function() { return /* binding */ dispatchReadyEvent; },
/* harmony export */   "editModeChangeEvent": function() { return /* binding */ editModeChangeEvent; },
/* harmony export */   "flushListeners": function() { return /* binding */ flushListeners; },
/* harmony export */   "getCurrentEditMode": function() { return /* binding */ getCurrentEditMode; },
/* harmony export */   "isReady": function() { return /* binding */ isReady; },
/* harmony export */   "isRouteActive": function() { return /* binding */ isRouteActive; },
/* harmony export */   "listenTo": function() { return /* binding */ listenTo; },
/* harmony export */   "openRoute": function() { return /* binding */ openRoute; },
/* harmony export */   "registerRoute": function() { return /* binding */ registerRoute; },
/* harmony export */   "routeCloseEvent": function() { return /* binding */ routeCloseEvent; },
/* harmony export */   "routeOpenEvent": function() { return /* binding */ routeOpenEvent; },
/* harmony export */   "runCommand": function() { return /* binding */ runCommand; },
/* harmony export */   "setReady": function() { return /* binding */ setReady; },
/* harmony export */   "useIsPreviewMode": function() { return /* binding */ useIsPreviewMode; },
/* harmony export */   "useIsRouteActive": function() { return /* binding */ useIsRouteActive; },
/* harmony export */   "useListenTo": function() { return /* binding */ useListenTo; },
/* harmony export */   "useRouteStatus": function() { return /* binding */ useRouteStatus; },
/* harmony export */   "v1ReadyEvent": function() { return /* binding */ v1ReadyEvent; },
/* harmony export */   "windowEvent": function() { return /* binding */ windowEvent; }
/* harmony export */ });
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react */ "react");
// src/dispatchers/utils.ts
function isJQueryDeferred(value) {
  return !!value && "object" === typeof value && Object.hasOwn(value, "promise") && Object.hasOwn(value, "then") && Object.hasOwn(value, "fail");
}
function promisifyJQueryDeferred(deferred) {
  return new Promise((resolve, reject) => {
    deferred.then(resolve, reject);
  });
}

// src/dispatchers/dispatchers.ts
function runCommand(command, args) {
  const extendedWindow = window;
  if (!extendedWindow.$e?.run) {
    return Promise.reject("`$e.run()` is not available");
  }
  const result = extendedWindow.$e.run(command, args);
  if (result instanceof Promise) {
    return result;
  }
  if (isJQueryDeferred(result)) {
    return promisifyJQueryDeferred(result);
  }
  return Promise.resolve(result);
}
function openRoute(route) {
  const extendedWindow = window;
  if (!extendedWindow.$e?.route) {
    return Promise.reject("`$e.route()` is not available");
  }
  try {
    return Promise.resolve(
      extendedWindow.$e.route(route)
    );
  } catch (e) {
    return Promise.reject(e);
  }
}
function registerRoute(route) {
  const extendedWindow = window;
  if (!extendedWindow.$e?.routes?.register) {
    return Promise.reject("`$e.routes.register()` is not available");
  }
  const routeParts = route.split("/");
  if (routeParts.length < 2) {
    return Promise.reject(`\`${route}\` is an invalid route`);
  }
  const componentRoute = routeParts.pop();
  const component = routeParts.join("/");
  try {
    return Promise.resolve(
      extendedWindow.$e.routes.register(component, componentRoute, () => null)
    );
  } catch (e) {
    return Promise.reject(e);
  }
}

// src/hooks/use-listen-to.ts


// src/listeners/event-creators.ts
var commandStartEvent = (command) => {
  return {
    type: "command",
    name: command,
    state: "before"
  };
};
var commandEndEvent = (command) => {
  return {
    type: "command",
    name: command,
    state: "after"
  };
};
var routeOpenEvent = (route) => {
  return {
    type: "route",
    name: route,
    state: "open"
  };
};
var routeCloseEvent = (route) => {
  return {
    type: "route",
    name: route,
    state: "close"
  };
};
var windowEvent = (event) => {
  return {
    type: "window-event",
    name: event
  };
};
var v1ReadyEvent = () => {
  return windowEvent("elementor/initialized");
};
var editModeChangeEvent = () => {
  return windowEvent("elementor/edit-mode/change");
};

// src/listeners/is-ready.ts
var ready = false;
function isReady() {
  return ready;
}
function setReady(value) {
  ready = value;
}

// src/listeners/utils.ts
function dispatchReadyEvent() {
  return getV1LoadingPromise().then(() => {
    setReady(true);
    window.dispatchEvent(new CustomEvent("elementor/initialized"));
  });
}
function getV1LoadingPromise() {
  const v1LoadingPromise = window.__elementorEditorV1LoadingPromise;
  if (!v1LoadingPromise) {
    return Promise.reject("Elementor Editor V1 is not loaded");
  }
  return v1LoadingPromise;
}
function normalizeEvent(e) {
  if (e instanceof CustomEvent && e.detail?.command) {
    return {
      type: "command",
      command: e.detail.command,
      args: e.detail.args,
      originalEvent: e
    };
  }
  if (e instanceof CustomEvent && e.detail?.route) {
    return {
      type: "route",
      route: e.detail.route,
      originalEvent: e
    };
  }
  return {
    type: "window-event",
    event: e.type,
    originalEvent: e
  };
}

// src/listeners/listeners.ts
var callbacksByEvent = /* @__PURE__ */ new Map();
var abortController = new AbortController();
function listenTo(eventDescriptors, callback) {
  if (!Array.isArray(eventDescriptors)) {
    eventDescriptors = [eventDescriptors];
  }
  const cleanups = eventDescriptors.map((event) => {
    const { type, name } = event;
    switch (type) {
      case "command":
        return registerCommandListener(name, event.state, callback);
      case "route":
        return registerRouteListener(name, event.state, callback);
      case "window-event":
        return registerWindowEventListener(name, callback);
    }
  });
  return () => {
    cleanups.forEach((cleanup) => cleanup());
  };
}
function flushListeners() {
  abortController.abort();
  callbacksByEvent.clear();
  setReady(false);
  abortController = new AbortController();
}
function registerCommandListener(command, state, callback) {
  return registerWindowEventListener(`elementor/commands/run/${state}`, (e) => {
    const shouldRunCallback = e.type === "command" && e.command === command;
    if (shouldRunCallback) {
      callback(e);
    }
  });
}
function registerRouteListener(route, state, callback) {
  return registerWindowEventListener(`elementor/routes/${state}`, (e) => {
    const shouldRunCallback = e.type === "route" && e.route.startsWith(route);
    if (shouldRunCallback) {
      callback(e);
    }
  });
}
function registerWindowEventListener(event, callback) {
  const isFirstListener = !callbacksByEvent.has(event);
  if (isFirstListener) {
    callbacksByEvent.set(event, []);
    addListener(event);
  }
  callbacksByEvent.get(event)?.push(callback);
  return () => {
    const callbacks = callbacksByEvent.get(event);
    if (!callbacks?.length) {
      return;
    }
    const filtered = callbacks.filter((cb) => cb !== callback);
    callbacksByEvent.set(event, filtered);
  };
}
function addListener(event) {
  window.addEventListener(
    event,
    makeEventHandler(event),
    { signal: abortController.signal }
  );
}
function makeEventHandler(event) {
  return (e) => {
    if (!isReady()) {
      return;
    }
    const normalizedEvent = normalizeEvent(e);
    callbacksByEvent.get(event)?.forEach((callback) => {
      callback(normalizedEvent);
    });
  };
}

// src/hooks/use-listen-to.ts
function useListenTo(event, getSnapshot, deps = []) {
  const [snapshot, setSnapshot] = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)(() => getSnapshot());
  (0,react__WEBPACK_IMPORTED_MODULE_0__.useEffect)(() => {
    const updateState = () => setSnapshot(getSnapshot());
    updateState();
    return listenTo(event, updateState);
  }, deps);
  return snapshot;
}

// src/readers/index.ts
function isRouteActive(route) {
  const extendedWindow = window;
  return !!extendedWindow.$e?.routes?.isPartOf(route);
}
function getCurrentEditMode() {
  const extendedWindow = window;
  return extendedWindow.elementor?.channels?.dataEditMode?.request?.("activeMode");
}

// src/hooks/use-is-preview-mode.ts
function useIsPreviewMode() {
  return useListenTo(
    editModeChangeEvent(),
    () => getCurrentEditMode() === "preview"
  );
}

// src/hooks/use-is-route-active.ts
function useIsRouteActive(route) {
  return useListenTo(
    [
      routeOpenEvent(route),
      routeCloseEvent(route)
    ],
    () => isRouteActive(route),
    [route]
  );
}

// src/hooks/use-route-status.ts
function useRouteStatus(route, {
  blockOnKitRoutes = true,
  blockOnPreviewMode = true
} = {}) {
  const isRouteActive2 = useIsRouteActive(route);
  const isKitRouteActive = useIsRouteActive("panel/global");
  const isPreviewMode = useIsPreviewMode();
  const isActive = isRouteActive2 && !(blockOnPreviewMode && isPreviewMode);
  const isBlocked = blockOnPreviewMode && isPreviewMode || blockOnKitRoutes && isKitRouteActive;
  return {
    isActive,
    isBlocked
  };
}

//# sourceMappingURL=index.mjs.map
}();
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).editorV1Adapters = __webpack_exports__;
/******/ })()
;