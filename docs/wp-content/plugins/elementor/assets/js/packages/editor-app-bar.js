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

/***/ "@elementor/editor-documents":
/*!********************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","editorDocuments"] ***!
  \********************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["editorDocuments"];

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

/***/ "@elementor/locations":
/*!**************************************************************!*\
  !*** external ["__UNSTABLE__elementorPackages","locations"] ***!
  \**************************************************************/
/***/ (function(module) {

module.exports = window["__UNSTABLE__elementorPackages"]["locations"];

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
/*!***************************************************************!*\
  !*** ./node_modules/@elementor/editor-app-bar/dist/index.mjs ***!
  \***************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "documentOptionsMenu": function() { return /* binding */ documentOptionsMenu; },
/* harmony export */   "injectIntoPageIndication": function() { return /* binding */ injectIntoPageIndication; },
/* harmony export */   "injectIntoPrimaryAction": function() { return /* binding */ injectIntoPrimaryAction; },
/* harmony export */   "injectIntoResponsive": function() { return /* binding */ injectIntoResponsive; },
/* harmony export */   "mainMenu": function() { return /* binding */ mainMenu; },
/* harmony export */   "toolsMenu": function() { return /* binding */ toolsMenu; },
/* harmony export */   "utilitiesMenu": function() { return /* binding */ utilitiesMenu; }
/* harmony export */ });
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react */ "react");
/* harmony import */ var _elementor_locations__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @elementor/locations */ "@elementor/locations");
/* harmony import */ var _elementor_ui__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @elementor/ui */ "@elementor/ui");
/* harmony import */ var _elementor_icons__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @elementor/icons */ "@elementor/icons");
/* harmony import */ var _wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @wordpress/i18n */ "@wordpress/i18n");
/* harmony import */ var _elementor_editor__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @elementor/editor */ "@elementor/editor");
/* harmony import */ var _elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @elementor/editor-v1-adapters */ "@elementor/editor-v1-adapters");
/* harmony import */ var _elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @elementor/editor-documents */ "@elementor/editor-documents");
// src/locations/menus.tsx




// src/components/actions/action.tsx


// src/contexts/menu-context.tsx


var MenuContext = (0,react__WEBPACK_IMPORTED_MODULE_0__.createContext)({ type: "toolbar" });
function MenuContextProvider({ type, children }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuContext.Provider, { value: { type } }, children);
}
function useMenuContext() {
  return (0,react__WEBPACK_IMPORTED_MODULE_0__.useContext)(MenuContext);
}

// src/components/ui/toolbar-menu-item.tsx


function ToolbarMenuItem({ title, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Tooltip, { title }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { component: "span", "aria-label": void 0 }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.IconButton, { ...props, "aria-label": title, size: "small" })));
}

// src/components/ui/popover-menu-item.tsx



var DirectionalArrowIcon = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.withDirection)(_elementor_icons__WEBPACK_IMPORTED_MODULE_3__.ArrowUpRightIcon);
function PopoverMenuItem({ text, icon, onClick, href, target, disabled, ...props }) {
  const isExternalLink = href && target === "_blank";
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.MenuItem,
    {
      ...props,
      disabled,
      onClick,
      component: href ? "a" : "div",
      href,
      target
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemIcon, null, icon),
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ListItemText, { primary: text }),
    isExternalLink && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(DirectionalArrowIcon, null)
  );
}

// src/components/actions/action.tsx
function Action({ icon: Icon, title, visible = true, ...props }) {
  const { type } = useMenuContext();
  if (!visible) {
    return null;
  }
  return type === "toolbar" ? /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenuItem, { title, ...props }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Icon, null)) : /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    PopoverMenuItem,
    {
      ...props,
      text: title,
      icon: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Icon, null)
    }
  );
}

// src/components/actions/toggle-action.tsx


// src/components/ui/toolbar-menu-toggle-item.tsx


function ToolbarMenuToggleItem({ title, onClick, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Tooltip, { title }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { component: "span", "aria-label": void 0 }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ToggleButton, { ...props, onChange: onClick, "aria-label": title, size: "small" })));
}

// src/components/actions/toggle-action.tsx
function ToggleAction({ icon: Icon, title, value, visible = true, ...props }) {
  const { type } = useMenuContext();
  if (!visible) {
    return null;
  }
  return type === "toolbar" ? /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenuToggleItem, { value: value || title, title, ...props }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Icon, null)) : /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    PopoverMenuItem,
    {
      ...props,
      text: title,
      icon: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Icon, null)
    }
  );
}

