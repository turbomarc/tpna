$ ->
  $("#members-list-download").on 'click', (event) ->
    event.preventDefault()

    query = $('#search').val()
    search_string = $.param({search: query}) if query
    download_uri = _.compact([$(@).prop('href'), search_string]).join('?')

    window.location = download_uri
