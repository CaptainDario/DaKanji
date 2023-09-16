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

/***/ "@elementor/editor-v1-adapters":
/*!*********************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editorV1Adapters"] ***!
  \*********************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editorV1Adapters"];

/***/ }),

/***/ "@elementor/store":
/*!**********************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","store"] ***!
  \**********************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["store"];

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
/*!*****************************************************************!*\
  !*** ./node_modules/@elementor/editor-documents/dist/index.mjs ***!
  \*****************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "useActiveDocument": function() { return /* binding */ useActiveDocument; },
/* harmony export */   "useActiveDocumentActions": function() { return /* binding */ useActiveDocumentActions; },
/* harmony export */   "useHostDocument": function() { return /* binding */ useHostDocument; },
/* harmony export */   "useNavigateToDocument": function() { return /* binding */ useNavigateToDocument; }
/* harmony export */ });
/* harmony import */ var _elementor_store__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @elementor/store */ "@elementor/store");
/* harmony import */ var _elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @elementor/editor-v1-adapters */ "@elementor/editor-v1-adapters");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! react */ "react");
// src/store/index.ts

var initialState = {
  entities: {},
  activeId: null,
  hostId: null
};
function hasActiveEntity(state) {
  return !!(state.activeId && state.entities[state.activeId]);
}
var slice = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.createSlice)({
  name: "documents",
  initialState,
  reducers: {
    init(state, { payload }) {
      state.entities = payload.entities;
      state.hostId = payload.hostId;
      state.activeId = payload.activeId;
    },
    activateDocument(state, action) {
      state.entities[action.payload.id] = action.payload;
      state.activeId = action.payload.id;
    },
    setAsHost(state, action) {
      state.hostId = action.payload;
    },
    updateActiveDocument(state, action) {
      if (hasActiveEntity(state)) {
        state.entities[state.activeId] = {
          ...state.entities[state.activeId],
          ...action.payload
        };
      }
    },
    startSaving(state) {
      if (hasActiveEntity(state)) {
        state.entities[state.activeId].isSaving = true;
      }
    },
    endSaving(state, action) {
      if (hasActiveEntity(state)) {
        state.entities[state.activeId] = {
          ...action.payload,
          isSaving: false
        };
      }
    },
    startSavingDraft: (state) => {
      if (hasActiveEntity(state)) {
        state.entities[state.activeId].isSavingDraft = true;
      }
    },
    endSavingDraft(state, action) {
      if (hasActiveEntity(state)) {
        state.entities[state.activeId] = {
          ...action.payload,
          isSavingDraft: false
        };
      }
    },
    markAsDirty(state) {
      if (hasActiveEntity(state)) {
        state.entities[state.activeId].isDirty = true;
      }
    },
    markAsPristine(state) {
      if (hasActiveEntity(state)) {
        state.entities[state.activeId].isDirty = false;
      }
    }
  }
});

// src/sync/sync-store.ts


// src/sync/utils.ts
function getV1DocumentsManager() {
  const documentsManager = window.elementor?.documents;
  if (!documentsManager) {
    throw new Error("Elementor Editor V1 documents manager not found");
  }
  return documentsManager;
}
function normalizeV1Document(documentData) {
  const isUnpublishedRevision = documentData.config.revisions.current_id !== documentData.id;
  return {
    id: documentData.id,
    title: documentData.container.settings.get("post_title"),
    type: {
      value: documentData.config.type,
      label: documentData.config.panel.title
    },
    status: {
      value: documentData.config.status.value,
      label: documentData.config.status.label
    },
    links: {
      platformEdit: documentData.config.urls.exit_to_dashboard
    },
    isDirty: documentData.editor.isChanged || isUnpublishedRevision,
    isSaving: documentData.editor.isSaving,
    isSavingDraft: false,
    userCan: {
      publish: documentData.config.user.can_publish
    }
  };
}

// src/sync/sync-store.ts

