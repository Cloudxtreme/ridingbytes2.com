jQuery(document).ready(function () {
    'use strict';

    // Smooth scrolling
    jQuery('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        var href = $anchor.attr('href');
        href = href.replace("/", "");
        $('html, body').stop().animate({
            scrollTop: $(href).offset().top
        }, 1500);
        event.preventDefault();
    });

});
