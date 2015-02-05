$ ->
  $('content').on 'click', 'table .comment-content-answer', ->
    blockquote = $(@).closest('blockquote')
    $.get "/comment_section?user_id=#{$(@).closest('table').data('user-id')}&comment_id=#{blockquote.data('comment-id')}&ticket_id=#{blockquote.data('ticket-id')}", (data)->
      blockquote.after(data)
    false

  $('#page-body').on 'submit', 'form', ->
    form = $(@)
    $(@).ajaxSubmit
      success: (data) ->
      parent_id = form.find('input[name*="parent_id"]').val()
        $(data).appendTo( form.closest('td').find("blockquote[data-comment-id='#{parent_id}']") )
        form.remove()
    false