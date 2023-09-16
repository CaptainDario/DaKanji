(function() {
    function TheGemHeading() {
        this.animateClass = 'thegem-heading-animate';
        this.animatedClass = 'thegem-heading-animated';
    }

    TheGemHeading.prototype = {
        initialize: function () {
            let items =  document.querySelectorAll('.'+this.animateClass);

            items.forEach((item)=>{
                if (this.isElementVisible(item)) {
                    this.prepareAnimation(item);
                    this.startAnimation(item);
                }
            });

            if ('IntersectionObserver' in window) {
                let intersectionObserver = new IntersectionObserver((entries)=>{
                    entries.forEach((entry)=> {
                        if (entry.isIntersecting) {
                            this.startAnimation(entry.target);
                            intersectionObserver.unobserve(entry.target);
                        }
                    });
                });

                items.forEach((item)=>{
                    intersectionObserver.observe(item);
                    this.prepareAnimation(item);
                });
            } else {
                items.forEach((item)=>{
                    this.prepareAnimation(item);
                    this.startAnimation(item);
                });
            }
        },

        isElementVisible: function (element) {
            let rect   = element.getBoundingClientRect(),
                width  = window.innerWidth || document.documentElement.clientWidth,
                height = window.innerHeight || document.documentElement.clientHeight,
                efp    = (x, y) => document.elementFromPoint(x, y);

            if (rect.right < 0 || rect.bottom < 0 || rect.left > width || rect.top > height) return false;
            return (element.contains(efp(rect.left,  rect.top)) ||  element.contains(efp(rect.right, rect.top)) ||  element.contains(efp(rect.right, rect.bottom)) ||  element.contains(efp(rect.left,  rect.bottom)));
        },

        startAnimation: function (element) {
            if (element && !element.classList.contains(this.animatedClass)) {
                element.classList.add(this.animatedClass);
                element.classList.remove(this.animateClass);
                element.dispatchEvent(new Event('theGemHeading.startAnimation', {bubbles: true}));
            }
        },

        prepareAnimation: function (element) {
            if (element && !element.isPreparedAnimation) {
                element.dispatchEvent(new Event('theGemHeading.prepareAnimation', {bubbles: true}));
                element.isPreparedAnimation = true;
            }
        }
    };

    window.theGemHeading = new TheGemHeading();
    document.addEventListener('DOMContentLoaded', function() {
        window.theGemHeading.initialize();
    });
})();