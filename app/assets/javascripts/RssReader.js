var RssReader = RssReader || {};

RssReader.init = RssReader.init || {};

RssReader.ajax = RssReader.ajax || {};

RssReader.ajax.comments = RssReader.ajax.comments || {};

RssReader.ajax.comments.new = RssReader.ajax.comments.new || {};

RssReader.ajax.comments.new = function(){
  var links = $(".ajax-comment");

  links.each(function(){
    var link = $(this);
    var commentsFormContainer = link.closest(".comment-section");

    link.on("ajax:success", function(evt, data, status, xhr){
      commentsFormContainer.append(data);
      link.hide();

      var commentsContainer = $(".comments");
      var commentForm = $("form#new_comment");
      commentForm.on("ajax:success", function(evt, data, status, xhr){
        commentsContainer.append(data);
        commentForm.find("textarea").val("");
      });
    });
  });
}

RssReader.init = function(){
  RssReader.ajax.comments.new();
} 

$(document).ready(RssReader.init);