// src/components/actions/link.tsx

function Link({ icon: Icon, title, visible = true, ...props }) {
  const { type } = useMenuContext();
  if (!visible) {
    return null;
  }
  return type === "toolbar" ? /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenuItem, { title, ...props }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Icon, null)) : /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    PopoverMenuItem,
    {
      ...props,
      text: title,
      icon: /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Icon, null)
    }
  );
}

// src/locations/menus.tsx
function createMenu(groups = []) {
  const menuGroups = [
    ...groups,
    "default"
  ];
  const locations = menuGroups.reduce(
    (carry, group) => ({
      ...carry,
      [group]: (0,_elementor_locations__WEBPACK_IMPORTED_MODULE_1__.createLocation)()
    }),
    {}
  );
  const [
    registerAction,
    registerToggleAction,
    registerLink
  ] = [Action, ToggleAction, Link].map(
    (Component) => createRegisterMenuItem({
      locations,
      menuGroups,
      component: Component
    })
  );
  const useMenuItems5 = createUseMenuItems(locations);
  return {
    registerAction,
    registerToggleAction,
    registerLink,
    useMenuItems: useMenuItems5
  };
}
function createRegisterMenuItem({ locations, menuGroups, component }) {
  return ({ group = "default", id, overwrite, priority, ...args }) => {
    if (!menuGroups.includes(group)) {
      return;
    }
    const useProps = "props" in args ? () => args.props : args.useProps;
    const Component = component;
    const Filler = (props) => {
      const componentProps = useProps();
      return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Component, { ...props, ...componentProps });
    };
    locations[group].inject({
      id,
      filler: Filler,
      options: {
        priority,
        overwrite
      }
    });
  };
}
function createUseMenuItems(locations) {
  return () => {
    return (0,react__WEBPACK_IMPORTED_MODULE_0__.useMemo)(() => {
      return Object.entries(locations).reduce(
        (carry, [groupName, location]) => {
          const items = location.getInjections().map((injection) => ({
            id: injection.id,
            MenuItem: injection.filler
          }));
          return {
            ...carry,
            [groupName]: items
          };
        },
        {}
      );
    }, []);
  };
}

// src/locations/index.ts

var {
  inject: injectIntoPageIndication,
  Slot: PageIndicationSlot
} = (0,_elementor_locations__WEBPACK_IMPORTED_MODULE_1__.createLocation)();
var {
  inject: injectIntoResponsive,
  Slot: ResponsiveSlot
} = (0,_elementor_locations__WEBPACK_IMPORTED_MODULE_1__.createLocation)();
var {
  inject: injectIntoPrimaryAction,
  Slot: PrimaryActionSlot
} = (0,_elementor_locations__WEBPACK_IMPORTED_MODULE_1__.createLocation)();
var mainMenu = createMenu(["exits"]);
var toolsMenu = createMenu();
var utilitiesMenu = createMenu();
var documentOptionsMenu = createMenu(["save"]);

// src/components/app-bar.tsx



// src/components/locations/main-menu-location.tsx



// src/components/ui/popover-menu.tsx


function PopoverMenu({ children, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuContextProvider, { type: "popover" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Menu,
    {
      PaperProps: {
        sx: { mt: 4 }
      },
      ...props,
      MenuListProps: {
        component: "div"
      }
    },
    children
  ));
}

// src/components/ui/toolbar-logo.tsx




