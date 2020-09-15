import consumer from "./consumer"

$(document).on('turbolinks:load', function() {
  var comments;
  comments = $('#comments');
  if (comments.length > 0) {
    consumer.subscriptions.create({
      channel: "BlogsChannel",
      blog_id: comments.data('blog-id')
    }, {
      connected(){
        console.log("connected...")
      },
      disconnected() {},
      received(data) {
        var niles = comments.append(data['comment']);
        console.log(niles)
      },
      // send_comment(comment, blog_id) {
      //   return this.perform('send_comment', {
      //     comment: comment,
      //     blog_id: blog_id
      //   });
      // }
    });
  }
  // return $('#new_comment').submit(function(e) {
  //   var $this, textarea;
  //   $this = $(this);
  //   textarea = $this.find('#comment_content');
  //   if ($.trim(textarea.val()).length > 1) {
  //     consumer.send_comment(textarea.val(), comments.data('blog-id'));
  //     textarea.val('');
  //   }
  //   e.preventDefault();
  //   return false;
  // });
});
