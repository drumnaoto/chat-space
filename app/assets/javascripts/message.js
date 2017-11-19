$(document).on('turbolinks:load', function () {
  function buildHTML(message){
    var p = (message.body) ? '<p class="message">'+message.body+'</p>' : "";
    var i = (message.image.url) ? '<div class="image">'+'<img src = "'+message.image.url+'" width="200" %>'+'</div>': "";
    var html = '<div class= "message">'+
                  '<div class="upper-message">'+
                    '<div class="user-name">'+message.user_name+'</div>'+
                    '<div class= "date">'+message.created_at+'</div>'+
                  '</div>'+
                  '<div class="lower-message">'+
                    p+
                    i+
                  '</div>'+
                '</div>'
    return html;
  }
  $("#new_message").on("submit", function(e) {
    e.preventDefault();
    var formData = new FormData($(this).get(0));
    var href = $(this).attr('action');

    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(message) {
      var html = buildHTML(message);
      $('.messages').append(html);
      $('.form__message').val('');
      $('.form__image').val('');
      $('html, body').animate({scrollTop: $('.messages')[0].scrollHeight}, 'slow');
    })
    .fail(function(){
      alert('メッセージの送信に失敗しました');
    });
    return false;
  });
});

$(document).on('turbolinks:load', function () {

  function buildHTML(message) {
    var p = (message.body) ? '<p class="message">'+message.body+'</p>' : "";
    var i = (message.image.url) ? '<div class="image">'+'<img src = "'+message.image.url+'" width="200" %>'+'</div>': "";
    var html = '<div class= "message">'+
                  '<div class="upper-message">'+
                    '<div class="user-name">'+message.user_name+'</div>'+
                    '<div class= "date">'+message.created_at+'</div>'+
                  '</div>'+
                  '<div class="lower-message">'+
                    p+
                    i+
                  '</div>'+
                '</div>'
    return html
  }
  setInterval(update, 5000);
  var interval = setInterval;
  function update(){
    if (window.location.href.match(/\/groups\/\d+\/messages/)) {
      $.ajax({
        url: location.href,
        type: 'GET',
        dataType: 'json'
      })
      .done(function(messages) {
        var insertHTML = '';
        messages.forEach(function(message) {
          insertHTML += buildHTML(message);
        });
        $(".messages").html(insertHTML);
        $('html, body').animate({scrollTop: $('.messages')[0].scrollHeight}, 2000);
      })
      .fail(function(messages) {
        alert('自動更新に失敗しました');
      });
    } else {
      clearInterval(interval);
    };
  };
});
