(function($) {
	function initBlogMasonryTimeline() {
		if (window.tgpLazyItems !== undefined) {
			var isShowed = window.tgpLazyItems.checkGroupShowed(this, function(node) {
				initBlogMasonryTimeline.call(node);
			});
			if (!isShowed) {
				return;
			}
		}

		var $blog = $(this),
			isTimeline = $blog.hasClass('blog-style-timeline_new');

		window.thegemUpdateLikesIcons($blog);

		if (isTimeline && $blog.closest('.vc_row[data-vc-stretch-content="true"]').length > 0) {
			$('.post-image img.img-responsive', $blog).removeAttr('srcset');
		}

		window.thegemBlogImagesLoaded($blog, 'article:not(.format-gallery) img, article.format-gallery .gem-gallery-item:first-child img', function() {
			$blog.prev('.preloader').remove();

			var itemsAnimations = $blog.itemsAnimations({
				itemSelector: 'article',
				scrollMonitor: true,
				firstItemStatic: isTimeline
			});

			var init_blog = true;
			if (isTimeline) {
				$blog
					.on('layoutComplete', function(event, laidOutItems) {
						laidOutItems.forEach(function(item) {
							if (item.position.x == 0) {
								$(item.element).removeClass('right-position').addClass('left-position');
							} else {
								$(item.element).removeClass('left-position').addClass('right-position');
							}
						});
					});
			}

			$blog
				.on( 'arrangeComplete', function( event, filteredItems ) {

					if (init_blog) {
						init_blog = false;
						itemsAnimations.show();
					}
				})
				.isotope({
					itemSelector: 'article',
					layoutMode: 'masonry',
					masonry: {
						columnWidth: 'article:not(.sticky)'
					},
					transitionDuration: 0
				});

			if ($blog.hasClass('fullwidth-block')) {
				$blog.bind('fullwidthUpdate', function() {
					if ($blog.data('isotope')) {
						$blog.isotope('layout');
						return false;
					}
				});
			}
		});

		var $blogParent = $blog;
		if (isTimeline) {
			$blogParent = $blog.parent();
		}
		$blogParent.siblings('.blog-load-more').on('click', function() {
			window.thegemBlogLoadMoreRequest($blog, $(this), false);
		});

		window.thegemInitBlogScrollNextPage($blog, $blogParent.siblings('.blog-scroll-pagination'));

	}

	$('.blog-style-masonry, .blog-style-timeline_new').each(initBlogMasonryTimeline);

	$.fn.initBlogMasonry = function () {
		$(this).each(initBlogMasonryTimeline);
	};
})(jQuery);
