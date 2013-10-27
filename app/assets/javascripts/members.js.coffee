ajaxSearch = (input) ->
  $form = $(input).parents('form')
  $.get $form.attr("action"), $form.serialize(), null, "script"

$ ->
  $("#members-list-download").on 'click', (event) ->
    event.preventDefault()

    search_string = $(@).parents('form').serialize()
    download_uri = _.compact([@href, search_string]).join('?')

    window.location = download_uri

  $("#members").on "click", "th a, .pagination a", ->
    $.getScript @href
    false

  $("#search").keyup ->
    ajaxSearch(@)

  $("#ren_search, #ren_search_end").change ->
    ajaxSearch(@)