function syncStore() {
  syncInitialization();
  syncActiveDocument();
  syncOnDocumentSave();
  syncOnTitleChange();
  syncOnDocumentChange();
}
function syncInitialization() {
  const { init: init2 } = slice.actions;
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.v1ReadyEvent)(),
    () => {
      const documentsManager = getV1DocumentsManager();
      const entities = Object.entries(documentsManager.documents).reduce((acc, [id, document]) => {
        acc[id] = normalizeV1Document(document);
        return acc;
      }, {});
      (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(init2({
        entities,
        hostId: documentsManager.getInitialId(),
        activeId: documentsManager.getCurrentId()
      }));
    }
  );
}
function syncActiveDocument() {
  const { activateDocument, setAsHost } = slice.actions;
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.commandEndEvent)("editor/documents/open"),
    () => {
      const documentsManager = getV1DocumentsManager();
      const currentDocument = normalizeV1Document(documentsManager.getCurrent());
      (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(activateDocument(currentDocument));
      if (documentsManager.getInitialId() === currentDocument.id) {
        (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(setAsHost(currentDocument.id));
      }
    }
  );
}
function syncOnDocumentSave() {
  const { startSaving, endSaving, startSavingDraft, endSavingDraft } = slice.actions;
  const isDraft = (e) => {
    const event = e;
    return event.args?.status === "autosave";
  };
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.commandStartEvent)("document/save/save"),
    (e) => {
      if (isDraft(e)) {
        (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(startSavingDraft());
        return;
      }
      (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(startSaving());
    }
  );
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.commandEndEvent)("document/save/save"),
    (e) => {
      const activeDocument = normalizeV1Document(
        getV1DocumentsManager().getCurrent()
      );
      if (isDraft(e)) {
        (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(endSavingDraft(activeDocument));
      } else {
        (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(endSaving(activeDocument));
      }
    }
  );
}
function syncOnTitleChange() {
  const { updateActiveDocument } = slice.actions;
  const updateTitle = debounce((e) => {
    const event = e;
    if (!("post_title" in event.args?.settings)) {
      return;
    }
    const currentDocument = getV1DocumentsManager().getCurrent();
    const newTitle = currentDocument.container.settings.get("post_title");
    (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(updateActiveDocument({ title: newTitle }));
  }, 400);
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.commandEndEvent)("document/elements/settings"),
    updateTitle
  );
}
function syncOnDocumentChange() {
  const { markAsDirty, markAsPristine } = slice.actions;
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.commandEndEvent)("document/save/set-is-modified"),
    () => {
      const currentDocument = getV1DocumentsManager().getCurrent();
      if (currentDocument.editor.isChanged) {
        (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(markAsDirty());
        return;
      }
      (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.dispatch)(markAsPristine());
    }
  );
}
function debounce(fn, timeout) {
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => {
      fn(...args);
    }, timeout);
  };
}

// src/init.ts

function init() {
  initStore();
}
function initStore() {
  (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.registerSlice)(slice);
  syncStore();
}

// src/hooks/use-active-document.ts


// src/store/selectors.ts

var selectEntities = (state) => state.documents.entities;
var selectActiveId = (state) => state.documents.activeId;
var selectHostId = (state) => state.documents.hostId;
var selectActiveDocument = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.createSelector)(
  selectEntities,
  selectActiveId,
  (entities, activeId) => activeId && entities[activeId] ? entities[activeId] : null
);
var selectHostDocument = (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.createSelector)(
  selectEntities,
  selectHostId,
  (entities, hostId) => hostId && entities[hostId] ? entities[hostId] : null
);

// src/hooks/use-active-document.ts
function useActiveDocument() {
  return (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.useSelector)(selectActiveDocument);
}

// src/hooks/use-active-document-actions.ts


function useActiveDocumentActions() {
  const save = (0,react__WEBPACK_IMPORTED_MODULE_2__.useCallback)(() => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.runCommand)("document/save/default"), []);
  const saveDraft = (0,react__WEBPACK_IMPORTED_MODULE_2__.useCallback)(() => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.runCommand)("document/save/draft"), []);
  const saveTemplate = (0,react__WEBPACK_IMPORTED_MODULE_2__.useCallback)(() => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.openRoute)("library/save-template"), []);
  return {
    save,
    saveDraft,
    saveTemplate
  };
}

// src/hooks/use-host-document.ts

function useHostDocument() {
  return (0,_elementor_store__WEBPACK_IMPORTED_MODULE_0__.useSelector)(selectHostDocument);
}

// src/hooks/use-navigate-to-document.ts


function useNavigateToDocument() {
  return (0,react__WEBPACK_IMPORTED_MODULE_2__.useCallback)(async (id) => {
    await (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_1__.runCommand)("editor/documents/switch", {
      id,
      setAsInitial: true
    });
    const url = new URL(window.location.href);
    url.searchParams.set("post", id.toString());
    url.searchParams.delete("active-document");
    history.replaceState({}, "", url);
  }, []);
}

// src/index.ts
init();

//# sourceMappingURL=index.mjs.map
}();
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).editorDocuments = __webpack_exports__;
/******/ })()
;