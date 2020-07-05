$(function() {
  $('.reply-info').hover(
    function() {
      //マウスカーソルが重なった時の処理
      $(this).children('img').attr('src', '/assets/reply-hover.png');
      $(this).children('.reply-icon').css({'background-color': 'red'});
    },
    function() { 
      //マウスカーソルが離れた時の処理
      $(this).children('img').attr('src', '/assets/reply.png');
    }
  );
  $('.retweet-info').hover(
    function() {
      //マウスカーソルが重なった時の処理
      $(this).children('.retweet-icon').children('img').attr('src', '/assets/retweet-hover.png');
      $(this).children('.retweet-icon').css({'background-color': '#33FF33'});
      $(this).css({'color': '#33FF33'});
    },
    function() { 
      //マウスカーソルが離れた時の処理
      $(this).children('.retweet-icon').children('img').attr('src', '/assets/retweet.png');
      $(this).css({'color': 'black'});
    }
  );
  $('.favorite-info').hover(
    function() {
      //マウスカーソルが重なった時の処理
      $(this).children('.favorite-icon').children('img').attr('src', '/assets/favorite-hover.png');
      $(this).children('.favorite-icon').css({'background-color': 'red'});
      $(this).css({'color': 'red'});
    },
    function() { 
      //マウスカーソルが離れた時の処理
      $(this).children('.favorite-icon').children('img').attr('src', '/assets/favorite.png');
      $(this).css({'color': 'black'});
    }
  );
});
