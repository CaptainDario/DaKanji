/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
/******/ 	// The require scope
/******/ 	var __webpack_require__ = {};
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
/*!****************************************************!*\
  !*** ./node_modules/@elementor/env/dist/index.mjs ***!
  \****************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InvalidEnvError": function() { return /* binding */ InvalidEnvError; },
/* harmony export */   "initEnv": function() { return /* binding */ initEnv; },
/* harmony export */   "parseEnv": function() { return /* binding */ parseEnv; },
/* harmony export */   "resetEnv": function() { return /* binding */ resetEnv; }
/* harmony export */ });
// src/index.ts
var globalEnv = null;
function initEnv(env) {
  globalEnv = env;
}
function resetEnv() {
  globalEnv = null;
}
function parseEnv(key, parseFn = (rawSettings) => rawSettings) {
  let parsedEnv = {};
  let isParsed = false;
  const proxiedEnv = new Proxy(parsedEnv, {
    get(target, property) {
      if (!isParsed) {
        parse();
      }
      return parsedEnv[property];
    },
    ownKeys() {
      if (!isParsed) {
        parse();
      }
      return Reflect.ownKeys(parsedEnv);
    },
    getOwnPropertyDescriptor() {
      return {
        configurable: true,
        enumerable: true
      };
    }
  });
  const parse = () => {
    try {
      const env = globalEnv?.[key];
      if (!env) {
        throw new InvalidEnvError(`Settings object not found`);
      }
      if (typeof env !== "object") {
        throw new InvalidEnvError(`Expected settings to be \`object\`, but got \`${typeof env}\``);
      }
      parsedEnv = parseFn(env);
    } catch (e) {
      if (e instanceof InvalidEnvError) {
        console.warn(`${key} - ${e.message}`);
        parsedEnv = {};
      } else {
        throw e;
      }
    } finally {
      isParsed = true;
    }
  };
  return {
    validateEnv: parse,
    env: proxiedEnv
  };
}
var InvalidEnvError = class extends Error {
};

//# sourceMappingURL=index.mjs.map
(window.__UNSTABLE__elementorPackages = window.__UNSTABLE__elementorPackages || {}).env = __webpack_exports__;
/******/ })()
;