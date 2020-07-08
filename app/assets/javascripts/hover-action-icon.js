$(function() {
  $('.reply-info').hover(
    function() {
      //マウスカーソルが重なった時の処理
      $(this).children('.reply-icon').children('a').children('img').attr('src', '/assets/reply-hover.png');
      $(this).children('.reply-icon').css({'background-color': 'rgba(0,255,255,0.1)'});
    },
    function() { 
      //マウスカーソルが離れた時の処理
      $(this).children('.reply-icon').children('a').children('img').attr('src', '/assets/reply.png');
      $(this).children('.reply-icon').css({'background-color': 'transparent'});
    }
  );
  $('.retweet-info').hover(
    function() {
      //マウスカーソルが重なった時の処理
      $(this).children('.retweet-icon').children('img').attr('src', '/assets/retweet-hover.png');
      $(this).children('.retweet-icon').css({'background-color': 'rgba(0,255,0,0.1)'});
      $(this).css({'color': 'rgba(0,200,0,1)'});
    },
    function() { 
      //マウスカーソルが離れた時の処理
      $(this).children('.retweet-icon').children('img').attr('src', '/assets/retweet.png');
      $(this).css({'color': 'black'});
      $(this).children('.retweet-icon').css({'background-color': 'transparent'});
    }
  );
  $('.favorite-info').hover(
    function() {
      //マウスカーソルが重なった時の処理
      $(this).children('.favorite-icon').children('img').attr('src', '/assets/favorite-hover.png');
      $(this).children('.favorite-icon').css({'background-color': 'rgba(255,0,0,0.1)'});
      $(this).css({'color': 'red'});
    },
    function() { 
      //マウスカーソルが離れた時の処理
      $(this).children('.favorite-icon').children('img').attr('src', '/assets/favorite.png');
      $(this).css({'color': 'black'});
      $(this).children('.favorite-icon').css({'background-color': 'transparent'});
    }
  );
});
