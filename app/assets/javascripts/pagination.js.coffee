$ ->
  $('#page-body').on 'click', '.paginate a', ->
    content_block = $(@).closest('.content')
    $.get $(@).attr('href'), (data) ->
      content_block.html(data)
    false
