function supportsTransitions() {
	return getSupportedTransition() != '';
}

function getSupportedTransition() {
	var b = document.body || document.documentElement,
		s = b.style,
		p = 'transition';

	if (typeof s[p] == 'string') { return p; }

	// Tests for vendor specific prop
	var v = ['Moz', 'webkit', 'Webkit', 'Khtml', 'O', 'ms'];
	p = p.charAt(0).toUpperCase() + p.substr(1);

	for (var i=0; i<v.length; i++) {
		if (typeof s[v[i] + p] == 'string') { return true; }
	}

	return '';
}
window.supportedTransition = getSupportedTransition();
window.supportsTransitions = supportsTransitions();

function supportsAnimations() {
	return getSupportedAnimation() != '';
}

function getSupportedAnimation() {
	var t,
		el = document.createElement("fakeelement");

	var animations = {
		"animation"	  : "animationend",
		"OAnimation"	 : "oAnimationEnd",
		"MozAnimation"   : "animationend",
		"WebkitAnimation": "webkitAnimationEnd",
		'msAnimation' : 'MSAnimationEnd'
	};

	for (t in animations){
		if (el.style[t] !== undefined) {
			return t;
		}
	}
	return '';
}
window.supportedAnimation = getSupportedAnimation();
window.supportsAnimations = supportsAnimations();

function getMobileMenuType() {
	if(!document.getElementById('site-header')) return 'default';
	var m = document.getElementById('site-header').className.match(/mobile-menu-layout-([a-zA-Z0-9]+)/);
	window.gemMobileMenuType = m ? m[1] : 'default';
	return window.gemMobileMenuType;
}
getMobileMenuType();

(function() {
	var logoFixTimeout = false;
	window.thegemDesktopMenuLogoFixed = false;
	window.thegemWasDesktop = false;
	window.megaMenuWithSettingsFixed = false;

	function getElementPosition(elem) {
		var w = elem.offsetWidth,
			h = elem.offsetHeight,
			l = 0,
			t = 0;

		while (elem) {
			l += elem.offsetLeft;
			t += elem.offsetTop;
			elem = elem.offsetParent;
		}
		return {"left":l, "top":t, "width": w, "height":h};
	}

	function fixMenuLogoPosition() {
		if (logoFixTimeout) {
			clearTimeout(logoFixTimeout);
		}

		var headerMain = document.querySelector('#site-header .header-main');
		if (headerMain == null) {
			return false;
		}

		var headerMainClass = headerMain.className;
		if (headerMainClass.indexOf('logo-position-menu_center') == -1 || headerMainClass.indexOf('header-layout-fullwidth_hamburger') != -1 || headerMainClass.indexOf('header-layout-vertical') != -1) {
			return false;
		}

		logoFixTimeout = setTimeout(function() {
			var page = document.getElementById('page'),
				primaryMenu = document.getElementById('primary-menu'),
				primaryNavigation = document.getElementById('primary-navigation'),
				windowWidth = page.offsetWidth,
				pageComputedStyles = window.getComputedStyle(page, null),
				pageMargin = parseFloat(pageComputedStyles['marginLeft']);

			if (isNaN(pageMargin)) {
				pageMargin = 0;
			}

			if (headerMainClass.indexOf('header-layout-fullwidth') != -1) {
				var logoItem = primaryMenu.querySelector('.menu-item-logo'),
					items = primaryNavigation.querySelectorAll('#primary-menu > li'),
					lastItem = null;

				for (var i = items.length - 1; i >=0; i--) {
					if (items[i].className.indexOf('mobile-only') == -1) {
						lastItem = items[i];
						break;
					}
				}

				primaryMenu.style.display = '';
				logoItem.style.marginLeft = '';
				logoItem.style.marginRight = '';

				if (windowWidth < 1212 || lastItem === null) {
					primaryMenu.classList.remove("menu_center-preload");
					return;
				}

				window.thegemDesktopMenuLogoFixed = true;

				primaryMenu.style.display = 'block';

				var pageCenter = windowWidth / 2 + pageMargin,
					logoOffset = getElementPosition(logoItem),
					offset = pageCenter - logoOffset.left - logoItem.offsetWidth / 2;

				logoItem.style.marginLeft = offset + 'px';

				var primaryMenuOffsetWidth = primaryMenu.offsetWidth,
					primaryMenuOffsetLeft = getElementPosition(primaryMenu).left,
					lastItemOffsetWidth = lastItem.offsetWidth,
					lastItemOffsetLeft = getElementPosition(lastItem).left,
					rightItemsOffset = primaryMenuOffsetWidth - lastItemOffsetLeft - lastItemOffsetWidth + primaryMenuOffsetLeft;

				logoItem.style.marginRight = rightItemsOffset + 'px';
			} else {
				if (windowWidth < 1212) {
					primaryNavigation.style.textAlign = '';
					primaryMenu.style.position = '';
					primaryMenu.style.left = '';
					primaryMenu.classList.remove("menu_center-preload");
					return;
				}

				window.thegemDesktopMenuLogoFixed = true;

				primaryNavigation.style.textAlign = 'left';
				primaryMenu.style.left = 0 + 'px';

				var pageCenter = windowWidth / 2,
					primaryMenuOffsetLeft = getElementPosition(primaryMenu).left,
					logoOffset = getElementPosition(document.querySelector('#site-header .header-main #primary-navigation .menu-item-logo')),
					pageOffset = getElementPosition(page),
					offset = pageCenter - (logoOffset.left - pageOffset.left) - document.querySelector('#site-header .header-main #primary-navigation .menu-item-logo').offsetWidth / 2;

				if (primaryMenuOffsetLeft + offset >= 0) {
					primaryMenu.style.position = 'relative';
					primaryMenu.style.left = offset + 'px';
				} else {
					primaryMenu.style.position = '';
					primaryMenu.style.left = '';
				}
			}
			primaryMenu.classList.remove("menu_center-preload");
			//primaryMenu.style.opacity = '1';
		}, 50);
	}

	window.fixMenuLogoPosition = fixMenuLogoPosition;

	if (window.gemOptions.clientWidth > 1212) {
		window.addEventListener('load', function(event) {
			window.fixMenuLogoPosition();
		}, false);
	}
})();


