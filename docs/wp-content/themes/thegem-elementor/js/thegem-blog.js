(function($) {
	function initBlogDefault() {
		if (window.tgpLazyItems !== undefined) {
			var isShowed = window.tgpLazyItems.checkGroupShowed(this, function(node) {
				initBlogDefault.call(node);
			});
			if (!isShowed) {
				return;
			}
		}

		var $blog = $(this);

		window.thegemUpdateLikesIcons($blog);

		$('.blog-load-more', $blog.parent()).on('click', function() {
			window.thegemBlogLoadMoreRequest($blog, $(this), false);
		});

		$('.portfolio-navigator', $blog.parent()).on('click', 'a', function (e) {
			e.preventDefault();
			var current_page = $blog.data('current-page') ? $blog.data('current-page') : 1;
			var pages_count = $blog.data('pages-count');
			if ($(this).hasClass('current'))
				return false;
			var page;
			if ($(this).hasClass('prev')) {
				page = current_page - 1;
			} else if ($(this).hasClass('next')) {
				page = current_page + 1
			} else {
				page = $(this).data('page');
			}
			if (page < 1)
				page = 1;
			if (page > pages_count)
				page = pages_count;
			$blog.data('next-page', page);
			$(this).parents('.portfolio-navigator ').find('a').removeClass('current');
			$(this).parents('.portfolio-navigator ').find('a[data-page="' + page + '"]').addClass('current');
			$blog.data('current-page', page);
			if (page === 1) {
				$(this).parents('.portfolio-navigator ').find('a.prev').hide();
			} else {
				$(this).parents('.portfolio-navigator ').find('a.prev').show();
			}
			if (page == pages_count) {
				$(this).parents('.portfolio-navigator ').find('a.next').hide();
			} else {
				$(this).parents('.portfolio-navigator ').find('a.next').show();
			}
			window.thegemBlogLoadMoreRequest($blog, $(this), false);

			$("html, body").animate({scrollTop: $blog.offset().top - 200}, 600);
		});

		window.thegemInitBlogScrollNextPage($blog, $blog.siblings('.blog-scroll-pagination'));

		var itemsAnimations = $blog.itemsAnimations({
			itemSelector: 'article',
			scrollMonitor: true
		});
		itemsAnimations.show();

		window.thegemBlogImagesLoaded($blog, 'article:not(.format-gallery) img, article.format-gallery .gem-gallery-item:first-child img', function() {
			$blog.prev('.preloader').remove();
			if ($blog.hasClass('blog-style-justified-2x') || $blog.hasClass('blog-style-justified-3x') || $blog.hasClass('blog-style-justified-4x') || $blog.hasClass('blog-style-justified-100')) {
				window.thegemBlogOneSizeArticles($blog);
			}

		});
	}

	$('.blog:not(body,.blog-style-timeline_new,.blog-style-masonry)').each(initBlogDefault);

	$.fn.initBlogGrid = function () {
		$(this).each(initBlogDefault);
	};


	$(window).on('elementor/frontend/init', function () {
		elementorFrontend.hooks.addAction('frontend/element_ready/thegem-bloglist.default', function ($scope, $) {
			window.thegemUpdateLikesIcons($('.blog', $scope));
			$('.blog, .bloglist-pagination, .blog-load-more', $scope).thegemPreloader(function() {});
		});
	});
	$(window).on('elementor/frontend/init', function () {
		elementorFrontend.hooks.addAction('frontend/element_ready/thegem-blog-grid.default', function ($scope, $) {
			window.thegemUpdateLikesIcons($('.blog', $scope));
			$('.blog, .blog-grid-pagination, .blog-load-more', $scope).thegemPreloader(function() {});
		});
	});
	$(window).on('elementor/frontend/init', function () {
		elementorFrontend.hooks.addAction('frontend/element_ready/thegem-blogtimeline.default', function ($scope, $) {
			window.thegemUpdateLikesIcons($('.blog', $scope));
			$('.blog, .blogtimeline-pagination, .blog-load-more', $scope).thegemPreloader(function() {});
		});
	});

	$(window).on('resize', function(){
		$(".blog-style-justified-2x, .blog-style-justified-3x, .blog-style-justified-4x, .blog-style-justified-100").each(function(){
			window.thegemBlogOneSizeArticles($(this));
		});
	});

})(jQuery);
