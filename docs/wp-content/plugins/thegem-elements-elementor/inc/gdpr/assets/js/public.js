(function($) {
	'use strict';

	$(function() {
		const consentBarCookieName = thegem_gdpr_options.consent_bar_cookie_name;

		var $consentBar = $('.gdpr-consent-bar');

		$('.btn-gdpr-privacy-preferences-close').on('click', function() {
			$('.gdpr-privacy-preferences').fadeOut(300);
		});

		$('.btn-gdpr-preferences, .btn-gdpr-preferences-open').on('click', function(e) {
			e.preventDefault();
			$('.gdpr-privacy-preferences').fadeIn(300);
			return false;
		});

		$('.btn-gdpr-agreement').on('click', function() {
			if ($consentBar.hasClass('top') && !isShowAdminBar()) {
				$('html').animate({'margin-top': 0}, 400);
			}

			var $siteFixedHeader = $('#site-header.fixed');
			if (!getCookie(consentBarCookieName) && $siteFixedHeader.length > 0 && $consentBar.hasClass('top')) {
				$siteFixedHeader.animate({'top': 0}, 300);
				console.log('hide cookie bar');
			}

			$('.gdpr-consent-bar').fadeOut();
			setCookie(consentBarCookieName, 1);
		});

		$('.gdpr-privacy-preferences').on('click', function() {
			if ($(event.target).find('.gdpr-privacy-preferences-box').length>0) {
				$('.gdpr-privacy-preferences').fadeOut(300);
			}
		});

		function initConsentBar() {
			if ($consentBar.length > 0 && !getCookie(consentBarCookieName)) {
				if ($consentBar.hasClass('top') && !isShowAdminBar()) {
					$('html').css({'margin-top': $consentBar.height()+'px'});
				}
				$consentBar.fadeIn();
			}
		}

		function setCookie(name, value, days) {
			if (days === undefined) {
				days = 365;
			}

			var date = new Date();
			date.setTime(date.getTime() + (days*24*3600*1000));

			var options = {
				path: '/',
				expires: date
			};

			if (options.expires.toUTCString) {
				options.expires = options.expires.toUTCString();
			}

			let updatedCookie = encodeURIComponent(name) + "=" + encodeURIComponent(value);

			for (var optionKey in options) {
				updatedCookie += "; " + optionKey;
				var optionValue = options[optionKey];
				if (optionValue !== true) {
					updatedCookie += "=" + optionValue;
				}
			}

			document.cookie = updatedCookie;
		}

		function getCookie(name) {
			var matches = document.cookie.match(new RegExp(
				"(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
			));
			return matches ? decodeURIComponent(matches[1]) : undefined;
		}

		function isShowAdminBar() {
			return $('#wpadminbar').length > 0;
		}

		function fixSiteFixedHeader() {
			var $siteFixedHeader = $('#site-header.fixed');
			if (!getCookie(consentBarCookieName) && $siteFixedHeader.length > 0 && $consentBar.hasClass('top')) {
				$siteFixedHeader.css({'top': $consentBar.outerHeight()+'px'});
			}
		}

		$(window).on('scroll', function() {
			fixSiteFixedHeader();
		});

		$(window).on('load', function() {
			fixSiteFixedHeader();
		});

		$(window).on('resize', function() {
			fixSiteFixedHeader();
		});

		initConsentBar();

	});
})(jQuery);
