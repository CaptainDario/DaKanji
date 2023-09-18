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

/***/ "@elementor/editor-documents":
/*!********************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editorDocuments"] ***!
  \********************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editorDocuments"];

/***/ }),

/***/ "@elementor/editor-panels":
/*!*****************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editorPanels"] ***!
  \*****************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editorPanels"];

/***/ }),

/***/ "@elementor/env":
/*!********************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","env"] ***!
  \********************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["env"];

/***/ }),

/***/ "@elementor/icons":
/*!**********************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","icons"] ***!
  \**********************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["icons"];

/***/ }),

/***/ "@elementor/query":
/*!**********************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","query"] ***!
  \**********************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["query"];

/***/ }),

/***/ "@elementor/ui":
/*!*******************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","ui"] ***!
  \*******************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["ui"];

/***/ }),

/***/ "@wordpress/api-fetch":
/*!**********************************!*\
  !*** external ["wp","apiFetch"] ***!
  \**********************************/
/***/ (function(module) {

module.exports = window["wp"]["apiFetch"];

/***/ }),

/***/ "@wordpress/i18n":
/*!******************************!*\
  !*** external ["wp","i18n"] ***!
  \******************************/
/***/ (function(module) {

module.exports = window["wp"]["i18n"];

/***/ }),

/***/ "@wordpress/url":
/*!*****************************!*\
  !*** external ["wp","url"] ***!
  \*****************************/
/***/ (function(module) {

module.exports = window["wp"]["url"];

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
/*!***********************************************************************!*\
  !*** ./node_modules/@elementor/editor-site-navigation/dist/index.mjs ***!
  \***********************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "extendIconsMap": function() { return /* binding */ extendIconsMap; }
/* harmony export */ });
/* harmony import */ var _elementor_icons__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @elementor/icons */ "@elementor/icons");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! react */ "react");
/* harmony import */ var _elementor_ui__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @elementor/ui */ "@elementor/ui");
/* harmony import */ var _elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @elementor/editor-documents */ "@elementor/editor-documents");
/* harmony import */ var _wordpress_api_fetch__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @wordpress/api-fetch */ "@wordpress/api-fetch");
/* harmony import */ var _wordpress_url__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @wordpress/url */ "@wordpress/url");
/* harmony import */ var _wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @wordpress/i18n */ "@wordpress/i18n");
/* harmony import */ var _elementor_editor_app_bar__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @elementor/editor-app-bar */ "@elementor/editor-app-bar");
/* harmony import */ var _elementor_editor_panels__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! @elementor/editor-panels */ "@elementor/editor-panels");
/* harmony import */ var _elementor_query__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! @elementor/query */ "@elementor/query");
/* harmony import */ var _elementor_env__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! @elementor/env */ "@elementor/env");
// src/icons-map.ts

var initialIconsMap = {
  page: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PageTemplateIcon,
  section: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.SectionTemplateIcon,
  container: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.ContainerTemplateIcon,
  "wp-page": _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PageTypeIcon,
  "wp-post": _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PostTypeIcon
};
var iconsMap = { ...initialIconsMap };
function extendIconsMap(additionalIcons) {
  Object.assign(iconsMap, additionalIcons);
}
function getIconsMap() {
  return iconsMap;
}

// src/components/top-bar/recently-edited.tsx





// src/components/top-bar/indicator.tsx


function Indicator({ title, status }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(Tooltip, { title }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Stack, { direction: "row", alignItems: "center", spacing: 2 }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Typography, { variant: "body2", sx: { maxWidth: "120px" }, noWrap: true }, title), status.value !== "publish" && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Typography, { variant: "body2", sx: { fontStyle: "italic" } }, "(", status.label, ")")));
}
function Tooltip(props) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Tooltip,
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

// src/hooks/use-recent-posts.ts