(function($) {
	/* PRIMARY MENU */

	var isVerticalMenu = $('.header-main').hasClass('header-layout-vertical'),
		isHamburgerMenu = $('.header-main').hasClass('header-layout-fullwidth_hamburger'),
		isPerspectiveMenu = $('#thegem-perspective').length > 0;

	$(window).resize(function() {
		window.updateGemClientSize(false);
		window.updateGemInnerSize();
	});

	window.menuResizeTimeoutHandler = false;

	var megaMenuSettings = {};

	function getOffset(elem) {
		if (elem.getBoundingClientRect && window.gemBrowser.platform.name != 'ios'){
			var bound = elem.getBoundingClientRect(),
				html = elem.ownerDocument.documentElement,
				htmlScroll = getScroll(html),
				elemScrolls = getScrolls(elem),
				isFixed = (styleString(elem, 'position') == 'fixed');
			return {
				x: bound.left + elemScrolls.x + ((isFixed) ? 0 : htmlScroll.x) - html.clientLeft,
				y: bound.top  + elemScrolls.y + ((isFixed) ? 0 : htmlScroll.y) - html.clientTop
			};
		}

		var element = elem, position = {x: 0, y: 0};
		if (isBody(elem)) return position;

		while (element && !isBody(element)){
			position.x += element.offsetLeft;
			position.y += element.offsetTop;

			if (window.gemBrowser.name == 'firefox'){
				if (!borderBox(element)){
					position.x += leftBorder(element);
					position.y += topBorder(element);
				}
				var parent = element.parentNode;
				if (parent && styleString(parent, 'overflow') != 'visible'){
					position.x += leftBorder(parent);
					position.y += topBorder(parent);
				}
			} else if (element != elem && window.gemBrowser.name == 'safari'){
				position.x += leftBorder(element);
				position.y += topBorder(element);
			}

			element = element.offsetParent;
		}
		if (window.gemBrowser.name == 'firefox' && !borderBox(elem)){
			position.x -= leftBorder(elem);
			position.y -= topBorder(elem);
		}
		return position;
	};

	function getScroll(elem){
		return {x: window.pageXOffset || document.documentElement.scrollLeft, y: window.pageYOffset || document.documentElement.scrollTop};
	};

	function getScrolls(elem){
		var element = elem.parentNode, position = {x: 0, y: 0};
		while (element && !isBody(element)){
			position.x += element.scrollLeft;
			position.y += element.scrollTop;
			element = element.parentNode;
		}
		return position;
	};

	function styleString(element, style) {
		return $(element).css(style);
	};

	function styleNumber(element, style){
		return parseInt(styleString(element, style)) || 0;
	};

	function borderBox(element){
		return styleString(element, '-moz-box-sizing') == 'border-box';
	};

	function topBorder(element){
		return styleNumber(element, 'border-top-width');
	};

	function leftBorder(element){
		return styleNumber(element, 'border-left-width');
	};

	function isBody(element){
		return (/^(?:body|html)$/i).test(element.tagName);
	};


	function checkMegaMenuSettings() {
		if (window.customMegaMenuSettings == undefined || window.customMegaMenuSettings == null) {
			return false;
		}

		var uri = window.location.pathname;

		window.customMegaMenuSettings.forEach(function(item) {
			for (var i = 0; i < item.urls.length; i++) {
				if (uri.match(item.urls[i])) {
					megaMenuSettings[item.menuItem] = item.data;
				}
			}
		});
	}

	function fixMegaMenuWithSettings() {
		if (isResponsiveMenuVisible() && !window.thegemWasDesktop) {
			return false;
		}

		window.megaMenuWithSettingsFixed = true;

		checkMegaMenuSettings();

		$('#primary-menu > li.megamenu-enable').each(function() {
			var m = this.className.match(/(menu-item-(\d+))/);
			if (!m) {
				return;
			}

			var itemId = parseInt(m[2]);
			if (megaMenuSettings[itemId] == undefined || megaMenuSettings[itemId] == null) {
				return;
			}

			var $item = $('> ul', this);

			if (megaMenuSettings[itemId].masonry != undefined) {
				if (megaMenuSettings[itemId].masonry) {
					$item.addClass('megamenu-masonry');
				} else {
					$item.removeClass('megamenu-masonry');
				}
			}

			if (megaMenuSettings[itemId].style != undefined) {
				$(this).removeClass('megamenu-style-default megamenu-style-grid').addClass('megamenu-style-' + megaMenuSettings[itemId].style);
			}

			var css = {};

			if (megaMenuSettings[itemId].backgroundImage != undefined) {
				css.backgroundImage = megaMenuSettings[itemId].backgroundImage;
			}

			if (megaMenuSettings[itemId].backgroundPosition != undefined) {
				css.backgroundPosition = megaMenuSettings[itemId].backgroundPosition;
			}

			if (megaMenuSettings[itemId].padding != undefined) {
				css.padding = megaMenuSettings[itemId].padding;
			}

			if (megaMenuSettings[itemId].borderRight != undefined) {
				css.borderRight = megaMenuSettings[itemId].borderRight;
			}

			$item.css(css);
		});
	}

	function isResponsiveMenuVisible() {
		// var menuToggleDisplay = $('.menu-toggle').css('display');
		// return menuToggleDisplay == 'block' || menuToggleDisplay == 'inline-block';
		return $('.primary-navigation .menu-toggle').is(':visible');
	}
	window.isResponsiveMenuVisible = isResponsiveMenuVisible;

	function isTopAreaVisible() {
		return window.gemSettings.topAreaMobileDisable ? window.gemOptions.clientWidth >= 768 : true;
	}
	window.isTopAreaVisible = isTopAreaVisible;

	function isVerticalToggleVisible() {
		return window.gemOptions.clientWidth > 1600;
	}

	$('#primary-menu > li.megamenu-enable').hover(
		function() {
			fix_megamenu_position(this);
		},
		function() {}
	);

	$('#primary-menu > li.megamenu-enable:hover').each(function() {
		fix_megamenu_position(this);
	});

	$('#primary-menu > li.megamenu-enable').each(function() {
		var $item = $('> ul', this);
		if($item.length == 0) return;
		$item.addClass('megamenu-item-inited');
	});

	function fix_megamenu_position(elem, containerWidthCallback) {
		if (!$('.megamenu-inited', elem).length && isResponsiveMenuVisible()) {
			return false;
		}

			var $item = $('> ul', elem);
			if($item.length == 0) return;
			var self = $item.get(0);

			$item.addClass('megamenu-item-inited');

			var default_item_css = {
				width: 'auto',
				height: 'auto'
			};

			if (!isVerticalMenu && !isHamburgerMenu && !isPerspectiveMenu) {
				default_item_css.left = 0;
			}

			$item
				.removeClass('megamenu-masonry-inited megamenu-fullwidth')
				.css(default_item_css);

			$(' > li', $item).css({
				left: 0,
				top: 0
			}).each(function() {
				var old_width = $(this).data('old-width') || -1;
				if (old_width != -1) {
					$(this).width(old_width).data('old-width', -1);
				}
			});

			if (isResponsiveMenuVisible()) {
				return;
			}

			if (containerWidthCallback !== undefined) {
				var container_width = containerWidthCallback();
			} else if (isVerticalMenu) {
				var container_width = window.gemOptions.clientWidth - $('#site-header-wrapper').outerWidth();
			} else if (isPerspectiveMenu) {
				var container_width = window.gemOptions.clientWidth - $('#primary-navigation').outerWidth();
			} else if (isHamburgerMenu) {
				var container_width = window.gemOptions.clientWidth - $('#primary-menu').outerWidth();
			} else {
				var $container = $item.closest('.header-main'),
					container_width = $container.width(),
					container_padding_left = parseInt($container.css('padding-left')),
					container_padding_right = parseInt($container.css('padding-right')),
					parent_width = $item.parent().outerWidth();
			}

			var megamenu_width = $item.outerWidth();

			if (megamenu_width > container_width) {
				megamenu_width = container_width;
				var new_megamenu_width = container_width - parseInt($item.css('padding-left')) - parseInt($item.css('padding-right'));
				var columns = $item.data('megamenu-columns') || 4;
				var margin = 0;
				$(' > li.menu-item', $item).each(function (index) {
					if (index < columns) {
						margin += parseInt($(this).css('margin-left'));
					}
				});
				var column_width = parseFloat(new_megamenu_width - margin) / columns;
				var column_width_int = parseInt(column_width);
				$(' > li', $item).each(function() {
					$(this).data('old-width', $(this).width()).css('width', column_width_int);
				});
				$item.addClass('megamenu-fullwidth').width(new_megamenu_width - (column_width - column_width_int) * columns);
			}

			if (!isVerticalMenu && !isHamburgerMenu && !isPerspectiveMenu && containerWidthCallback === undefined) {
				if (megamenu_width > parent_width) {
					var left = -(megamenu_width - parent_width) / 2;
				} else {
					var left = 0;
				}

				var container_offset = getOffset($container[0]);
				var megamenu_offset = getOffset(self);

				if ((megamenu_offset.x - container_offset.x - container_padding_left + left) < 0) {
					left = -(megamenu_offset.x - container_offset.x - container_padding_left);
				}

				if ((megamenu_offset.x + megamenu_width + left) > (container_offset.x + $container.outerWidth() - container_padding_right)) {
					left -= (megamenu_offset.x + megamenu_width + left) - (container_offset.x + $container.outerWidth() - container_padding_right);
				}

				$item.css('left', left).css('left');
			}

			if ($item.hasClass('megamenu-masonry')) {
				var positions = {},
					max_bottom = 0;

				$item.width($item.width() - 1);
				var new_row_height = $('.megamenu-new-row', $item).outerHeight() + parseInt($('.megamenu-new-row', $item).css('margin-bottom'));

				$('> li.menu-item', $item).each(function() {
					var pos = $(this).position();
					if (positions[pos.left] != null && positions[pos.left] != undefined) {
						var top_position = positions[pos.left];
					} else {
						var top_position = pos.top;
					}
					positions[pos.left] = top_position + $(this).outerHeight() + new_row_height + parseInt($(this).css('margin-bottom'));
					if (positions[pos.left] > max_bottom)
						max_bottom = positions[pos.left];
					$(this).css({
						left: pos.left,
						top: top_position
					})
				});

				$item.height(max_bottom - new_row_height - parseInt($item.css('padding-top')) - 1);
				$item.addClass('megamenu-masonry-inited');
			}

			if ($item.hasClass('megamenu-empty-right')) {
				var mega_width = $item.width();
				var max_rights = {
					columns: [],
					position: -1
				};

				$('> li.menu-item', $item).removeClass('megamenu-no-right-border').each(function() {
					var pos = $(this).position();
					var column_right_position = pos.left + $(this).width();

					if (column_right_position > max_rights.position) {
						max_rights.position = column_right_position;
						max_rights.columns = [];
					}

					if (column_right_position == max_rights.position) {
						max_rights.columns.push($(this));
					}
				});

				if (max_rights.columns.length && max_rights.position >= (mega_width - 7)) {
					max_rights.columns.forEach(function($li) {
						$li.addClass('megamenu-no-right-border');
					});
				}
			}

			if (isVerticalMenu || isHamburgerMenu || isPerspectiveMenu) {
				var clientHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight,
					itemOffset = $item.offset(),
					itemHeight = $item.outerHeight(),
					scrollTop = $(window).scrollTop();

				if (itemOffset.top - scrollTop + itemHeight > clientHeight) {
					$item.css({
						top: clientHeight - itemOffset.top + scrollTop - itemHeight - 20
					});
				}
			}

			$item.addClass('megamenu-inited');
	}

	window.fix_megamenu_position = fix_megamenu_position;

	$('#primary-menu > li.megamenu-template-enable').each(function() {

		if ($(this).parents('.thegem-te-menu > nav').hasClass("thegem-te-menu__overlay")) {
			$(this).removeClass('megamenu-template-enable');
			$(this).find('.megamenu-template').remove();
			return;
		}

		let $item = $('.megamenu-template', this);
		if ($item.length == 0) return;
		fix_megamenu_template_position(this);

		if ($item.data('template')) {
			let templateID = $item.data('template');
			$.ajax({
				url: thegem_dlmenu_settings.ajax_url,
				data: {
					'action': 'get_megamenu_template',
					'id': templateID
				},
				dataType: 'json',
				method: 'POST',
				success: function (response) {
					if (response.status === 'success') {
						$item.html(response.data);
					}
				},
				error: function () {
					console.log('loading megamenu template ajax error');
				}
			});
		}
		$item.addClass('megamenu-template-item-inited');

		$(this).hover(
			function() {
				fix_megamenu_template_position(this);
			},
			function() {}
		);
	});

	function fix_megamenu_template_position(elem, containerWidthCallback) {
		if (!$('.megamenu-template-inited', elem).length && isResponsiveMenuVisible()) {
			return false;
		}

		let $item = $('.megamenu-template', elem);
		if ($item.length == 0) return;
		let self = $item.get(0);

		$item.addClass('megamenu-template-item-inited');
		let isWidth100 = $item.hasClass("template-width-fullwidth");

		let default_item_css = {
			// 	width: 'auto',
			// 	height: 'auto'
		};

		if (!isVerticalMenu && !isHamburgerMenu && !isPerspectiveMenu) {
			default_item_css.left = 0;
		}

		$item.css(default_item_css);

		if (isResponsiveMenuVisible()) {
			return;
		}

		let $container = $item.closest('.header-main'),
			container_width,
			container_padding_left,
			container_padding_right,
			parent_width;
		if (containerWidthCallback !== undefined) {
			container_width = containerWidthCallback();
		} else if (isVerticalMenu) {
			container_width = window.gemOptions.clientWidth - $('#site-header-wrapper').outerWidth();
		} else if (isPerspectiveMenu) {
			container_width = window.gemOptions.clientWidth - $('#primary-navigation').outerWidth();
		} else if (isHamburgerMenu) {
			container_width = window.gemOptions.clientWidth - $('#primary-menu').outerWidth();
		} else {
			container_width = $container.width();
			container_padding_left = parseFloat($container.css('padding-left'));
			container_padding_right = parseFloat($container.css('padding-right'));
			parent_width = $item.parent().outerWidth();
		}

		let megamenu_width = $item.outerWidth();

		if (isWidth100 || megamenu_width > document.body.clientWidth) {
			$item.css('width', document.body.clientWidth);
		} else if ($item.hasClass("template-width-boxed") && !isVerticalMenu && !isHamburgerMenu && !isPerspectiveMenu) {
			$item.css('width', container_width);
		}
		megamenu_width = $item.outerWidth();

		if (!isVerticalMenu && !isHamburgerMenu && !isPerspectiveMenu && containerWidthCallback === undefined) {
			let left = 0;

			let container_offset = getOffset($container[0]);
			let megamenu_offset = getOffset(self);

			if (isWidth100) {
				left = -megamenu_offset.x;
			} else {
				if (megamenu_width > container_width) {
					left = container_offset.x - megamenu_offset.x - (megamenu_width - container_width)/2;
				} else if (megamenu_width === container_width) {
					left = container_offset.x - megamenu_offset.x + container_padding_left;
				} else {

					if (megamenu_width > parent_width) {
						left = -(megamenu_width - parent_width) / 2;
					}

					if ((megamenu_offset.x - container_offset.x - container_padding_left + left) < 0) {
						left = -(megamenu_offset.x - container_offset.x - container_padding_left);
					}

					if ((megamenu_offset.x + megamenu_width + left) > (container_offset.x + $container.outerWidth() - container_padding_right)) {
						left -= (megamenu_offset.x + megamenu_width + left) - (container_offset.x + $container.outerWidth() - container_padding_right);
					}
				}
			}

			$item.css('left', left).css('left');
		}

		if (isVerticalMenu || isHamburgerMenu || isPerspectiveMenu) {
			if (megamenu_width > container_width) {
				$item.css('width', container_width);
			}
			let clientHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight,
				itemOffset = $item.offset(),
				itemHeight = $item.outerHeight(),
				scrollTop = $(window).scrollTop();

			if (itemOffset.top - scrollTop + itemHeight > clientHeight) {
				$item.css({
					top: clientHeight - itemOffset.top + scrollTop - itemHeight - 20
				});
			}
		}

		$item.addClass('megamenu-template-inited');
	}

	function primary_menu_reinit() {
		if(isResponsiveMenuVisible()) {
			if (window.gemMobileMenuType == 'default') {
				var $submenuDisabled = $('#primary-navigation .dl-submenu-disabled');
				if ($submenuDisabled.length) {
					$submenuDisabled.addClass('dl-submenu').removeClass('dl-submenu-disabled');
				}
			}
			if ($('#primary-menu').hasClass('no-responsive')) {
				$('#primary-menu').removeClass('no-responsive');
			}
			if (!$('#primary-navigation').hasClass('responsive')) {
				$('#primary-navigation').addClass('responsive');
			}
			$('.menu-overlay').addClass('mobile');
			if (window.thegemDesktopMenuLogoFixed) {
				window.fixMenuLogoPosition();
			}

			if($('body').hasClass('mobile-cart-position-top')) {
				$('.mobile-cart > .minicart-menu-link.temp').remove();
				$('#primary-navigation .menu-item-cart > *').appendTo('.mobile-cart');
			}
		} else {
			window.thegemWasDesktop = true;

			if (window.gemMobileMenuType == 'overlay' && !$('.header-layout-overlay').length && $('.menu-overlay').hasClass('active')) {
				$('.mobile-menu-layout-overlay .menu-toggle').click();
			}

			$('#primary-navigation').addClass('without-transition');

			if (window.gemMobileMenuType == 'default') {
				$('#primary-navigation .dl-submenu').addClass('dl-submenu-disabled').removeClass('dl-submenu');
			}
			$('#primary-menu').addClass('no-responsive');
			$('#primary-navigation').removeClass('responsive');
			$('.menu-overlay').removeClass('mobile');

			window.fixMenuLogoPosition();

			if (!window.megaMenuWithSettingsFixed) {
				fixMegaMenuWithSettings();
			}

			$('#primary-navigation').removeClass('without-transition');

			if($('body').hasClass('mobile-cart-position-top')) {
				$('.mobile-cart > .minicart-menu-link.temp').remove();
				$('.mobile-cart > *').appendTo('#primary-navigation .menu-item-cart');
			}
		}
	}

	$(function() {
		function getScrollY(elem){
			return window.pageYOffset || document.documentElement.scrollTop;
		}
		$(document).on('click touchend', '.mobile-cart > a', function(e) {
			e.preventDefault();
			$('.mobile-cart .minicart').addClass('minicart-show');
			$('body').data('scroll-position', getScrollY())
			$('body').addClass('mobile-minicart-opened');
		});
		$(document).on('click', '.mobile-cart-header-close, .mobile-minicart-overlay', function(e) {
			e.preventDefault();
			$('.mobile-cart .minicart').removeClass('minicart-show');
			$('body').removeClass('mobile-minicart-opened');
			if($('body').data('scroll-position')) {
				window.scrollTo(0, $('body').data('scroll-position'))
			}
		});

		if (isResponsiveMenuVisible() && typeof window.gemResponsiveCartClicked !== 'undefined' && window.gemResponsiveCartClicked) {
			$('.mobile-cart-position-top .mobile-cart > a').trigger('click');
			window.gemResponsiveCartClicked = null;
		}

	});

	if (window.gemMobileMenuType == 'default') {
		$('#primary-navigation .submenu-languages').addClass('dl-submenu');
	}
	$('#primary-navigation ul#primary-menu > li.menu-item-language, #primary-navigation ul#primary-menu > li.menu-item-type-wpml_ls_menu_item').addClass('menu-item-parent');
	$('#primary-navigation ul#primary-menu > li.menu-item-language > a, #primary-navigation ul#primary-menu > li.menu-item-type-wpml_ls_menu_item > a').after('<span class="menu-item-parent-toggle"></span>');

	fixMegaMenuWithSettings();

	if (window.gemMobileMenuType == 'default') {
		var updateMobileMenuPosition = function() {
			var siteHeaderHeight = $('#site-header').outerHeight(),
				windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

			if ($('#thegem-perspective #primary-menu').length) {
				$('#thegem-perspective > .mobile-menu-layout-default').css({
					top: siteHeaderHeight
				});
			}

			$('#primary-menu').css({
				maxHeight: windowHeight - siteHeaderHeight
			});
		};

		$(window).resize(function() {
			if (isResponsiveMenuVisible() && $('#primary-menu').hasClass('dl-menuopen')) {
				setTimeout(updateMobileMenuPosition, 50);
			} else {
				$('#primary-menu').css({
					maxHeight: ''
				});
			}
		});

		$('#site-header .dl-trigger').on('click', function() {
			updateMobileMenuPosition();
		});

		if (typeof $.fn.dlmenu === 'function') {
			$('#primary-navigation').dlmenu({
				animationClasses: {
					classin : 'dl-animate-in',
					classout : 'dl-animate-out'
				},
				onLevelClick: function (el, name) {
					//$('html, body').animate({ scrollTop : 0 });
				},
				backLabel: thegem_dlmenu_settings.backLabel,
				showCurrentLabel: thegem_dlmenu_settings.showCurrentLabel
			});
		}
	}
	primary_menu_reinit();

	$('#primary-menu > li').hover(
		function() {
			var $items = $('ul:not(.minicart ul):not(.woocommerce-mini-cart), .minicart, .minisearch, .hidden-sidebar', this);
			$items.removeClass('invert vertical-invert');

			if (!$(this).hasClass('megamenu-enable') && !$(this).hasClass('megamenu-template-enable')) {
				$items.css({top: ''});
			}

			if ($(this).hasClass('megamenu-enable') || $(this).hasClass('megamenu-template-enable') ||
					$(this).closest('.header-layout-overlay').length ||
					$(this).closest('.mobile-menu-layout-overlay').length && isResponsiveMenuVisible()) {
				return;
			}

			var topItemTranslate = 0;
			if ($('>ul', this).css('transform')) {
				topItemTranslate = parseInt($('>ul', this).css('transform').split(',')[5]);
			}
			if (isNaN(topItemTranslate)) {
				topItemTranslate = 0;
			}
			var windowScroll = $(window).scrollTop(),
				siteHeaderOffset = $('#site-header').offset(),
				siteHeaderOffsetTop = siteHeaderOffset.top - windowScroll,
				siteHeaderHeight = $('#site-header').outerHeight(),
				pageOffset = $('#page').offset(),
				pageWidth = $('#page').width();

			$items.each(function() {
				var $item = $(this),
					self = this,
					$parentList = $item.parent().closest('ul');

				var itemOffset = $item.offset(),
					itemOffsetTop = itemOffset.top - windowScroll,
					itemOffsetLeft = itemOffset.left;


				var leftItemTranslate = 0;
				if ($item.css('transform')) {
					leftItemTranslate = parseInt(getComputedStyle(this).transform.split(',')[4]);
					var levelUL = getLevelULByPrimaryMenu(self);
					if (levelUL > 0) {
						leftItemTranslate = leftItemTranslate*levelUL;
					}
				}
				if (isNaN(leftItemTranslate)) {
					leftItemTranslate = 0;
				}

				if ($parentList.hasClass('invert')) {
					if ($parentList.offset().left - $item.outerWidth() > pageOffset.left) {
						$item.addClass('invert');
					}
				} else {
					if (itemOffsetLeft - leftItemTranslate - pageOffset.left + $item.outerWidth() > pageWidth) {
						$item.addClass('invert');
					}
				}

				if (isVerticalMenu || isPerspectiveMenu || isHamburgerMenu) {
					if (itemOffsetTop - topItemTranslate + $item.outerHeight() > $(window).height()) {
						$item.addClass('vertical-invert');
						var itemOffsetFix = itemOffsetTop  - topItemTranslate + $item.outerHeight() - $(window).height();
						if (itemOffsetTop - topItemTranslate - itemOffsetFix < 0) {
							itemOffsetFix = 0;
						}
						$item.css({ top: -itemOffsetFix + 'px' });
					}
				} else {
					if (itemOffsetTop - topItemTranslate + $item.outerHeight() > $(window).height()) {
						$item.addClass('vertical-invert');
						var itemOffsetFix = itemOffsetTop  - topItemTranslate + $item.outerHeight() - $(window).height();
						if (itemOffsetTop - topItemTranslate - itemOffsetFix < siteHeaderOffsetTop + siteHeaderHeight) {
							itemOffsetFix -= siteHeaderOffsetTop + siteHeaderHeight - (itemOffsetTop - topItemTranslate - itemOffsetFix);
							if (itemOffsetFix < 0) {
								itemOffsetFix = 0;
							}
						}
						if(itemOffsetFix > 0) {
							$item.css({ top: -itemOffsetFix + 'px' });
						}
					}
				}
			});
		},
		function() {}
	);

	function getLevelULByPrimaryMenu(item) {
		var parentUL = $(item).parent('li').parent('ul');
		var level = 0;

		while (!parentUL.is('#primary-menu')) {
			parentUL = parentUL.parent('li').parent('ul');
			level++;
		}

		return level;
	}

	$('.hamburger-toggle').click(function(e) {
		e.preventDefault();
		$(this).closest('#primary-navigation').toggleClass('hamburger-active');
		$('.hamburger-overlay').toggleClass('active');
	});

	$('.overlay-toggle, .mobile-menu-layout-overlay .menu-toggle').click(function(e) {
		var $element = this;
		e.preventDefault();
		if($('.menu-overlay').hasClass('active')) {
			$('.menu-overlay').removeClass('active');
			$('.primary-navigation').addClass('close');
			$('.primary-navigation').one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(e) {
				$('.primary-navigation').removeClass('overlay-active close');
				$('.overlay-menu-wrapper').removeClass('active');
			});
			$(document).off('keydown.overlay-close');
			$('#primary-menu').off('click.overlay-close');
		} else {
			$('.overlay-menu-wrapper').addClass('active');
			$('.primary-navigation').off('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend');
			$('.primary-navigation').addClass('overlay-active').removeClass('close');
			if (isResponsiveMenuVisible()) {
				$('#site-header').removeClass('hidden');
				$('.menu-overlay').addClass('mobile');
			} else {
				$('.menu-overlay').removeClass('mobile');
			}
			$('.menu-overlay').addClass('active');
			$(document).on('keydown.overlay-close', function(event) {
				if (event.keyCode == 27) {
					$element.click();
				}
			});
			$('#primary-menu').on('click.overlay-close', 'li:not(.menu-item-search)', function() {
				$element.click();
			});
		}
	});

	$('.mobile-menu-layout-slide-horizontal .primary-navigation #primary-menu li.menu-item-current, .mobile-menu-layout-slide-vertical .primary-navigation #primary-menu li.menu-item-current').each(function() {
		if (!isResponsiveMenuVisible()) {
			return;
		}

		$(this).addClass('opened');
		$('> ul', this).show();
	});

	function getScrollY(elem){
		return window.pageYOffset || document.documentElement.scrollTop;
	}

	$('.mobile-menu-layout-slide-horizontal .menu-toggle, .mobile-menu-layout-slide-vertical .menu-toggle, .mobile-menu-slide-wrapper .mobile-menu-slide-close').click(function(e) {
		if (!isResponsiveMenuVisible()) {
			return;
		}

		e.preventDefault();
		$('#site-header').removeClass('hidden');
		$('.mobile-menu-slide-wrapper').one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(e) {
			$(this).removeClass('animation');
		});
		$('.mobile-menu-slide-wrapper').addClass('animation').toggleClass('opened');
		$('#site-header').toggleClass('menu-slide-opened');
		if($('.mobile-menu-slide-wrapper').hasClass('opened')) {
			$('body').data('scroll-position', getScrollY())
			$('body').addClass('menu-scroll-locked');
		} else {
			$('body').removeClass('menu-scroll-locked');
			if($('body').data('scroll-position')) {
				window.scrollTo(0, $('body').data('scroll-position'))
			}
		}
		setTimeout(function() {
			$(document).on('click.mobile-menu-out-click', function(e) {
				if($('.mobile-menu-slide-wrapper').hasClass('opened')) {
					if(!$(e.target).is('#site-header *') && !$(e.target).is('#thegem-perspective *')) {
						e.preventDefault();
						$('.mobile-menu-slide-wrapper .mobile-menu-slide-close').trigger('click');
						$(document).off('click.mobile-menu-out-click');
					}
				}
			});
		}, 500);
	});

	if (isResponsiveMenuVisible() && typeof window.gemResponsiveMenuClicked !== 'undefined' && window.gemResponsiveMenuClicked) {
		$('.primary-navigation .menu-toggle').trigger('click');
		window.gemResponsiveMenuClicked = null;
	}

	$(document).on('click', '.mobile-menu-layout-slide-horizontal .primary-navigation #primary-menu .menu-item-parent-toggle, .mobile-menu-layout-slide-vertical .primary-navigation #primary-menu .menu-item-parent-toggle', function(e) {
		if (!isResponsiveMenuVisible()) {
			return;
		}

		e.preventDefault();
		var self = this;
		$(this).closest('li').toggleClass('opened');
		$(this).siblings('ul').slideToggle(200, function() {
			if (!$(self).closest('li').hasClass('opened')) {
				$(self).siblings('ul').find('li').removeClass('opened');
				$(self).siblings('ul').css('display', '');
				$(self).siblings('ul').find('ul').css('display', '');
			}
		});
	});

	$('.header-layout-overlay #primary-menu .menu-item-parent-toggle, .mobile-menu-layout-overlay .primary-navigation #primary-menu .menu-item-parent-toggle').on('click', function(e) {
		//if(!$('#primary-menu').hasClass('no-responsive')) return ;

		e.preventDefault();
		e.stopPropagation();

		if (!$('#primary-menu').hasClass('no-responsive') && !$(this).hasClass('menu-item-parent-toggle')) {
			return;
		}

		var $itemLink = $(this);
		var $item = $itemLink.closest('li');
		if($item.hasClass('menu-item-parent') && ($item.closest('ul').hasClass('nav-menu') || $item.parent().closest('li').hasClass('menu-overlay-item-open'))) {
			e.preventDefault();
			if($item.hasClass('menu-overlay-item-open')) {
				$(' > ul, .menu-overlay-item-open > ul', $item).each(function() {
					$(this).css({height: $(this).outerHeight()+'px'});
				});
				setTimeout(function() {
					$(' > ul, .menu-overlay-item-open > ul', $item).css({height: ''});
					$('.menu-overlay-item-open', $item).add($item).removeClass('menu-overlay-item-open');
				}, 50);
			} else {
				var $oldActive = $('.primary-navigation .menu-overlay-item-open').not($item.parents());
				$('> ul', $oldActive).not($item.parents()).each(function() {
					$(this).css({height: $(this).outerHeight()+'px'});
				});
				setTimeout(function() {
					$('> ul', $oldActive).not($item.parents()).css({height: ''});
					$oldActive.removeClass('menu-overlay-item-open');
				}, 50);
				$('> ul', $item).css({height: 'auto'});
				var itemHeight = $('> ul', $item).outerHeight();
				$('> ul', $item).css({height: ''});
				setTimeout(function() {
					$('> ul', $item).css({height: itemHeight+'px'});
					$item.addClass('menu-overlay-item-open');
					$('> ul', $item).one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function() {
						$('> ul', $item).css({height: 'auto'});
					});
				}, 50);
			}
		}
	});

	$('.vertical-toggle').click(function(e) {
		e.preventDefault();
		$(this).closest('#site-header-wrapper').toggleClass('vertical-active');
	});

	$(function() {
		$(window).resize(function() {
			if($('body').hasClass('e-preview--show-hidden-elements')) {
				primary_menu_reinit();
			} else {
				if (window.menuResizeTimeoutHandler) {
					clearTimeout(window.menuResizeTimeoutHandler);
				}
				window.menuResizeTimeoutHandler = setTimeout(primary_menu_reinit, 50);
			}
		});
		if($('body').hasClass('e-preview--show-hidden-elements')) {
			$(window).resize();
		}
	});

	$('#primary-navigation').on('click', 'a', function(e) {
		var $item = $(this);
		if($('#primary-menu').hasClass('no-responsive') && window.gemSettings.isTouch && $item.next('ul').length) {
			e.preventDefault();
		}
	});

	$(document).on('click', function(e) {
		if ($('.hamburger-overlay').hasClass('active') && !$(e.target).closest("#primary-menu").length && !$(e.target).closest(".hamburger-toggle").length) {
			$('.hamburger-toggle').trigger('click');
		}

		if ($("#site-header-wrapper").hasClass('vertical-active')) {
			if (!$("#site-header-wrapper").is(e.target) && $("#site-header-wrapper").has(e.target).length === 0) {
				$('.vertical-toggle').trigger('click');
			}
		}
	});

})(jQuery);

