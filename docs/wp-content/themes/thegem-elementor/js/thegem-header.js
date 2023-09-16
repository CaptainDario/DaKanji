(function($) {

	function HeaderAnimation(el, options) {
		this.el = el;
		this.$el = $(el);
		this.options = {
			startTop: 1
		};
		$.extend(this.options, options);
		this.initialize();
	}

	HeaderAnimation.prototype = {
		initialize: function() {
			var self = this;
			this.$page = $('#page').length ? $('#page') : $('body');
			this.$wrapper = $('#site-header-wrapper');
			this.$topArea = $('#top-area');
			this.topAreaInSiteHeader = $('#site-header #top-area').length > 0;
			this.$headerMain = $('.header-main', this.$el);
			this.hasAdminBar = document.body.className.indexOf('admin-bar') != -1;
			this.adminBarOffset = 0;
			this.adminBarHeight = 0;
			this.topOffset = 0;
			this.oldScrollY = 0;
			this.isResponsive = null;
			this.isResponsiveOld = null;
			this.elHeight = this.$el.outerHeight();
			this.elHeightOld = this.$el.outerHeight();
			this.headerInited = false;
			this.windowWidth = $(window).width();

			this.hideWrapper = this.$wrapper.hasClass('site-header-wrapper-transparent');
			this.videoBackground = $('.page-title-block .gem-video-background').length && $('.page-title-block .gem-video-background').data('headerup');

			if(this.$el.hasClass('header-on-slideshow') && $('#main-content > *').first().is('.gem-slideshow, .block-slideshow')) {
				this.$wrapper.css({position: 'absolute'});
			}

			if(this.$el.hasClass('header-on-slideshow') && $('#main-content > *').first().is('.gem-slideshow, .block-slideshow')) {
				this.$wrapper.addClass('header-on-slideshow');
			} else {
				this.$el.removeClass('header-on-slideshow');
			}

			if(this.videoBackground) {
				this.$el.addClass('header-on-slideshow');
				this.$wrapper.addClass('header-on-slideshow');
			}

			this.initHeader();

			$(document).ready(function() {
				self.updateAdminBarInfo();
				self.updateStartTop();
			});

			$(window).scroll(function() {
				self.scrollHandler();
			});

			if ($('#thegem-perspective').length) {
				this.$page.scroll(function() {
					self.scrollHandler();
				});
			}

			$(window).resize(function() {
				setTimeout(function() {
					if (self.windowWidth != $(window).width() || $('body').hasClass('e-preview--show-hidden-elements')) {
						self.initHeader();
						self.scrollHandler();
						self.windowWidth = $(window).width();
					}
				}, 0);
			});

			//load header fix
			if (document.readyState === 'complete') {
				self.$el.addClass('ios-load');
			} else {
				var oldWindowLoad = window.onload;
				window.onload = function() {
					if (oldWindowLoad) {
						oldWindowLoad()
					}
					self.$el.addClass('ios-load');
				}
			}
		},

		initHeader: function() {
			this.isResponsiveOld = this.isResponsive;
			this.isResponsive = window.isResponsiveMenuVisible();
			this.elHeightOld = this.elHeight;
			this.elHeight = this.$el.outerHeight();

			if (this.isResponsive) {
				this.$el.addClass('shrink-mobile');
			} else {
				this.$el.removeClass('shrink-mobile');
			}

			this.updateAdminBarInfo();
			this.updateStartTop();
			if (this.isResponsive != this.isResponsiveOld || this.elHeight != this.elHeightOld) {
				this.initializeStyles();
			}
		},

		updateAdminBarInfo: function() {
			if (this.hasAdminBar) {
				this.adminBarHeight = $('#wpadminbar').outerHeight();
				this.adminBarOffset = this.hasAdminBar && $('#wpadminbar').css('position') == 'fixed' ? parseInt(this.adminBarHeight) : 0;
			}
		},

		updateStartTop: function() {
			if (this.$topArea.length && this.$topArea.is(':visible') && !this.topAreaInSiteHeader) {
				this.options.startTop = this.$topArea.outerHeight();
			} else {
				this.options.startTop = 1;
			}

			if (this.hasAdminBar && this.adminBarOffset == 0) {
				this.options.startTop += this.adminBarHeight;
			}
		},

		setMargin: function($img) {
			var $small = $img.siblings('img.small'),
				w = 0;

			if (this.$headerMain.hasClass('logo-position-right')) {
				w = $small.width();
			} else if (this.$headerMain.hasClass('logo-position-center') || this.$headerMain.hasClass('logo-position-menu_center')) {
				w = $img.width();
				var smallWidth = $small.width(),
					offset = (w - smallWidth) / 2;

				w = smallWidth + offset;
				$small.css('margin-right', offset + 'px');
			}
			if (!w) {
				w = $img.width();
			}
			$small.css('margin-left', '-' + w + 'px');
			$img.parent().css('min-width', w + 'px');

			$small.show();
		},

		initializeStyles: function() {
			var self = this;

			if (this.$headerMain.hasClass('logo-position-menu_center')) {
				var $img = $('#primary-navigation .menu-item-logo a .logo img.default', this.$el);
			} else {
				var $img = $('.site-title .site-logo a .logo img', this.$el);
			}

			if (!$img.length) {
				self.initializeHeight();
			} else if ($img[0].complete) {
				self.setMargin($img);
				self.initializeHeight();
			} else {
				$img.on('load error', function() {
					self.setMargin($img);
					self.initializeHeight();
				});
			}
		},

		initializeHeight: function() {
			if (this.hideWrapper) {
				this.headerInited = true;
				return false;
			}

			that = this;

			setTimeout(function() {
				var shrink = that.$el.hasClass('shrink');
				if (shrink) {
					that.$el.removeClass('shrink').addClass('without-transition');
				}
				var elHeight = that.$el.outerHeight();

				//load header fix
				if (navigator.userAgent.match(/(iPod|iPhone|iPad)/)) {
					that.$wrapper.css('min-height', elHeight);
				} else {
					that.$wrapper.height(elHeight);
				}

				if (shrink) {
					that.$el.addClass('shrink').removeClass('without-transition');
				}
				that.headerInited = true;
			}, 50);
		},

		scrollHandler: function() {
			if (!this.headerInited || window.gemSettings.fullpageEnabled || $('body').hasClass('vc_editor')) {
				return;
			}

			var self = this,
				scrollY = this.getScrollY();

			if (scrollY >= this.options.startTop) {
				if (this.isResponsive && this.$wrapper.hasClass('sticky-header-on-mobile-disabled') && scrollY < this.options.startTop + $('#site-header-wrapper').height()) {
					return;
				}
				if (!this.$el.hasClass('shrink')) {
					var shrinkClass = 'shrink fixed';
					if (window.gemSettings.fillTopArea) {
						shrinkClass += ' fill';
					}
					if (this.$wrapper.hasClass('sticky-header-on-mobile-disabled')) {
						shrinkClass += '  hidden hide-immediately';
					}
					this.$el.addClass(shrinkClass);
					//$('.hamburger-group').not('.hamburger-size-small-original').addClass('hamburger-size-small');
					//$('.perspective-toggle, .overlay-toggle').not('.toggle-size-small-original').addClass('toggle-size-small');
				}
				var top = 0;
				if (this.$page[0].scrollTop > 0) {
					top += this.$page[0].scrollTop;
				} else {
					if (this.hasAdminBar) {
						top += this.adminBarOffset;
					}
				}

				this.$el.css({
					top: top != 0 ? top : ''
				});
			} else {
				if (this.$el.hasClass('shrink')) {
					this.$el.removeClass('shrink fixed');
					//$('.hamburger-group').not('.hamburger-size-small-original').removeClass('hamburger-size-small');
					//$('.perspective-toggle, .overlay-toggle').not('.toggle-size-small-original').removeClass('toggle-size-small');
				}
				if (this.hasAdminBar) {
					this.$el.css({
						top: ''
					});
				}
			}

			if (this.isResponsive && !this.$wrapper.hasClass('sticky-header-on-mobile')) {
				if (!$('.mobile-menu-slide-wrapper.opened').length && !$('#primary-menu.dl-menuopen').length && !$('.menu-overlay.active').length) {
					var hideScroll = 300;
					if (this.$wrapper.hasClass('sticky-header-on-mobile-disabled')) {
						hideScroll = 0;
					}
					if (scrollY - this.oldScrollY > 0 && scrollY > hideScroll && !this.$el.hasClass('hidden')) {
						self.$el.addClass('hidden');
					}
					if (scrollY - this.oldScrollY < 0 && this.$el.hasClass('hidden')) {
						if (this.$el.hasClass('hide-immediately')) {
							self.$el.removeClass('hide-immediately');
						} else {
							self.$el.removeClass('hidden');
						}
					}
				} else {
					self.$el.removeClass('hidden');
				}
			}

			this.oldScrollY = scrollY;
		},

		getScrollY: function() {
			return window.pageYOffset || document.documentElement.scrollTop + this.$page[0].scrollTop;
		},
	};

	$.fn.headerAnimation = function(options) {
		options = options || {};
		return new HeaderAnimation(this.get(0), options);
	};

	$('#site-header.animated-header').headerAnimation();

	$('.menu-item-search a').on('click', function(e){
		e.preventDefault();
		if ($(this).closest('.menu-item-fullscreen-search-mobile').length &&
			$('.primary-navigation').hasClass('responsive')) {
			return;
		}
		if($(this).closest('.overlay-menu-wrapper.active').length) {
			var $primaryMenu = $('#primary-menu');
			$primaryMenu.addClass('overlay-search-form-show');

			if ($primaryMenu.hasClass('no-responsive')) {
				$primaryMenu.addClass('animated-minisearch');
			}

			setTimeout(function() {
				$(document).on('click.menu-item-search-close', 'body', function(e) {
					if(!$(e.target).is('.menu-item-search .minisearch *')) {
						var $primaryMenu = $('#primary-menu');

						if ($primaryMenu.hasClass('animated-minisearch')) {
							$primaryMenu.removeClass('animated-minisearch');

							setTimeout(function() {
								$primaryMenu.removeClass('overlay-search-form-show');
								$(document).off('click.menu-item-search-close');
							}, 700);

						} else {
							$primaryMenu.removeClass('overlay-search-form-show');
							$(document).off('click.menu-item-search-close');
						}
					}
				});
			}, 500);
		} else {
			$('.menu-item-search').toggleClass('active');
		}

		if(!$('#primary-navigation').hasClass('overlay-active')) {
			$('#searchform-input').focus();
		}
	});

	$(document).ready(function () {

		var localCache = {
			data: {},
			remove: function (url) {
				delete localCache.data[url];
			},
			exist: function (url) {
				return localCache.data.hasOwnProperty(url) && localCache.data[url] !== null;
			},
			get: function (url) {
				return localCache.data[url];
			},
			set: function (url, cachedData, callback) {
				localCache.remove(url);
				localCache.data[url] = cachedData;
				if ($.isFunction(callback)) callback(cachedData);
			}
		};

		if (navigator.appVersion.indexOf("Win")!=-1) {
			$('body').addClass('platform-Windows');
		}

		const $fullscreenSearch = $('.thegem-fullscreen-search[data-id="header-search"]'),
			$fullscreenSearchInput = $('.thegem-fullscreen-searchform-input', $fullscreenSearch),
			$fullscreenSearchResults = $fullscreenSearch.find('.sf-result'),
			$fullscreenSearchClose = $fullscreenSearch.find('.sf-close');

		let ajax, ajaxActive = false;

		const fullscreenSearchTop = () => {
			var searchTop;
			if ($('#page').hasClass('vertical-header') && $(window).width() > 979) {
				searchTop = 0;
			} else if ($('#site-header').hasClass('fixed')) {
				searchTop = $('#site-header').outerHeight();
			} else {
				searchTop = $('#site-header').offset().top + $('#site-header').outerHeight() - $(window).scrollTop();
			}
			$fullscreenSearch.css('top', searchTop);
		};

		$('.menu-item-fullscreen-search a, .menu-item-fullscreen-search-mobile a').on('click', function(e){
			let searchMenuItem = $(this).parents('.menu-item-search');
			if (searchMenuItem.hasClass('menu-item-fullscreen-search-mobile') &&
				!searchMenuItem.hasClass('menu-item-fullscreen-search') &&
				!$('.primary-navigation').hasClass('responsive')) {
				return;
			}

			e.preventDefault();
			fullscreenSearchTop();

			$fullscreenSearch.toggleClass('active');

			if (ajaxActive) {
				ajax.abort();
				ajaxActive = false;
			}

			$fullscreenSearchInput.val('');

			if ($('#site-header').hasClass('fixed')) {
				setTimeout(function () {
					$fullscreenSearchInput.focus();
				}, 500);
			} else {
				if ($(window).scrollTop() == 0) {
					$('html, body').stop().animate({
						scrollTop: 0
					}, 500);
				}
				$fullscreenSearchInput.focus();
			}

			$fullscreenSearchResults.find('.preloader-new').remove();
			$fullscreenSearchResults.find('.result-sections').html('');

			let scrollbarWidth = window.innerWidth - document.documentElement.clientWidth;
			$('.header-background, .top-area, .block-content, #page-title').css('padding-right', scrollbarWidth);

			$('body').toggleClass('fullscreen-search-opened');

			$('#thegem-perspective.modalview .perspective-menu-close').trigger('click');

			if ($('.primary-navigation').hasClass('responsive')) {
				$('.menu-toggle').trigger('click');
			}

			if ($(window).width() > 767) {
				$('.overlay-toggle').trigger('click');
			}

			if ($(window).width() > 979) {
				$('.hamburger-toggle').trigger('click');
				$('.vertical-toggle').trigger('click');
			}
		});

		$fullscreenSearchClose.on('click', function(e){
			e.preventDefault();
			$('.menu-item-fullscreen-search').removeClass('active');
			$fullscreenSearch.removeClass('active');
			$('.header-background, .top-area, .block-content, #page-title').css('padding-right', 0);
			$('body').removeClass('fullscreen-search-opened');
			if (ajaxActive) {
				ajax.abort();
				ajaxActive = false;
			}
			$fullscreenSearchInput.val('');
			$fullscreenSearchResults.find('.preloader-new').remove();
			$fullscreenSearchResults.find('.result-sections').html('');
		});

		$(document).keyup(function(e) {
			if (e.key === "Escape") {
				$('.fullscreen-search .sf-close').trigger('click');
			}
		});

		if ($fullscreenSearch.hasClass('ajax-search')) {

			const $ajaxSearchParams = $('#ajax-search-params'),
				postTypes = $ajaxSearchParams.data('post-types'),
				postTypesPpp = $ajaxSearchParams.data('post-types-ppp'),
				resultTitle = $ajaxSearchParams.data('result-title'),
				showAllText = $ajaxSearchParams.data('show-all');

			const ajaxSearch = (query) => {

				if (!$fullscreenSearchInput.hasClass('styled')) {
					let styles = $fullscreenSearchInput.data('styles');
					styles.forEach(function (style) {
						$('head').append('<link rel="stylesheet" type="text/css" href="' + style + '">');
					});
					$fullscreenSearchInput.addClass('styled');
				}

				if (ajaxActive) {
					ajax.abort();
				} else {
					$fullscreenSearchResults.prepend('<div class="preloader-new"><div class="preloader-spin"></div></div>');
				}

				ajax = $.ajax({
					type: 'post',
					url: thegem_scripts_data.ajax_url,
					data: {
						action: 'thegem_ajax_search',
						search: query,
						post_types: postTypes,
						post_types_ppp: postTypesPpp,
						result_title: resultTitle,
						show_all_text: showAllText,
					},
					beforeSend: function () {
						if (localCache.exist(query)) {
							$fullscreenSearchResults.find('.preloader-new').remove();
							$fullscreenSearchResults.find('.result-sections').html(localCache.get(query));
							return false;
						} else {
							ajaxActive = true;
						}
					},
					success: function (response) {
						ajaxActive = false;
						$fullscreenSearchResults.find('.preloader-new').remove();
						$fullscreenSearchResults.find('.result-sections').html(response);
						localCache.set(query, response);
					}
				});
			};

			$fullscreenSearchInput.on( 'keyup', function() {
				let query = $(this).val();

				if (query.length > 2) {
					ajaxSearch(query);
				} else {
					if (ajaxActive) {
						ajax.abort();
						ajaxActive = false;
					}
					$fullscreenSearchResults.find('.preloader-new').remove();
					$fullscreenSearchResults.find('.result-sections').html('');
				}
				return false;
			});

			$('.top-search-item', $fullscreenSearch).on( 'click', function(e) {
				e.preventDefault();
				var query = $(this).data('search');
				ajaxSearch(query);
				$fullscreenSearchInput.val(query);
				return false;
			});
		}



		const $verticalMinisearchAjax = $('.vertical-minisearch.menu-item-ajax-search');

		if ($verticalMinisearchAjax.length) {

			const $ajaxSearchParams = $('#ajax-search-params'),
				postTypes = $ajaxSearchParams.data('post-types'),
				postTypesPpp = $ajaxSearchParams.data('post-types-ppp'),
				$miniSearchForm = $('#searchform', $verticalMinisearchAjax),
				$miniSearchSubmitIcon = $('.sf-submit-icon', $verticalMinisearchAjax),
				$miniSearchInput = $('.sf-input', $verticalMinisearchAjax),
				$miniSearchResults = $('.ajax-minisearch-results', $verticalMinisearchAjax);

			const ajaxMiniSearch = (query) => {

				if (ajaxActive) {
					ajax.abort();
				}
				$miniSearchForm.addClass('ajax-loading');

				ajax = $.ajax({
					type : 'post',
					url : thegem_scripts_data.ajax_url,
					data : {
						action : 'thegem_ajax_search_mini',
						search : query,
						post_types : postTypes,
						post_types_ppp : postTypesPpp,
					},
					beforeSend: function() {
						if (localCache.exist(query)) {
							$miniSearchForm.removeClass('ajax-loading');
							$miniSearchResults.html( localCache.get(query) );
							return false;
						} else {
							ajaxActive = true;
						}
					},
					success: function( response ) {
						ajaxActive = false;
						$miniSearchResults.html( response );
						$miniSearchForm.removeClass('ajax-loading');
						localCache.set(query, response);
					}
				});
			};

			const clearAjaxMinisearch = () => {
				$miniSearchInput.val('');
				$miniSearchResults.html('');
				$miniSearchSubmitIcon.removeClass('clear');
				$miniSearchForm.removeClass('ajax-loading');
				if (ajaxActive) {
					ajax.abort();
					ajaxActive = false;
				}
			};

			$miniSearchInput.on( 'keyup', function() {
				let query = $(this).val();

				if (query.length > 0) {
					$miniSearchSubmitIcon.addClass('clear');
				} else {
					$miniSearchSubmitIcon.removeClass('clear');
				}

				if (query.length > 2) {
					ajaxMiniSearch(query);
				} else {
					if (ajaxActive) {
						ajax.abort();
						ajaxActive = false;
					}
					$miniSearchResults.html('');
					$miniSearchForm.removeClass('ajax-loading');
				}
				return false;
			});

			$miniSearchSubmitIcon.on('click', function () {
				if ($(this).hasClass('clear')) {
					clearAjaxMinisearch();
				}
			});

			$('.hamburger-toggle, #thegem-perspective .perspective-menu-close, .vertical-toggle').click(function() {
				clearAjaxMinisearch();
			});

		}


	});

})(jQuery);