var endpointPath = "/elementor/v1/site-navigation/recent-posts";
function useRecentPosts(documentId) {
  const [recentPosts, setRecentPosts] = (0,react__WEBPACK_IMPORTED_MODULE_1__.useState)([]);
  const [isLoading, setIsLoading] = (0,react__WEBPACK_IMPORTED_MODULE_1__.useState)(false);
  (0,react__WEBPACK_IMPORTED_MODULE_1__.useEffect)(() => {
    if (documentId) {
      setIsLoading(true);
      fetchRecentlyEditedPosts(documentId).then((posts) => {
        setRecentPosts(posts);
        setIsLoading(false);
      });
    }
  }, [documentId]);
  return {
    isLoading,
    recentPosts
  };
}
async function fetchRecentlyEditedPosts(documentId) {
  const queryParams = {
    posts_per_page: 5,
    post__not_in: documentId
  };
  return await _wordpress_api_fetch__WEBPACK_IMPORTED_MODULE_4__({
    path: (0,_wordpress_url__WEBPACK_IMPORTED_MODULE_5__.addQueryArgs)(endpointPath, queryParams)
  }).then((response) => response).catch(() => []);
}

// src/components/top-bar/recently-edited.tsx


// src/components/top-bar/chip-doc-type.tsx



var iconsMap2 = getIconsMap();
function DocTypeChip({ postType, docType, label }) {
  const color = "elementor_library" === postType ? "global" : "primary";
  const Icon = iconsMap2[docType] || _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PostTypeIcon;
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Chip,
    {
      size: "medium",
      variant: "standard",
      label,
      color,
      icon: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(Icon, null),
      sx: { ml: 3 }
    }
  );
}

// src/components/top-bar/post-list-item.tsx




// src/hooks/use-reverse-html-entities.ts

function useReverseHtmlEntities(escapedHTML = "") {
  return (0,react__WEBPACK_IMPORTED_MODULE_1__.useMemo)(() => {
    const textarea = document.createElement("textarea");
    textarea.innerHTML = escapedHTML;
    const { value } = textarea;
    textarea.remove();
    return value;
  }, [escapedHTML]);
}

// src/components/top-bar/post-list-item.tsx
function PostListItem({ post, closePopup }) {
  const navigateToDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__.useNavigateToDocument)();
  const postTitle = useReverseHtmlEntities(post.title);
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.MenuItem, { dense: true, sx: { width: "100%" }, onClick: () => {
    closePopup();
    navigateToDocument(post.id);
  } }, postTitle, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(DocTypeChip, { postType: post.type.post_type, docType: post.type.doc_type, label: post.type.label }));
}

// src/components/top-bar/create-post-list-item.tsx



// src/hooks/use-create-page.ts


var endpointPath2 = "/elementor/v1/site-navigation/add-new-post";
function useCreatePage() {
  const [isLoading, setIsLoading] = (0,react__WEBPACK_IMPORTED_MODULE_1__.useState)(false);
  return {
    create: () => {
      setIsLoading(true);
      return addNewPage().then((newPost) => newPost).finally(() => setIsLoading(false));
    },
    isLoading
  };
}
async function addNewPage() {
  return await _wordpress_api_fetch__WEBPACK_IMPORTED_MODULE_4__({
    path: endpointPath2,
    method: "POST",
    data: { post_type: "page" }
  });
}

// src/components/top-bar/create-post-list-item.tsx



function CreatePostListItem({ closePopup }) {
  const { create, isLoading } = useCreatePage();
  const navigateToDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__.useNavigateToDocument)();
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.MenuItem, { dense: true, size: "small", color: "inherit", component: "div", onClick: async () => {
    const { id } = await create();
    closePopup();
    navigateToDocument(id);
  } }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemIcon, null, isLoading ? /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.CircularProgress, null) : /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PlusIcon, null)), (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Add new page", "elementor"));
}

