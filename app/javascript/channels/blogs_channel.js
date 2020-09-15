import consumer from "./consumer"

jQuery(document).on('turbolinks:load', function() {
  var comments;
  comments = $('#comments');
  if (comments.length > 0) {
    App.global_chat = App.cable.subscriptions.create({
    //App.global_chat = consumer.subscriptions.create({
      channel: "BlogsChannel",
      blog_id: comments.data('blog-id')
    }, {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        return comments.append(data['comment']);
      },
      send_comment: function(comment, blog_id) {
        return this.perform('send_comment', {
          comment: comment,
          blog_id: blog_id
        });
      }
    });
  }
  return $('#new_comment').submit(function(e) {
    var $this, textarea;
    $this = $(this);
    textarea = $this.find('#comment_content');
    if ($.trim(textarea.value()).length > 1) {
      App.global_chat.send_comment(textarea.value(), comments.data('blog-id'));
      textarea.value('');
    }
    e.preventDefault();
    return false;
  });
});