var ElementorLogo = (props) => {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.SvgIcon, { viewBox: "0 0 32 32", ...props }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement("g", null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement("circle", { cx: "16", cy: "16", r: "16" }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement("path", { d: "M11.7 9H9V22.3H11.7V9Z" }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement("path", { d: "M22.4 9H9V11.7H22.4V9Z" }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement("path", { d: "M22.4 14.4004H9V17.1004H22.4V14.4004Z" }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement("path", { d: "M22.4 19.6992H9V22.3992H22.4V19.6992Z" })));
};
var StyledToggleButton = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.styled)(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ToggleButton)(() => ({
  padding: 0,
  "&.MuiToggleButton-root:hover": {
    backgroundColor: "initial"
  },
  "&.MuiToggleButton-root.Mui-selected": {
    backgroundColor: "initial"
  }
}));
var StyledElementorLogo = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.styled)(ElementorLogo, {
  shouldForwardProp: (prop) => prop !== "showMenuIcon"
})(({ theme, showMenuIcon }) => ({
  width: "auto",
  height: "100%",
  "& path": {
    fill: "initial",
    transition: "all 0.2s linear",
    transformOrigin: "bottom left",
    "&:first-of-type": {
      transitionDelay: !showMenuIcon && "0.2s",
      transform: showMenuIcon && "translateY(-9px) scaleY(0)"
    },
    "&:not(:first-of-type)": {
      // Emotion automatically change 4 to -4 in RTL moode.
      transform: !showMenuIcon && `translateX(${theme.direction === "rtl" ? "4" : "9"}px) scaleX(0.6)`
    },
    "&:nth-of-type(2)": {
      transitionDelay: showMenuIcon ? "0" : "0.2s"
    },
    "&:nth-of-type(3)": {
      transitionDelay: "0.1s"
    },
    "&:nth-of-type(4)": {
      transitionDelay: showMenuIcon ? "0.2s" : "0"
    }
  }
}));
function ToolbarLogo(props) {
  const [isHoverState, setIsHoverState] = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)(false);
  const showMenuIcon = props.selected || isHoverState;
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    StyledToggleButton,
    {
      ...props,
      value: "selected",
      size: "small",
      onMouseEnter: () => setIsHoverState(true),
      onMouseLeave: () => setIsHoverState(false)
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(StyledElementorLogo, { titleAccess: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Elementor Logo", "elementor"), showMenuIcon })
  );
}

// src/components/locations/main-menu-location.tsx
var { useMenuItems } = mainMenu;
function MainMenuLocation() {
  const menuItems = useMenuItems();
  const orderedGroups = [
    menuItems.default,
    menuItems.exits
  ];
  const popupState = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.usePopupState)({
    variant: "popover",
    popupId: "elementor-v2-app-bar-main-menu"
  });
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Stack, { sx: { paddingInlineStart: 4 }, direction: "row", alignItems: "center" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    ToolbarLogo,
    {
      ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindTrigger)(popupState),
      selected: popupState.isOpen
    }
  ), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    PopoverMenu,
    {
      onClick: popupState.close,
      ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindMenu)(popupState),
      PaperProps: {
        sx: { mt: 4, marginInlineStart: -2 }
      }
    },
    orderedGroups.filter((group) => group.length).map((group, index) => {
      return [
        index > 0 ? /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, { key: index, orientation: "horizontal" }) : null,
        ...group.map(
          ({ MenuItem: MenuItem2, id }) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuItem2, { key: id })
        )
      ];
    })
  ));
}

// src/components/locations/tools-menu-location.tsx


// src/components/ui/toolbar-menu.tsx


function ToolbarMenu({ children, ...props }) {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuContextProvider, { type: "toolbar" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Stack, { sx: { px: 4 }, spacing: 4, direction: "row", alignItems: "center", ...props }, children));
}

// src/components/ui/toolbar-menu-more.tsx




function ToolbarMenuMore({ children, id }) {
  const popupState = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.usePopupState)({
    variant: "popover",
    popupId: id
  });
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(react__WEBPACK_IMPORTED_MODULE_0__.Fragment, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenuItem, { ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindTrigger)(popupState), title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("More", "elementor") }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_3__.DotsVerticalIcon, null)), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(PopoverMenu, { onClick: popupState.close, ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindMenu)(popupState) }, children));
}

// src/components/locations/tools-menu-location.tsx
var MAX_TOOLBAR_ACTIONS = 5;
var { useMenuItems: useMenuItems2 } = toolsMenu;
function ToolsMenuLocation() {
  const menuItems = useMenuItems2();
  const toolbarMenuItems = menuItems.default.slice(0, MAX_TOOLBAR_ACTIONS);
  const popoverMenuItems = menuItems.default.slice(MAX_TOOLBAR_ACTIONS);
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenu, null, toolbarMenuItems.map(({ MenuItem: MenuItem2, id }) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuItem2, { key: id })), popoverMenuItems.length > 0 && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenuMore, { id: "elementor-editor-app-bar-tools-more" }, popoverMenuItems.map(({ MenuItem: MenuItem2, id }) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuItem2, { key: id }))));
}

// src/components/locations/utilities-menu-location.tsx



