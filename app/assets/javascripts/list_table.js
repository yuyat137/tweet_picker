$(function() {
    $('tr[data-href]').addClass('clickable');
    $('#table_style').on('click', function (e) {
        window.location = $(e.target).closest('tr').data('href');
    });
});