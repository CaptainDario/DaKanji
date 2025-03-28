(function($) {

	$.fn.buildTestimonialsCarousel = function() {

		var $testimonialsElement = $(this);

		$('.gem-testimonials:not(.gem-testimonials-built)', $testimonialsElement).each(function() {

			var $testimonialsElement = $(this);

			var $testimonials = $('.gem-testimonial-item', $testimonialsElement);

			var $testimonialsWrap = $('<div class="gem-testimonials-carousel-wrap"/>')
				.appendTo($testimonialsElement);
			var $testimonialsCarousel = $('<div class="gem-testimonials-carousel"/>')
				.appendTo($testimonialsWrap);
			if ($testimonialsElement.hasClass('fullwidth-block')) {
				$testimonialsCarousel.wrap('<div class="container" />');
			}
			var $testimonialsNavigation = $('<div class="gem-testimonials-navigation"/>')
				.appendTo($testimonialsWrap);
			var $testimonialsPrev = $('<a href="javascript:void(0);" class="gem-prev gem-testimonials-prev"/></a>')
				.appendTo($testimonialsNavigation);
			var $testimonialsNext = $('<a href="javascript:void(0);" class="gem-next gem-testimonials-next"/></a>')
				.appendTo($testimonialsNavigation);
			$testimonials.appendTo($testimonialsCarousel);
		});

		$(this).addClass('gem-testimonials-built');

	}

	$.fn.updateTestimonialsCarousel = function() {
		function initTestimonialsCarousel() {
			if (window.tgpLazyItems !== undefined) {
				var isShowed = window.tgpLazyItems.checkGroupShowed(this, function(node) {
					initTestimonialsCarousel.call(node);
				});
				if (!isShowed) {
					return;
				}
			}

			var $testimonialsElement = $(this);

			var $testimonialsCarousel = $('.gem-testimonials-carousel', $testimonialsElement);
			var $testimonials = $('.gem-testimonial-item', $testimonialsCarousel);
			var $testimonialsPrev = $('.gem-testimonials-prev', $testimonialsElement);
			var $testimonialsNext = $('.gem-testimonials-next', $testimonialsElement);

			$testimonialsElement.thegemPreloader(function() {

				var $testimonialsView = $testimonialsCarousel.carouFredSel({
					auto: ($testimonialsElement.data('autoscroll') > 0 ? $testimonialsElement.data('autoscroll') : false),
					circular: true,
					infinite: true,
					width: '100%',
					height: 'auto',
					items: 1,
					align: 'center',
					responsive: true,
					swipe: true,
					prev: $testimonialsPrev,
					next: $testimonialsNext,
					scroll: {
						pauseOnHover: true,
						fx: 'scroll',
						easing: 'easeInOutCubic',
						duration: 1000,
						onBefore: function(data) {
							data.items.old.css({
								opacity: 1
							}).animate({
								opacity: 0
							}, 500, 'linear');

							data.items.visible.css({
								opacity: 0
							}).animate({
								opacity: 1
							}, 1000, 'linear');
						}
					}
				});

			});
		}

		$('.gem-testimonials', this).add($(this).filter('.gem-testimonials')).each(initTestimonialsCarousel);
	}

	$(function() {
		$('body').buildTestimonialsCarousel();
		$('body').updateTestimonialsCarousel();
		$('.gem_tab').on('tab-update', function() {
			$(this).updateTestimonialsCarousel();
		});
	});

})(jQuery);