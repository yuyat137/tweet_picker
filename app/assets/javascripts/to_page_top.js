$(function() {
    $(document).on('click', '#to_page_top', function () {
        $('body,html').animate({
            scrollTop: 0
        }, 400);
        return false;
    });
});