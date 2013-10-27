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

  $("#renewal_date_start, #renewal_date_end").change ->
    ajaxSearch(@)