// src/components/top-bar/recently-edited.tsx
function RecentlyEdited() {
  const activeDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__.useActiveDocument)();
  const hostDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__.useHostDocument)();
  const document2 = activeDocument && activeDocument.type.value !== "kit" ? activeDocument : hostDocument;
  const { recentPosts } = useRecentPosts(document2?.id);
  const popupState = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.usePopupState)({
    variant: "popover",
    popupId: "elementor-v2-top-bar-recently-edited"
  });
  const documentTitle = useReverseHtmlEntities(document2?.title);
  if (!document2) {
    return null;
  }
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { sx: { cursor: "default" } }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Button,
    {
      color: "inherit",
      size: "small",
      endIcon: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_0__.ChevronDownIcon, { fontSize: "small" }),
      ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindTrigger)(popupState)
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
      Indicator,
      {
        title: documentTitle,
        status: document2.status
      }
    )
  ), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Menu,
    {
      MenuListProps: { component: "div" },
      PaperProps: { sx: { mt: 4, minWidth: 314 } },
      ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindMenu)(popupState)
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListSubheader, { sx: { fontSize: 12, fontStyle: "italic", pl: 4 }, component: "div", id: "nested-list-subheader" }, (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Recent", "elementor")),
    recentPosts.map((post) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(PostListItem, { key: post.id, post, closePopup: popupState.close })),
    recentPosts.length === 0 && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Typography, { variant: "caption", sx: { color: "grey.500", fontStyle: "italic", p: 4 }, component: "div", "aria-label": void 0 }, (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("There are no other pages or templates on this site yet.", "elementor")),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, null),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(CreatePostListItem, { closePopup: popupState.close })
  ));
}

// src/init.ts


// src/hooks/useToggleButtonProps.ts



// src/components/panel/panel.ts


// src/components/panel/shell.tsx




// src/components/panel/pages-list/pages-collapsible-list.tsx


// src/components/panel/pages-list/collapsible-list.tsx




var RotateIcon = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.styled)(_elementor_icons__WEBPACK_IMPORTED_MODULE_0__.ChevronDownIcon, {
  shouldForwardProp: (prop) => prop !== "isOpen"
})(({ theme, isOpen }) => ({
  transform: isOpen ? "rotate(0deg)" : "rotate(-90deg)",
  transition: theme.transitions.create("transform", {
    duration: theme.transitions.duration.standard
  })
}));
function CollapsibleList({
  label,
  Icon,
  isOpenByDefault = false,
  children
}) {
  const [isOpen, setIsOpen] = (0,react__WEBPACK_IMPORTED_MODULE_1__.useState)(isOpenByDefault);
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(react__WEBPACK_IMPORTED_MODULE_1__.Fragment, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItem, { disableGutters: true }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemIcon, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.IconButton,
    {
      onClick: () => setIsOpen((prev) => !prev),
      sx: { color: "inherit" },
      size: "small"
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(RotateIcon, { fontSize: "small", isOpen })
  )), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemIcon, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(Icon, null)), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemText, null, label)), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Collapse,
    {
      in: isOpen,
      timeout: "auto",
      unmountOnExit: true
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.List, { dense: true }, children)
  ));
}

// src/components/panel/pages-list/pages-collapsible-list.tsx



// src/components/panel/pages-list/page-list-item.tsx





// src/components/shared/page-title-and-status.tsx


var PageStatus = ({ status }) => {
  if ("publish" === status) {
    return null;
  }
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Typography,
    {
      component: "span",
      variant: "body1",
      sx: {
        textTransform: "capitalize",
        fontStyle: "italic",
        whiteSpace: "nowrap",
        flexBasis: "content"
      }
    },
    "(",
    status,
    ")"
  );
};
var PageTitle = ({ title }) => {
  const modifiedTitle = useReverseHtmlEntities(title);
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Typography,
    {
      component: "span",
      variant: "body1",
      noWrap: true,
      sx: {
        flexBasis: "auto"
      }
    },
    modifiedTitle
  );
};
function PageTitleAndStatus({ page }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { display: "flex" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(PageTitle, { title: page.title.rendered }), "\xA0", /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(PageStatus, { status: page.status }));
}

// src/components/panel/actions-menu/page-actions-menu.tsx



// src/components/panel/pages-actions/rename.tsx




