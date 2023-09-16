(function ($, elementor) {
	"use strict";

	$(window).on('elementor/frontend/init', function () {

		function debounce(func, wait, immediate) {
			var timeout;
			return function() {
				var context = this, args = arguments;
				var later = function() {
					timeout = null;
					if (!immediate) func.apply(context, args);
				};
				var callNow = immediate && !timeout;
				clearTimeout(timeout);
				timeout = setTimeout(later, wait);
				if (callNow) func.apply(context, args);
			};
		};
	

		let FrontEndExtended = elementorModules.frontend.handlers.Base.extend({

			generateInteractionsConfig: function () {
				this.interactionsConfig = {};
				if (this.getElementSettings('thegem_interaction_vertical_scroll') === 'yes') {
					this.interactionsConfig['vertical_scroll'] = 'yes';
					this.interactionsConfig['vertical_scroll_direction'] = 1; //1 - Up; -1 - Down;
					if (this.getElementSettings('thegem_interaction_vertical_scroll_direction') === 'negative') {
						this.interactionsConfig['vertical_scroll_direction'] = -1;
					}
					this.interactionsConfig['vertical_scroll_speed'] = this.getElementSettings('thegem_interaction_vertical_scroll_speed')['size']; //From 0 to 10
					this.interactionsConfig['vertical_viewport_bottom'] = this.getElementSettings('thegem_interaction_vertical_scroll_range')['sizes']['start'];
					this.interactionsConfig['vertical_viewport_top'] = this.getElementSettings('thegem_interaction_vertical_scroll_range')['sizes']['end'];
				} else {
					this.interactionsConfig['vertical_scroll'] = '';
				}

				if (this.getElementSettings('thegem_interaction_horizontal_scroll') === 'yes') {
					this.interactionsConfig['horizontal_scroll'] = 'yes';
					this.interactionsConfig['horizontal_scroll_direction'] = 1; //1 - Up; -1 - Down;
					if (this.getElementSettings('thegem_interaction_horizontal_scroll_direction') === 'negative') {
						this.interactionsConfig['horizontal_scroll_direction'] = -1;
					}
					this.interactionsConfig['horizontal_scroll_speed'] = this.getElementSettings('thegem_interaction_horizontal_scroll_speed')['size']; //From 0 to 10
					this.interactionsConfig['horizontal_viewport_bottom'] = this.getElementSettings('thegem_interaction_horizontal_scroll_range')['sizes']['start'];
					this.interactionsConfig['horizontal_viewport_top'] = this.getElementSettings('thegem_interaction_horizontal_scroll_range')['sizes']['end'];
				} else {
					this.interactionsConfig['horizontal_scroll'] = '';
				}

				if (this.getElementSettings('thegem_interaction_mouse') === 'yes') {
					this.interactionsConfig['mousemove'] = 'yes';
					this.interactionsConfig['mouse_direction'] = -1; //1 - Direct; -1 - Opposite
					if (this.getElementSettings('thegem_interaction_mouse_direction') === 'negative') {
						this.interactionsConfig['mouse_direction'] = 1;
					}
					this.interactionsConfig['mouse_speed'] = this.getElementSettings('thegem_interaction_mouse_speed')['size']; //From 0 to 10
				} else {
					this.interactionsConfig['mousemove'] = '';
				}

				if (this.getElementSettings('thegem_interaction_vertical_scroll') === 'yes' || this.getElementSettings('thegem_interaction_horizontal_scroll') === 'yes' || this.getElementSettings('thegem_interaction_mouse') === 'yes') {
					this.interactionsConfig['devices'] = this.getElementSettings('thegem_interaction_devices');
				}
			},

			setViewportValues: function () {
				if (this.interactionsConfig['vertical_scroll'] === 'yes') {
					if (this.interactionsConfig['vertical_viewport_bottom'] !== 0) {
						let vertical_viewport_bottom = (50 - this.interactionsConfig['vertical_viewport_bottom']) * this.interactionsConfig['vertical_scroll_speed'] * this.interactionsConfig['vertical_scroll_direction'];
						if (this.interactionsConfig['vertical_scroll_direction'] === 1) {
							this.$element[0].setAttribute('data-rellax-max-y', vertical_viewport_bottom);
						} else {
							this.$element[0].setAttribute('data-rellax-min-y', vertical_viewport_bottom);
						}
					}
					if (this.interactionsConfig['vertical_viewport_top'] !== 100) {
						let vertical_viewport_top = (50 - this.interactionsConfig['vertical_viewport_top']) * this.interactionsConfig['vertical_scroll_speed'] * this.interactionsConfig['vertical_scroll_direction'];
						if (this.interactionsConfig['vertical_scroll_direction'] === 1) {
							this.$element[0].setAttribute('data-rellax-min-y', vertical_viewport_top);
						} else {
							this.$element[0].setAttribute('data-rellax-max-y', vertical_viewport_top);
						}
					}
				}
				if (this.interactionsConfig['horizontal_scroll'] === 'yes') {
					if (this.interactionsConfig['horizontal_viewport_bottom'] !== 0) {
						let horizontal_viewport_bottom = (50 - this.interactionsConfig['horizontal_viewport_bottom']) * this.interactionsConfig['horizontal_scroll_speed'] * this.interactionsConfig['horizontal_scroll_direction'];
						if (this.interactionsConfig['horizontal_scroll_direction'] === 1) {
							this.$element[0].setAttribute('data-rellax-max-x', horizontal_viewport_bottom);
						} else {
							this.$element[0].setAttribute('data-rellax-min-x', horizontal_viewport_bottom);
						}
					}
					if (this.interactionsConfig['horizontal_viewport_top'] !== 100) {
						let horizontal_viewport_top = (50 - this.interactionsConfig['horizontal_viewport_top']) * this.interactionsConfig['horizontal_scroll_speed'] * this.interactionsConfig['horizontal_scroll_direction'];
						if (this.interactionsConfig['horizontal_scroll_direction'] === 1) {
							this.$element[0].setAttribute('data-rellax-min-x', horizontal_viewport_top);
						} else {
							this.$element[0].setAttribute('data-rellax-max-x', horizontal_viewport_top);
						}
					}
				}
			},

			getResponsiveVisibility: function () {
				let windowWidth = $(window).width();
				this.interactionsConfig['disableInteractions'] = this.interactionsConfig['devices'] !== undefined && this.interactionsConfig['devices'] !== '' && ((!this.interactionsConfig['devices'].includes("mobile") && windowWidth < 768) || (!this.interactionsConfig['devices'].includes("tablet") && windowWidth > 767 && windowWidth < 992) || (!this.interactionsConfig['devices'].includes("desktop") && windowWidth > 991));
			},

			setMouseValue: function (e) {
				let x_pos = (e.clientX / $(window).width() - 0.5) * 100 * this.interactionsConfig['mouse_speed'] * this.interactionsConfig['mouse_direction'];
				let y_pos = (e.clientY / $(window).height() - 0.5) * 100 * this.interactionsConfig['mouse_speed'] * this.interactionsConfig['mouse_direction'];
				this.mouseElement.css("transform", "translate3D(" + x_pos + "px, " + y_pos + "px, 0)");
			},

			bindEventMouse: function () {
				let element = this;
				this.mouseElement = this.$element.children(':not(.elementor-element-overlay)');
				elementorFrontend.elements.$window.on('mousemove touchmove', function (e) {
					if (element.interactionsConfig['mousemove'] === 'yes' && element.interactionsConfig['disableInteractions'] !== true) {
						element.setMouseValue(e);
					}
				});
			},

			startInteractions: function () {
				this.getResponsiveVisibility();
				if (this.interactionsConfig['disableInteractions'] === true) {
					if (this.$element.hasClass('thegem-interaction-scroll')) {
						this.$element.removeClass('thegem-interaction-scroll');
						this.rellax.destroy();
					}
					if (this.$element.hasClass('thegem-interaction-mouse')) {
						this.$element.removeClass('thegem-interaction-mouse');
						this.$element.children().css('transform', 'none');
					}
					return;
				}

				if (this.interactionsConfig['vertical_scroll'] === 'yes' || this.interactionsConfig['horizontal_scroll'] === 'yes') {

					if (this.$element.hasClass('thegem-interaction-scroll')) {
						this.$element[0].removeAttribute('data-rellax-min-y');
						this.$element[0].removeAttribute('data-rellax-max-y');
						this.$element[0].removeAttribute('data-rellax-min-x');
						this.$element[0].removeAttribute('data-rellax-max-x');
						this.rellax.destroy();
					} else {
						this.$element.addClass('thegem-interaction-scroll');
					}
					this.setViewportValues();

					this.rellax = new Rellax(this.$element[0], {
						speed: 0,
						verticalSpeed: this.interactionsConfig['vertical_scroll_speed'] ? this.interactionsConfig['vertical_scroll_speed'] * this.interactionsConfig['vertical_scroll_direction'] : null,
						horizontalSpeed: this.interactionsConfig['horizontal_scroll_speed'] ? this.interactionsConfig['horizontal_scroll_speed'] * this.interactionsConfig['horizontal_scroll_direction'] : null,
						center: true,
						horizontal: (this.interactionsConfig['horizontal_scroll'] === 'yes'),
						verticalScrollAxis: "xy",
					});
				} else {
					if (this.$element.hasClass('thegem-interaction-scroll')) {
						this.$element.removeClass('thegem-interaction-scroll');
						this.rellax.destroy();
					}
				}
				if (this.interactionsConfig['mousemove'] === 'yes') {
					this.$element.addClass('thegem-interaction-mouse');
					this.bindEventMouse();
				} else {
					if (this.$element.hasClass('thegem-interaction-mouse')) {
						this.$element.removeClass('thegem-interaction-mouse');
						this.$element.children().css('transform', 'none');
					}
				}
			},

			onElementChange: debounce(function() {
				this.generateInteractionsConfig();
				this.startInteractions();
			}, 200, false),

			onInit: function () {
				let editMode = Boolean(elementor.isEditMode());
				this.interactionsConfig = false;
				if (!editMode || thegem_interactions[this.getID()] !== undefined) {
					this.interactionsConfig = thegem_interactions[this.getID()] || false;
				} else {
					this.generateInteractionsConfig();
				}
				if (this.interactionsConfig) {
					this.startInteractions();
					let element = this;
					elementorFrontend.elements.$window.on('resize', function (e) {
						element.startInteractions();
					});
					elementorFrontend.elements.$window.on('load', function (e) {
						if (element.$element.hasClass('thegem-interaction-scroll')) {
							element.rellax.refresh();
						}
					});
				}
			},
		});

		elementorFrontend.hooks.addAction('frontend/element_ready/global', function ($element) {
			new FrontEndExtended({
				$element: $element
			});
		});
	});

}(jQuery, window.elementorFrontend));
