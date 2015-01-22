$ ->
  $('table').on 'click', '.comment-content-answer', ->
    blockquotes = $(@)
    $.get "/comment_section?user_id=#{$(@).closest('table').data('user-id')}&comment_id=#{$(@).data('comment-id')}&ticket_id=#{$(@).data('ticket-id')}", (data)->
      blockquotes.after(data)
    false

  $('#page-body').on 'submit', 'form', ->
    form = $(@)
    $(@).ajaxSubmit
      success: (data) ->
        parent_id = form.find('input[name*="parent_id"]').val()
        $(data).appendTo( form.closest('td').find("blockquote[data-comment-id='#{parent_id}']") )
        form.remove()
    false