// src/components/panel/actions-menu/action-menu-item.tsx


// src/components/panel/actions-menu/action-list-item.tsx


function ActionListItem({ title, icon: Icon, disabled, onClick }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemButton,
    {
      disabled,
      onClick
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemIcon, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(Icon, null)),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemText, null, title)
  );
}

// src/components/panel/actions-menu/action-menu-item.tsx

function ActionMenuItem(props) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.MenuItem, { disableGutters: true }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(ActionListItem, { ...props }));
}

// src/components/panel/pages-actions/rename.tsx
function Rename() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    ActionMenuItem,
    {
      title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Rename", "elementor"),
      icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.EraseIcon,
      onClick: () => null
    }
  );
}

// src/components/panel/pages-actions/duplicate.tsx



function Duplicate() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    ActionMenuItem,
    {
      title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Duplicate", "elementor"),
      icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.CopyIcon,
      onClick: () => null
    }
  );
}

// src/components/panel/pages-actions/delete.tsx




function Delete({ page }) {
  const activeDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__.useActiveDocument)();
  const isActive = activeDocument?.id === page.id;
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    ActionMenuItem,
    {
      title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Delete", "elementor"),
      icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.TrashIcon,
      disabled: page.isHome || isActive,
      onClick: () => null
    }
  );
}

// src/components/panel/pages-actions/view.tsx



function View() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    ActionMenuItem,
    {
      title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("View Page", "elementor"),
      icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.EyeIcon,
      onClick: () => null
    }
  );
}

// src/components/panel/pages-actions/set-home.tsx



function SetHome({ page }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    ActionMenuItem,
    {
      title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Set as homepage", "elementor"),
      icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.HomeIcon,
      disabled: !!page.isHome,
      onClick: () => null
    }
  );
}

// src/components/panel/actions-menu/page-actions-menu.tsx
function PageActionsMenu({ page, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Menu,
    {
      PaperProps: { sx: { mt: 4, width: 200 } },
      MenuListProps: { dense: true },
      ...props
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(Rename, null),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(Duplicate, null),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(Delete, { page }),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(View, null),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, null),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(SetHome, { page })
  );
}

// src/components/panel/pages-list/page-list-item.tsx
function PageListItem({ page }) {
  const popupState = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.usePopupState)({
    variant: "popover",
    popupId: "page-actions"
  });
  const activeDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__.useActiveDocument)();
  const navigateToDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_3__.useNavigateToDocument)();
  const isActive = activeDocument?.id === page.id;
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(react__WEBPACK_IMPORTED_MODULE_1__.Fragment, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItem,
    {
      disablePadding: true,
      secondaryAction: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
        _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ToggleButton,
        {
          value: true,
          color: "secondary",
          size: "small",
          selected: popupState.isOpen,
          ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindTrigger)(popupState)
        },
        /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_0__.DotsVerticalIcon, { fontSize: "small" })
      )
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
      _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemButton,
      {
        selected: isActive,
        onClick: () => navigateToDocument(page.id),
        dense: true
      },
      /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemIcon, null),
      /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
        _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemText,
        {
          disableTypography: true
        },
        /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(PageTitleAndStatus, { page })
      ),
      page.isHome && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemIcon, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_0__.HomeIcon, { color: "disabled" }))
    )
  ), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(PageActionsMenu, { page, ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindMenu)(popupState) }));
}

// src/hooks/use-posts.ts


// src/api/post.ts

var postTypesMap = {
  page: "pages"
};
var getRequest = (postTypeSlug) => {
  const baseUri = `/wp/v2/${postTypesMap[postTypeSlug]}`;
  const keys = ["id", "type", "title", "link", "status"];
  const queryParams = new URLSearchParams({
    status: "any",
    per_page: "-1",
    _fields: keys.join(",")
  });
  const uri = baseUri + "?" + queryParams.toString();
  return _wordpress_api_fetch__WEBPACK_IMPORTED_MODULE_4__({ path: uri });
};

