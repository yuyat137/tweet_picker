$(function() {
    $('tr[data-href]').addClass('clickable');
    $(document).on('click', function (e) {
        window.location = $(e.target).closest('tr').data('href');
    });
});