var MAX_TOOLBAR_ACTIONS2 = 3;
var { useMenuItems: useMenuItems3 } = utilitiesMenu;
function UtilitiesMenuLocation() {
  const menuItems = useMenuItems3();
  const toolbarMenuItems = menuItems.default.slice(0, MAX_TOOLBAR_ACTIONS2);
  const popoverMenuItems = menuItems.default.slice(MAX_TOOLBAR_ACTIONS2);
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenu, null, toolbarMenuItems.map(
    ({ MenuItem: MenuItem2, id }, index) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(react__WEBPACK_IMPORTED_MODULE_0__.Fragment, { key: id }, index === 0 && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, { orientation: "vertical" }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuItem2, null))
  ), popoverMenuItems.length > 0 && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenuMore, { id: "elementor-editor-app-bar-utilities-more" }, popoverMenuItems.map(({ MenuItem: MenuItem2, id }) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuItem2, { key: id }))));
}

// src/components/locations/primary-action-location.tsx

function PrimaryActionLocation() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(PrimaryActionSlot, null);
}

// src/components/locations/page-indication-location.tsx

function PageIndicationLocation() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(PageIndicationSlot, null);
}

// src/components/locations/responsive-location.tsx

function ResponsiveLocation() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ResponsiveSlot, null);
}

// src/components/app-bar.tsx
function AppBar() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ThemeProvider, { colorScheme: "dark" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.AppBar, { position: "sticky" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { display: "grid", gridTemplateColumns: "repeat(3, 1fr)" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Grid, { container: true }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MainMenuLocation, null), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolsMenuLocation, null)), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Grid, { container: true, justifyContent: "center" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ToolbarMenu, { spacing: 3 }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, { orientation: "vertical" }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(PageIndicationLocation, null), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, { orientation: "vertical" }), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(ResponsiveLocation, null), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, { orientation: "vertical" }))), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Grid, { container: true, justifyContent: "flex-end" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(UtilitiesMenuLocation, null), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(PrimaryActionLocation, null)))));
}

// src/init.ts


// src/sync/redirect-old-menus.ts

function redirectOldMenus() {
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.listenTo)((0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.routeOpenEvent)("panel/menu"), () => {
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.openRoute)("panel/elements/categories");
  });
}

// src/extensions/documents-indicator/components/settings-button.tsx






function SettingsButton() {
  const activeDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocument)();
  const hostDocument = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useHostDocument)();
  const document2 = activeDocument && activeDocument.type.value !== "kit" ? activeDocument : hostDocument;
  const { isActive, isBlocked } = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useRouteStatus)("panel/page-settings");
  if (!document2) {
    return null;
  }
  const title = (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("%s Settings", "elementor").replace("%s", document2.type.label);
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Tooltip, { title }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { component: "span", "aria-label": void 0 }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ToggleButton,
    {
      value: "document-settings",
      selected: isActive,
      disabled: isBlocked,
      onChange: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.openRoute)("panel/page-settings/settings"),
      "aria-label": title,
      size: "small"
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_3__.SettingsIcon, null)
  )));
}

// src/extensions/documents-indicator/index.ts
function init() {
  injectIntoPageIndication({
    id: "document-settings-button",
    filler: SettingsButton,
    options: {
      priority: 20
      // After document indicator.
    }
  });
}

// src/extensions/documents-preview/hooks/use-action-props.ts




function useActionProps() {
  const document2 = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocument)();
  return {
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.EyeIcon,
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Preview Changes", "elementor"),
    onClick: () => document2 && (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.runCommand)("editor/documents/preview", {
      id: document2.id,
      force: true
    })
  };
}

// src/extensions/documents-preview/index.ts
function init2() {
  utilitiesMenu.registerAction({
    id: "document-preview-button",
    priority: 30,
    // After help.
    useProps: useActionProps
  });
}

// src/extensions/documents-save/hooks/use-document-save-draft-props.ts



function useDocumentSaveDraftProps() {
  const document2 = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocument)();
  const { saveDraft } = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocumentActions)();
  return {
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.FileReportIcon,
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Save Draft", "elementor"),
    onClick: saveDraft,
    disabled: !document2 || document2.isSaving || document2.isSavingDraft || !document2.isDirty
  };
}

// src/extensions/documents-save/hooks/use-document-save-template-props.ts