// src/hooks/use-posts.ts
var postsQueryKey = (postTypeSlug) => ["site-navigation", "posts", postTypeSlug];
function usePosts(postTypeSlug) {
  return (0,_elementor_query__WEBPACK_IMPORTED_MODULE_9__.useQuery)({
    queryKey: postsQueryKey(postTypeSlug),
    queryFn: () => getRequest(postTypeSlug)
  });
}

// src/components/panel/pages-list/pages-collapsible-list.tsx

function PagesCollapsibleList({ isOpenByDefault = false }) {
  const { data: pages, isLoading: pagesLoading } = usePosts("page");
  if (!pages || pagesLoading) {
    return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { spacing: 4, sx: { px: 6 } }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Skeleton, { variant: "text", sx: { fontSize: "2rem" } }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Skeleton, { variant: "rounded", width: "100%", height: "48" }));
  }
  const label = (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Pages (%s)", "elementor").replace("%s", pages.length.toString());
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    CollapsibleList,
    {
      label,
      Icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PageTypeIcon,
      isOpenByDefault
    },
    pages.map((page) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(PageListItem, { key: page.id, page }))
  );
}

// src/components/panel/shell.tsx


// src/components/panel/add-new-page-button.tsx



function AddNewPageButton() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Button,
    {
      sx: { mt: 4, mb: 4, mr: 5 },
      startIcon: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PlusIcon, null),
      onClick: () => null
    },
    "Add New"
  );
}

// src/components/panel/shell.tsx
var Shell = () => {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_editor_panels__WEBPACK_IMPORTED_MODULE_8__.Panel, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_editor_panels__WEBPACK_IMPORTED_MODULE_8__.PanelHeader, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_editor_panels__WEBPACK_IMPORTED_MODULE_8__.PanelHeaderTitle, null, (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Pages", "elementor"))), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_editor_panels__WEBPACK_IMPORTED_MODULE_8__.PanelBody, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box,
    {
      display: "flex",
      justifyContent: "flex-end",
      alignItems: "center"
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(AddNewPageButton, null)
  ), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.List, { dense: true }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_1__.createElement(PagesCollapsibleList, { isOpenByDefault: true }))));
};
var shell_default = Shell;

// src/components/panel/panel.ts
var {
  panel,
  usePanelStatus,
  usePanelActions
} = (0,_elementor_editor_panels__WEBPACK_IMPORTED_MODULE_8__.createPanel)({
  id: "site-navigation-panel",
  component: shell_default
});

// src/hooks/useToggleButtonProps.ts
function useToggleButtonProps() {
  const { isOpen, isBlocked } = usePanelStatus();
  const { open, close } = usePanelActions();
  return {
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_6__.__)("Pages", "elementor"),
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_0__.PagesIcon,
    onClick: () => isOpen ? close() : open(),
    selected: isOpen,
    disabled: isBlocked
  };
}

// src/init.ts


// src/env.ts

var { env, validateEnv } = (0,_elementor_env__WEBPACK_IMPORTED_MODULE_10__.parseEnv)("@elementor/editor-site-navigation", (envData) => {
  return envData;
});

// src/init.ts
function init() {
  registerTopBarMenuItems();
  if (env.is_panel_active) {
    (0,_elementor_editor_panels__WEBPACK_IMPORTED_MODULE_8__.registerPanel)(panel);
    registerButton();
  }
}
function registerTopBarMenuItems() {
  (0,_elementor_editor_app_bar__WEBPACK_IMPORTED_MODULE_7__.injectIntoPageIndication)({
    id: "document-recently-edited",
    filler: RecentlyEdited
  });
}
function registerButton() {
  _elementor_editor_app_bar__WEBPACK_IMPORTED_MODULE_7__.toolsMenu.registerToggleAction({
    id: "toggle-site-navigation-panel",
    priority: 2,
    useProps: useToggleButtonProps
  });
}

// src/index.ts
init();


}();
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).editorSiteNavigation = __webpack_exports__;
/******/ })()
;