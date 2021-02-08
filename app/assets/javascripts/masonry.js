$(function() {
  masonry = setInterval(function () {
    $('#tweet_list').masonry();
  }, 200);
  setTimeout(function () {
    clearInterval(masonry);
  }, 5000);
});