function useDocumentSaveTemplateProps() {
  const { saveTemplate } = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocumentActions)();
  return {
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.FolderIcon,
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Save as Template", "elementor"),
    onClick: saveTemplate
  };
}

// src/extensions/documents-save/components/primary-action.tsx



// src/extensions/documents-save/components/primary-action-menu.tsx


var { useMenuItems: useMenuItems4 } = documentOptionsMenu;
var StyledPopoverMenu = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.styled)(PopoverMenu)`
	& > .MuiPopover-paper > .MuiList-root > .MuiDivider-root {
		&:only-child, /* A divider is being rendered lonely */
		&:last-child, /* The last group renders empty but renders a divider */
		& + .MuiDivider-root /* Multiple dividers due to multiple empty groups */ {
			display: none;
		}
	}
`;
function PrimaryActionMenu(props) {
  const { save: saveActions, default: defaultActions } = useMenuItems4();
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    StyledPopoverMenu,
    {
      ...props,
      anchorOrigin: {
        vertical: "bottom",
        horizontal: "right"
      },
      transformOrigin: {
        vertical: "top",
        horizontal: "right"
      },
      PaperProps: {
        sx: { mt: 2, ml: 3 }
      }
    },
    saveActions.map(({ MenuItem: MenuItem2, id }, index) => [
      index > 0 && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, { key: `${id}-divider` }),
      /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuItem2, { key: id })
    ]),
    defaultActions.length > 0 && /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Divider, null),
    defaultActions.map(({ MenuItem: MenuItem2, id }) => /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(MenuItem2, { key: id }))
  );
}

// src/extensions/documents-save/components/primary-action.tsx



function PrimaryAction() {
  const document2 = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocument)();
  const { save } = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocumentActions)();
  const popupState = (0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.usePopupState)({
    variant: "popover",
    popupId: "document-save-options"
  });
  if (!document2) {
    return null;
  }
  const isDisabled = !isEnabled(document2);
  const shouldShowSpinner = document2.isSaving && !isDisabled;
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(react__WEBPACK_IMPORTED_MODULE_0__.Fragment, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.ButtonGroup, { size: "medium", variant: "contained" }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Button,
    {
      onClick: () => !document2.isSaving && save(),
      sx: {
        px: 7,
        height: "100%",
        maxWidth: "158px",
        "&.MuiButtonBase-root.MuiButtonGroup-grouped": {
          minWidth: "110px"
        }
      },
      disabled: isDisabled
    },
    shouldShowSpinner ? /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.CircularProgress, null) : getLabel(document2)
  ), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Tooltip,
    {
      title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Save Options", "elementor"),
      PopperProps: {
        sx: {
          "&.MuiTooltip-popper .MuiTooltip-tooltip.MuiTooltip-tooltipPlacementBottom": {
            mt: 3,
            mr: 1
          }
        }
      }
    },
    /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Box, { component: "span", "aria-label": void 0 }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
      _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Button,
      {
        ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindTrigger)(popupState),
        sx: { px: 0, height: "100%" },
        disabled: document2.type.value === "kit",
        "aria-label": (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Save Options", "elementor")
      },
      /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_icons__WEBPACK_IMPORTED_MODULE_3__.ChevronDownIcon, null)
    ))
  )), /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(PrimaryActionMenu, { ...(0,_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.bindMenu)(popupState), onClick: popupState.close }));
}
function getLabel(document2) {
  return document2.userCan.publish ? (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Publish", "elementor") : (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Submit", "elementor");
}
function isEnabled(document2) {
  if (document2.type.value === "kit") {
    return false;
  }
  return document2.isDirty || document2.status.value === "draft";
}

// src/extensions/documents-save/index.ts
function init3() {
  injectIntoPrimaryAction({
    id: "document-primary-action",
    filler: PrimaryAction
  });
  documentOptionsMenu.registerAction({
    group: "save",
    id: "document-save-draft",
    priority: 10,
    // Before save as template.
    useProps: useDocumentSaveDraftProps
  });
  documentOptionsMenu.registerAction({
    group: "save",
    id: "document-save-as-template",
    priority: 20,
    // After save draft.
    useProps: useDocumentSaveTemplateProps
  });
}

// src/extensions/elements/sync/sync-panel-title.ts


