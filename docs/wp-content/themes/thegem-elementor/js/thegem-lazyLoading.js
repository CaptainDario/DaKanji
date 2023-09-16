(function($) {

	var prefixes = 'Webkit Moz ms Ms O'.split(' ');
    var docElemStyle = document.documentElement.style;

    function getStyleProperty( propName ) {
        if ( !propName ) {
            return;
        }

        // test standard property first
        if ( typeof docElemStyle[ propName ] === 'string' ) {
            return propName;
        }

        // capitalize
        propName = propName.charAt(0).toUpperCase() + propName.slice(1);

        // test vendor specific properties
        var prefixed;
        for ( var i=0, len = prefixes.length; i < len; i++ ) {
            prefixed = prefixes[i] + propName;
            if ( typeof docElemStyle[ prefixed ] === 'string' ) {
                return prefixed;
            }
        }
    }

    var transitionProperty = getStyleProperty('transition');
    var transitionEndEvent = {
        WebkitTransition: 'webkitTransitionEnd',
        MozTransition: 'transitionend',
        OTransition: 'otransitionend',
        transition: 'transitionend'
    }[ transitionProperty ];

	function getElementData(element, attributeNameCamel, attributeName, defaultValue) {
		if (element.dataset != undefined) {
			if (element.dataset[attributeNameCamel] != undefined) {
				return element.dataset[attributeNameCamel];
			} else {
				var value = $(element).data(attributeName);
				if (value == undefined) {
					return defaultValue;
				}
				return value;
			}
			return element.dataset[attributeNameCamel] != undefined ? element.dataset[attributeNameCamel] : defaultValue;
		}
		var value = this.getAttribute(attributeName);
		return value != null && value != '' ? value : defaultValue;
	}

	function Queue(lazyInstance) {
		this.lazyInstance = lazyInstance;
		this.queue = [];
		this.running = false;
		this.initTimer();
	}

	Queue.prototype = {
		add: function(element) {
			this.queue.push(element);
		},

		next: function() {
			if (this.running || this.queue.length == 0) return false;
			this.running = true;
			var element = this.queue.shift();
			if (element.isOnTop()) {
				element.forceShow();
				this.finishPosition();
				return;
			}
//			console.log(element.options['itemDelay']);
			setTimeout(function() {
			element.startAnimation();
			}, element.options['itemDelay']);
		},

		finishPosition: function() {
			this.running = false;
			this.next();
		},

		initTimer: function() {
			var self = this;

			this.timer = document.createElement('div');
			this.timer.className = 'lazy-loading-timer-element';
			document.body.appendChild(this.timer);

			this.timerCallback = function() {};
			$(this.timer).bind(transitionEndEvent, function(event) {
				self.timerCallback();
			});
			this.timer.className += ' start-timer';
		},

		startTimer: function(callback) {
			// this.timerCallback = callback;
			setTimeout(callback, 200);
			if (this.timer.className.indexOf('start-timer') != -1) {
				this.timer.className = this.timer.className.replace(' start-timer', '');
			} else {
				this.timer.className += ' start-timer';
			}
		}
	};

	function Group(el, lazyInstance) {
		this.el = el;
		this.$el = $(el);
		this.lazyInstance = lazyInstance;
		this.elements = [];
		this.showed = false;
		this.finishedElementsCount = 0;
		this.position = {
			left: 0,
			top: 0
		};
		this.options = {
			offset: parseFloat(getElementData(el, 'llOffset', 'll-offset', 0.7)),
			itemDelay: getElementData(el, 'llItemDelay', 'll-item-delay', -1),
			isFirst: lazyInstance.hasHeaderVisuals && this.el.className.indexOf('lazy-loading-first') != -1,
			force: getElementData(el, 'llForceStart', 'll-force-start', 0) != 0,
			finishDelay: getElementData(el, 'llFinishDelay', 'll-finish-delay', 200)
		};
		this.$el.addClass('lazy-loading-before-start-animation');
	}

	timeNow = function () {
		var newDate = new Date();
		return ((newDate.getHours() < 10)?"0":"") + newDate.getHours() +":"+ ((newDate.getMinutes() < 10)?"0":"") + newDate.getMinutes() +":"+ ((newDate.getSeconds() < 10)?"0":"") + newDate.getSeconds();
	}

	Group.prototype = {
		addElement: function(element) {
			this.elements.push(element);
		},

		setElements: function(elements) {
			this.elements = elements;
		},

		getElements: function() {
			return this.elements;
		},

		getElementsCount: function() {
			return this.elements.length;
		},

		getItemDelay: function() {
			return this.options.itemDelay;
		},

		updatePosition: function() {
			this.position = $(this.el).offset();
		},

		getPosition: function() {
			return this.position;
		},

		isShowed: function() {
			return this.showed;
		},

		isVisible: function() {
			if (this.options.force) return true;

			return (this.position.top + this.options.offset * this.el.offsetHeight <= this.lazyInstance.getWindowBottom()) &&
				(this.position.top + (1 - this.options.offset) * this.el.offsetHeight >= this.lazyInstance.getWindowTop());
		},

		isOnTop: function() {
			return false;
			//return this.position.top + this.el.offsetHeight < this.lazyInstance.getWindowBottom() - this.lazyInstance.getWindowHeight();
		},

		show: function() {
			this.lazyInstance.queue.add(this);
			this.showed = true;
		},

		forceShow: function() {
			this.showed = true;
			this.el.className = this.el.className.replace('lazy-loading-before-start-animation', 'lazy-loading-end-animation');
		},

		startAnimation: function() {
			var self = this;
			self.elements.forEach(function(element) {
				element.$el.bind(transitionEndEvent, function(event) {
					var target = event.target || event.srcElement;
					if (target != element.el) {
						return;
					}
					element.$el.unbind(transitionEndEvent);
					self.finishedElementsCount++;
					if (self.finishedElementsCount >= self.getElementsCount()) {
						setTimeout(function() {
							var className = self.el.className
								.replace('lazy-loading-before-start-animation', '')
								.replace('lazy-loading-start-animation', 'lazy-loading-end-animation');
							self.el.className = className;

							if (window.gemSettings.fullpageEnabled) {
								self.el.classList.add('fullpage-lazy-loading-initialized');
							}

						}, self.options.finishDelay);
					}
				});
				element.show();
			});

			if (self.options.finishDelay > 0) {
				self.lazyInstance.queue.startTimer(function() {
					self.finishAnimation();
				});
			} else {
				self.finishAnimation();
			}

			self.$el.addClass('lazy-loading-start-animation');
		},

		finishAnimation: function() {
			this.lazyInstance.queue.finishPosition();
		}
	};

	function Element(el, group) {
		this.el = el;
		this.$el = $(el);
		this.group = group;
		this.options = {
			effect: getElementData(el, 'llEffect', 'll-effect', ''),
			delay: getElementData(el, 'llItemDelay', 'll-item-delay', group.getItemDelay()),
			actionFunction: getElementData(el, 'llActionFunc', 'll-action-func', '')
		};
		this.options.queueType = this.options.delay != -1 ? 'async' : 'sync';
		if (this.options.effect != '') {
			this.$el.addClass('lazy-loading-item-' + this.getEffectClass());
		}
	}

	Element.prototype = {
		effects: {
			action: function(element) {
				if (!element.options.actionFunction ||
						window[element.options.actionFunction] == null ||
						window[element.options.actionFunction] == undefined) {
					return;
				}
				window[element.options.actionFunction](element.el);
			}
		},

		getEffectClass: function() {
			var effectClass = this.options.effect;
			if (effectClass == 'drop-right-without-wrap' || effectClass == 'drop-right-unwrap') {
				return 'drop-right';
			}
			return effectClass;
		},

		show: function() {
			if (this.effects[this.options.effect] != undefined) {
				this.effects[this.options.effect](this);
			}
		}
	};

	LazyLoading.prototype = {
		initialize: function() {
			this.queue = new Queue(this);
			this.groups = [];
			this.hasHeaderVisuals = $('.ls-wp-container').length > 0;
			this.$checkPoint = $('#lazy-loading-point');
			if (!this.$checkPoint.length) {
				$('<div id="lazy-loading-point"></div>').insertAfter('#main');
				this.$checkPoint = $('#lazy-loading-point');
			}
			this.windowBottom = 0;
			this.windowHeight = 0;
			this.scrollHandle = false;
			this.perspectiveOpened = false;
			this.$page = $('#page');
			$(document).ready(this.documentReady.bind(this));
		},

		documentReady: function() {
			var self = this;
			this.updateCheckPointOffset();
			this.updateWindowHeight();
			this.buildGroups();
			this.windowScroll();
			$(window).resize(this.windowResize.bind(this));

			$(window).scroll(this.windowScroll.bind(this));
			//this.$page.scroll(this.windowScroll.bind(this));
			$(window).on('perspective-modalview-opened', function() {
				self.perspectiveOpened = true;
			});
			$(window).on('perspective-modalview-closed', function() {
				self.perspectiveOpened = false;
			});
		},

		windowResize: function() {
			this.updateWindowHeight();
			this.updateGroups();
			this.windowScroll();
		},

		buildGroups: function() {
			var self = this;
			self.groups = [];

			$('.lazy-loading').each(function() {
				if (window.gemSettings.fullpageEnabled && $(this).hasClass('fullpage-lazy-loading-initialized')) {
					return;
				}

				var group = new Group(this, self);
				group.updatePosition();
				$('.lazy-loading-item', this).each(function() {
					group.addElement(new Element(this, group));
				});
				if (group.getElementsCount() > 0) {
					self.groups.push(group);
				}
			});
		},

		updateGroups: function() {
			var self = this;
			self.groups.forEach(function(group) {
				if (group.isShowed()) {
					return;
				}
				group.updatePosition();
			});
		},

		windowScroll: function() {
			if (this.scrollHandle) {
				//return;
			}
			this.scrollHandle = true;
			this.calculateWindowTop();
			this.calculateWindowBottom();
			if (this.isGroupsPositionsChanged()) {
				this.updateGroups();
			}
			this.groups.forEach(function(group) {
				if (group.isShowed()) {
					return;
				}
				if (group.isOnTop()) {
					group.forceShow();
				}
				if (group.isVisible()) {
					group.show();
				}
			});
			this.scrollHandle = false;
			this.queue.next();
		},

		calculateWindowBottom: function() {
			if (self.perspectiveOpened) {
				this.windowBottom = this.windowTop + this.$page.height();
			} else {
				this.windowBottom = this.windowTop + this.windowHeight;
			}
		},

		calculateWindowTop: function() {
			if (self.perspectiveOpened) {
				this.windowTop = this.$page.scrollTop();
			} else {
				this.windowTop = $(window).scrollTop();
			}
		},

		getWindowTop: function() {
			return this.windowTop;
		},

		getWindowBottom: function() {
			return this.windowBottom;
		},

		updateWindowHeight: function() {
			this.windowHeight = $(window).height();
		},

		getWindowHeight: function() {
			return this.windowHeight;
		},

		updateCheckPointOffset: function() {
			this.checkPointOffset = this.$checkPoint.length ? this.$checkPoint.offset().top : 0;
		},

		isGroupsPositionsChanged: function() {
			var oldCheckPointOffset = this.checkPointOffset;
			this.updateCheckPointOffset();
			return Math.abs(this.checkPointOffset - oldCheckPointOffset) > 1;
		},

		getLastGroup: function() {
			if (!this.groups.length) {
				return null;
			}
			return this.groups[this.groups.length - 1];
		}
	};

	function LazyLoading(options) {
		this.options = {};
		$.extend(this.options, options);
		this.initialize();
	}

	$.lazyLoading = function(options) {
		return new LazyLoading(options);
	}

	if (window.gemSettings !== undefined && !window.gemSettings.lasyDisabled) {
	    $('.wpb_text_column.wpb_animate_when_almost_visible.wpb_fade').each(function() {
	        $(this).wrap('<div class="lazy-loading"></div>').addClass('lazy-loading-item').data('ll-effect', 'fading');
	    });

	    $('.gem-list.lazy-loading').each(function() {
	        $(this).data('ll-item-delay', '200');
	        $('li', this).addClass('lazy-loading-item').data('ll-effect', 'slide-right');
	        $('li', this).each(function(index) {
	            $(this).attr("style", "transition-delay: " + (index + 1) * 0.2 + "s;");
	        });
	    });

	    $.lazyLoading();
	}

})(jQuery);
