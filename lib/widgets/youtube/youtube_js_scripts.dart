String pauseYoutubeVideosAtLoad = """
  (function() {
    function stopAutoplay() {
      document.querySelectorAll('video').forEach(video => {
        video.removeAttribute("autoplay");
        video.pause();
      });
    }

    // Run when the page loads
    document.addEventListener("DOMContentLoaded", stopAutoplay);
    
    // Run again after a delay to catch dynamically loaded videos
    setTimeout(stopAutoplay, 3000);
  })();
""";