function syncPanelTitle() {
  const panelTitle = (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Elements", "elementor");
  const tabTitle = (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Widgets", "elementor");
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.routeOpenEvent)("panel/elements"),
    () => {
      setPanelTitle(panelTitle);
      setTabTitle(tabTitle);
    }
  );
  (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.listenTo)(
    (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.v1ReadyEvent)(),
    () => {
      if ((0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.isRouteActive)("panel/elements")) {
        setPanelTitle(panelTitle);
        setTabTitle(tabTitle);
      }
    }
  );
}
function setPanelTitle(title) {
  window.elementor?.getPanelView?.()?.getHeaderView?.()?.setTitle?.(title);
}
function setTabTitle(title) {
  const tab = document.querySelector('.elementor-component-tab[data-tab="categories"]');
  if (tab) {
    tab.textContent = title;
  }
}

// src/extensions/elements/hooks/use-action-props.ts



function useActionProps2() {
  const { isActive, isBlocked } = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useRouteStatus)("panel/elements");
  return {
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Add Element", "elementor"),
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.PlusIcon,
    onClick: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.openRoute)("panel/elements/categories"),
    selected: isActive,
    disabled: isBlocked
  };
}

// src/extensions/elements/index.ts
function init4() {
  syncPanelTitle();
  toolsMenu.registerToggleAction({
    id: "open-elements-panel",
    priority: 1,
    useProps: useActionProps2
  });
}

// src/extensions/finder/hooks/use-action-props.ts



function useActionProps3() {
  const { isActive, isBlocked } = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useRouteStatus)("finder", {
    blockOnKitRoutes: false,
    blockOnPreviewMode: false
  });
  return {
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Finder", "elementor"),
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.SearchIcon,
    onClick: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.runCommand)("finder/toggle"),
    selected: isActive,
    disabled: isBlocked
  };
}

// src/extensions/finder/index.ts
function init5() {
  utilitiesMenu.registerToggleAction({
    id: "toggle-finder",
    priority: 10,
    // Before help.
    useProps: useActionProps3
  });
}

// src/extensions/help/index.ts


function init6() {
  utilitiesMenu.registerLink({
    id: "open-help-center",
    priority: 20,
    // After Finder.
    useProps: () => {
      return {
        title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Help", "elementor"),
        href: "https://go.elementor.com/editor-top-bar-learn/",
        icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.HelpIcon,
        target: "_blank"
      };
    }
  });
}

// src/extensions/history/hooks/use-action-props.ts



function useActionProps4() {
  const { isActive, isBlocked } = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useRouteStatus)("panel/history");
  return {
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("History", "elementor"),
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.HistoryIcon,
    onClick: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.openRoute)("panel/history/actions"),
    selected: isActive,
    disabled: isBlocked
  };
}

// src/extensions/history/index.ts
function init7() {
  mainMenu.registerToggleAction({
    id: "open-history",
    priority: 20,
    useProps: useActionProps4
  });
}

// src/extensions/keyboard-shortcuts/hooks/use-action-props.ts



function useActionProps5() {
  return {
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.KeyboardIcon,
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Keyboard Shortcuts", "elementor"),
    onClick: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.runCommand)("shortcuts/open")
  };
}

// src/extensions/keyboard-shortcuts/index.ts
function init8() {
  mainMenu.registerAction({
    id: "open-keyboard-shortcuts",
    group: "default",
    priority: 40,
    // After user preferences.
    useProps: useActionProps5
  });
}

// src/extensions/site-settings/index.ts


// src/extensions/site-settings/components/portalled-primary-action.tsx


// src/extensions/site-settings/components/portal.tsx



function Portal(props) {
  const containerRef = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useListenTo)(
    [
      (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.routeOpenEvent)("panel/global"),
      (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.routeCloseEvent)("panel/global")
    ],
    getContainerRef
  );
  if (!containerRef.current) {
    return null;
  }
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Portal, { container: containerRef.current, ...props });
}
function getContainerRef() {
  return (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.isRouteActive)("panel/global") ? { current: document.querySelector("#elementor-panel-inner") } : { current: null };
}

// src/extensions/site-settings/components/primary-action.tsx




function PrimaryAction2() {
  const document2 = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocument)();
  const { save } = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocumentActions)();
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Paper, { sx: {
    px: 5,
    py: 4,
    borderTop: 1,
    borderColor: "divider"
  } }, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(
    _elementor_ui__WEBPACK_IMPORTED_MODULE_2__.Button,
    {
      variant: "contained",
      disabled: !document2 || !document2.isDirty,
      size: "medium",
      sx: { width: "100%" },
      onClick: () => document2 && !document2.isSaving ? save() : null
    },
    document2?.isSaving ? /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(_elementor_ui__WEBPACK_IMPORTED_MODULE_2__.CircularProgress, null) : (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Save Changes", "elementor")
  ));
}

