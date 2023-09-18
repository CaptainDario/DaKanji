(function($) {

	$.fn.initGalleryFancybox = function() {
	    $('a.fancy-gallery', this).fancybox({
	        caption : function( instance, item ) {
	            var slideInfo = $('.slide-info', this);
	            if ($('> *', slideInfo).length) {
	                return slideInfo.clone().html();
	            }
	        },
	        onInit: function(instance) {
	            instance.$refs.caption.addClass('fancybox-title');
	            instance.$refs.caption.parent().addClass('slideinfo');
	        }
	    });
	};

	$.fn.initPortfolioFancybox = function() {
		$('[data-fancybox="thegem-portfolio"]', this).fancybox();
	};

	$.fn.initBlogFancybox = function() {
		$('a.fancy, .fancy-link-inner a', this).fancybox();

		$('.blog article a.youtube, .blog article a.vimeo', this).fancybox({
			type: 'iframe'
		});
	};

	$.fn.initProductFancybox = function() {
		let isTouch = window.gemSettings.isTouch;

		$('a.fancy-product-gallery', this).fancybox({
			arrows: isTouch ? false : true,
			infobar: true,
			clickOutside: 'close',
			buttons: [
				'zoom',
				'fullScreen',
				'thumbs',
				'close',
			],
			touch: {
				vertical: false,
				momentum : false
			},
			loop : true,
			animationDuration: 300,
			backFocus: false,
			mobile: {
				fullScreen: false,
				arrows: false,
				animationEffect : 'fade',
				buttons: [
					'zoom',
					'fullScreen',
					'close',
				],
				clickContent: function(current, event) {
					return current.type === "image" ? "zoom" : false;
				},
				clickSlide: function(current, event) {
					return "close";
				},
			},
		});
	};

	$(document).initGalleryFancybox();
	$(document).initPortfolioFancybox();
	$(document).initBlogFancybox();
	$(document).initProductFancybox();

	$('a.fancy, .fancy-link-inner a').fancybox();
})(jQuery);
