$(function() {
  masonry = setInterval(function () {
    console.log("sss")
    $('#tweet_list').masonry();
  }, 200);
  setTimeout(function () {
    clearInterval(masonry);
  }, 5000);
});