// src/extensions/site-settings/components/portalled-primary-action.tsx
function PortalledPrimaryAction() {
  return /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(Portal, null, /* @__PURE__ */ react__WEBPACK_IMPORTED_MODULE_0__.createElement(PrimaryAction2, null));
}

// src/extensions/site-settings/hooks/use-action-props.ts



function useActionProps6() {
  const { isActive, isBlocked } = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useRouteStatus)("panel/global", {
    blockOnKitRoutes: false
  });
  return {
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Site Settings", "elementor"),
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.AdjustmentsHorizontalIcon,
    onClick: () => isActive ? (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.runCommand)("panel/global/close") : (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.runCommand)("panel/global/open"),
    selected: isActive,
    disabled: isBlocked
  };
}

// src/extensions/site-settings/index.ts
function init9() {
  (0,_elementor_editor__WEBPACK_IMPORTED_MODULE_5__.injectIntoTop)({
    id: "site-settings-primary-action-portal",
    filler: PortalledPrimaryAction
  });
  toolsMenu.registerToggleAction({
    id: "toggle-site-settings",
    priority: 2,
    useProps: useActionProps6
  });
}

// src/extensions/structure/hooks/use-action-props.ts



function useActionProps7() {
  const { isActive, isBlocked } = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useRouteStatus)("navigator");
  return {
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Structure", "elementor"),
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.StructureIcon,
    onClick: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.runCommand)("navigator/toggle"),
    selected: isActive,
    disabled: isBlocked
  };
}

// src/extensions/structure/index.ts
function init10() {
  toolsMenu.registerToggleAction({
    id: "toggle-structure-view",
    priority: 3,
    useProps: useActionProps7
  });
}

// src/extensions/theme-builder/hooks/use-action-props.ts



function useActionProps8() {
  return {
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.ThemeBuilderIcon,
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Theme Builder", "elementor"),
    onClick: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.runCommand)("app/open")
  };
}

// src/extensions/theme-builder/index.ts
function init11() {
  mainMenu.registerAction({
    id: "open-theme-builder",
    useProps: useActionProps8
  });
}

// src/extensions/user-preferences/hooks/use-action-props.ts



function useActionProps9() {
  const { isActive, isBlocked } = (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.useRouteStatus)("panel/editor-preferences");
  return {
    icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.ToggleRightIcon,
    title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("User Preferences", "elementor"),
    onClick: () => (0,_elementor_editor_v1_adapters__WEBPACK_IMPORTED_MODULE_6__.openRoute)("panel/editor-preferences"),
    selected: isActive,
    disabled: isBlocked
  };
}

// src/extensions/user-preferences/index.ts
function init12() {
  mainMenu.registerToggleAction({
    id: "open-user-preferences",
    priority: 30,
    // After history.
    useProps: useActionProps9
  });
}

// src/extensions/wordpress/index.ts



function init13() {
  mainMenu.registerLink({
    id: "exit-to-wordpress",
    group: "exits",
    useProps: () => {
      const document2 = (0,_elementor_editor_documents__WEBPACK_IMPORTED_MODULE_7__.useActiveDocument)();
      return {
        title: (0,_wordpress_i18n__WEBPACK_IMPORTED_MODULE_4__.__)("Exit to WordPress", "elementor"),
        href: document2?.links?.platformEdit,
        icon: _elementor_icons__WEBPACK_IMPORTED_MODULE_3__.WordpressIcon
      };
    }
  });
}

// src/extensions/index.ts
function init14() {
  init();
  init2();
  init3();
  init4();
  init5();
  init6();
  init7();
  init8();
  init9();
  init10();
  init11();
  init12();
  init13();
}

// src/init.ts
function init15() {
  redirectOldMenus();
  init14();
  (0,_elementor_editor__WEBPACK_IMPORTED_MODULE_5__.injectIntoTop)({
    id: "app-bar",
    filler: AppBar
  });
}

// src/index.ts
init15();

//# sourceMappingURL=index.mjs.map
}();
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).editorAppBar = __webpack_exports__;
/******/ })()
;