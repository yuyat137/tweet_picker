$(function(){
  function toggleMenu(){
    $(this).toggleClass('is-active')
      .next('.js-dropdown-menu')
      .slideToggle(0);
    if($(this).hasClass('is-active')){
      $('#drop_down_arrow').css('color', 'white');
      $('.smartphone-menu').css('z-index', '9999');
    } else {
      $('#drop_down_arrow').css('color', 'black');
      $('.smartphone-menu').css('z-index', '9999');
    }
  }

  $('.js-dropdown').on('click', toggleMenu);
});