// Menu perspective
(function($) {
	var transitionEndEvent = {
			'WebkitTransition': 'webkitTransitionEnd',
			'MozTransition': 'transitionend',
			'OTransition': 'oTransitionEnd',
			'msTransition': 'MSTransitionEnd',
			'transition': 'transitionend'
		}[ window.supportedTransition ],
		clickEventName = 'click';

	function initPerspective() {
		var $menuToggleButton = $('.perspective-toggle'),
			$perspective = $('#thegem-perspective'),
			$page = $('#page');

		if (!$perspective.length) {
			return false;
		}

		$menuToggleButton.on(clickEventName, function(event) {
			if ($perspective.hasClass('animate')) {
				return;
			}

			var documentScrollTop = $(window).scrollTop();
			$(window).scrollTop(0);

			var pageWidth = $page.outerWidth(),
				perspectiveWidth = $perspective.outerWidth(),
				pageCss = {
					width: pageWidth
				};

			if (pageWidth < perspectiveWidth) {
				pageCss.marginLeft = $page[0].offsetLeft;
			}

			$page.css(pageCss);

			$perspective.addClass('modalview animate');
			$page.scrollTop(documentScrollTop);
			//$(window).trigger('perspective-modalview-opened');
			event.preventDefault();
			event.stopPropagation ? event.stopPropagation() : (event.cancelBubble=true);
		});

		$('#primary-navigation').on(clickEventName, function(event) {
			if (isResponsiveMenuVisible()) {
				return;
			}
			event.stopPropagation ? event.stopPropagation() : (event.cancelBubble=true);
		});

		$('#thegem-perspective .perspective-menu-close').on(clickEventName, function(event) {
			$perspective.click();
			event.preventDefault();
			event.stopPropagation ? event.stopPropagation() : (event.cancelBubble=true);
		});

		$perspective.on(clickEventName, function(event) {
			if (!$perspective.hasClass('animate')) {
				return;
			}

			var onEndTransitionCallback = function(event) {
				if (window.supportsTransitions && (event.originalEvent.target.id !== 'page' || event.originalEvent.propertyName.indexOf('transform' ) == -1)) {
					return;
				}

				$(this).off(transitionEndEvent, onEndTransitionCallback);
				var pageScrollTop = $page.scrollTop();
				$perspective.removeClass('modalview');
				$page.css({
					width: '',
					marginLeft: ''
				});
				$(window).scrollTop(pageScrollTop);
				$page.scrollTop(0);
				$(window).resize();
				//$(window).trigger('perspective-modalview-closed');
			};

			if (window.supportsTransitions) {
				$perspective.on(transitionEndEvent, onEndTransitionCallback);
			} else {
				onEndTransitionCallback.call();
			}

			$perspective.removeClass('animate');
		});
	}

	initPerspective();
})(jQuery);
