document.addEventListener('theGemHeading.prepareAnimation', function(event) {
    const element = event.target;
    const animationName = element.dataset.animationName;

    if (element && ['lines-slide-up', 'lines-slide-up-random'].includes(animationName)) {
        theGemHeadingPrepareAnimation(element);
    }
});

function theGemHeadingPrepareAnimation(element) {
    if (!element) return;

    const isDesktop = window.innerWidth > 1024;
    const isTablet = window.innerWidth <= 1024 && window.innerWidth >= 768;
    const isMobile = window.innerWidth < 768;

    if (element.classList.contains('animation-prepared')) return;
    if (element.classList.contains('thegem-heading-animate-disable-desktop') && isDesktop) return;
    if (element.classList.contains('thegem-heading-animate-disable-tablet') && isTablet) return;
    if (element.classList.contains('thegem-heading-animate-disable-mobile') && isMobile) return;

    const animationName = element.dataset.animationName;
    const animationDelay = parseInt(element.dataset.animationDelay) || 0;
    const animationInterval = parseInt(element.dataset.animationInterval) || 0;

    switch (animationName) {
        case 'lines-slide-up':
        case 'lines-slide-up-random':
            const animationLineTagWrap = '<span class="thegem-heading-line-wrap">';

            let animationLineTag = function (index) {
                let styles = '';
                if (animationName === 'lines-slide-up' && (animationDelay > 0 || animationInterval > 0)) {
                    styles = `animation-delay: ${(animationDelay + (animationInterval*(index+1)))}ms;`;
                }
                return '<span class="thegem-heading-line"' + (styles!== '' ? ' style="'+styles+'"' : '') + '>';
            };

            let nodes = element.childNodes;
            let currentOffset = nodes[0].offsetTop;
            let index = 0;
            let idx = 0;

            let html = animationLineTagWrap + animationLineTag(index);

            for (let i = 0; i < nodes.length; i++) {
                if (nodes[i].nodeType === 3) continue;

                if (nodes[i].offsetTop > currentOffset + nodes[i].scrollHeight/2) {
                    index++;
                    html += '</span></span>' + animationLineTagWrap + animationLineTag(index);
                    currentOffset = nodes[i].offsetTop;

                    if (animationName === 'lines-slide-up-random') idx = 0;
                }

                if (animationName === 'lines-slide-up-random' && (animationDelay > 0 || animationInterval > 0)) {
                    nodes[i].style.animationDelay = (animationDelay + animationInterval*(idx+1)) + 'ms';
                }

                html += nodes[i].outerHTML + ' ';

                if (animationName === 'lines-slide-up-random') idx++;
            }

            html += '</span></span>';

            element.innerHTML = html;

            break;
    }

    element.classList.add('animation-prepared');
}