$ ->
  $('table').on 'click', '.comment-content', ->
    blockquotes = $(@)
    $.get "/comment_section?comment_id=#{$(@).data('comment-id')}&ticket_id=#{$(@).data('ticket-id')}", (data)->
      blockquotes.after(data)

  $('#page-body').on 'submit', 'form', ->
    form = $(@)
    $(@).ajaxSubmit
      success: (data) ->
        $(data).appendTo(form.closest('td').find('blockquote'))
    false