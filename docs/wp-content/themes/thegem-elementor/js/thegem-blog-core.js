(function($) {
	window.thegemBlogImagesLoaded = function($box, image_selector, callback) {
		function check_image_loaded(img) {
			return img.complete && img.naturalWidth !== undefined && img.naturalWidth != 0;
		}

		var $images = $(image_selector, $box).filter(function() {
				return !check_image_loaded(this);
			}),
			images_count = $images.length;

		if (images_count == 0) {
			return callback();
		}

		if (window.gemBrowser.name == 'ie' && !isNaN(parseInt(window.gemBrowser.version)) && parseInt(window.gemBrowser.version) <= 10) {
			function image_load_event() {
				images_count--;
				if (images_count == 0) {
					callback();
				}
			}

			$images.each(function() {
				if (check_image_loaded(this)) {
					return;
				}

				var proxyImage = new Image();
				proxyImage.addEventListener( 'load', image_load_event );
				proxyImage.addEventListener( 'error', image_load_event );
				proxyImage.src = this.src;
			});
			return;
		}

		$images.on('load error', function() {
			images_count--;
			if (images_count == 0) {
				callback();
			}
		});
	}

	window.thegemInitBlogScrollNextPage = function($blog, $pagination) {
		if (!$pagination.length) {
			return false;
		}

		var watcher = scrollMonitor.create($pagination[0]);
		watcher.enterViewport(function() {
			window.thegemBlogLoadMoreRequest($blog, $pagination, true);
		});
	}

	function finishAjaxRequestActions($blog, $inserted_data, is_scroll, $pagination, next_page, $loading_marker) {
		if (window.wp !== undefined && window.wp.mediaelement !== undefined) {
			window.wp.mediaelement.initialize();
		}
		$blog.itemsAnimations('instance').show($inserted_data);

		if ($blog.hasClass('blog-style-justified-2x') || $blog.hasClass('blog-style-justified-3x') || $blog.hasClass('blog-style-justified-4x') || $blog.hasClass('blog-style-justified-100')) {
			window.thegemBlogImagesLoaded($blog, 'article img', function() {
				window.thegemBlogOneSizeArticles($blog);
			});
		}

		if (!$blog.hasClass('pagination-normal')) {
			if (is_scroll) {
				$pagination.removeClass('active').html('');
			} else {
				$loading_marker.remove();
				if (next_page == 0) {
					$pagination.hide();
				}
			}
		}
		$blog
			.data('request-process', false)
			.data('next-page', next_page);
	}

	window.thegemBlogLoadMoreRequest = function($blog, $pagination, is_scroll) {
		var data = thegem_blog_ajax;

		var is_processing_request = $blog.data('request-process') || false;
		if (is_processing_request) {
			return false;
		}

		var paged = $blog.data('next-page');
		if (paged == null || paged == undefined) {
			paged = 1;
		}
		if (paged == 0) {
			return false;
		}

		if (typeof data['data'] == 'string') {
			data['data'] = JSON.parse(data['data']);
		}
		data['data']['paged'] = paged;
		data['action'] = $blog.data('load-more-action') ? $blog.data('load-more-action') : 'blog_load_more';
		if ( data['action'] === 'thegem_bloggrid_load_more' ||  data['action'] === 'thegem_bloglist_load_more' ||  data['action'] === 'thegem_blogtimeline_load_more') {
			data['data'] = JSON.stringify(data['data']);
		}
		$blog.data('request-process', true);
		if ($blog.hasClass('pagination-normal')) {
			$blog.prepend('<div class="preloader-spin-new"></div>');
		} else if (is_scroll) {
			$pagination.addClass('active').html('<div class="loading"><div class="preloader-spin"></div></div>');
		} else {
			var $loading_marker = $('<div class="loading"><div class="preloader-spin"></div></div>');
			$('.gem-button-container', $pagination).before($loading_marker);
		}

		$.ajax({
			type: 'post',
			dataType: 'json',
			url: thegem_blog_ajax.url,
			data: data,
			success: function(response) {
				if (response.status == 'success') {
					var $newItems = $(response.html),
						$inserted_data = $($newItems.html()),
						current_page = $newItems.data('page'),
						next_page = $newItems.data('next-page');

					if ($blog.hasClass('pagination-normal')) {
						$blog.html($inserted_data);
						finishAjaxRequestActions($blog, $inserted_data, is_scroll, $pagination, next_page, $loading_marker);
					} else if ($blog.hasClass('blog-style-masonry') || $blog.hasClass('blog-style-timeline_new')) {
						window.thegemBlogImagesLoaded($newItems, 'article img', function() {
							$blog.isotope('insert', $newItems);
							finishAjaxRequestActions($blog, $inserted_data, is_scroll, $pagination, next_page, $loading_marker);
						});
					} else {
						$blog.append($inserted_data);
						finishAjaxRequestActions($blog, $inserted_data, is_scroll, $pagination, next_page, $loading_marker);
					}
					$blog.initBlogFancybox();
					window.thegemUpdateLikesIcons($blog);
				} else {
					alert(response.message);
				}
			}
		});
	}

	window.thegemBlogOneSizeArticles = function($blog){
		var elements = {};
		$("article", $blog).css('height', '');
		$("article", $blog).each(function(i, e){
			var transform = $(this).css('transform');
			var translateY = 0;

			if (transform != undefined && transform != 'none') {
				translateY = parseFloat(transform.substr(1, transform.length - 2).split(',')[5]);
				if (isNaN(translateY)) {
					translateY = 0;
				}
			}

			var elPosition = parseInt($(this).position().top - translateY);
			var elHeight = $(this).height();

			if(elements[elPosition] == undefined){
				elements[elPosition] = {'array':[$(this)], 'maxHeight':elHeight};
			} else {
				elements[elPosition]['array'].push($(this));
				if(elements[elPosition]['maxHeight'] < elHeight){
					elements[elPosition]['maxHeight'] = elHeight;
				}
			}
		});
		$.each(elements, function(i, e){
			var item = this;
			$.each(item.array, function(){
				$(this).height(item.maxHeight);
			});
		});
	}

	window.thegemUpdateLikesIcons = function($blog) {
		$blog.find('.post-meta-likes').each(function () {
			if ($(this).find('i').length) {
				if (!$(this).find('a').children('i').length) {
					var icon = $(this).children('i');
					$(this).find('a').prepend(icon);
				}
			} else if ($(this).find('svg').length) {
				if (!$(this).find('a').children('svg').length) {
					var icon_svg = $(this).children('svg');
					$(this).find('a').prepend(icon_svg);
				}
			}
		});
	}

})(jQuery);
