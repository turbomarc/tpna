$ ->
  $("#members-list-download").on 'click', (event) ->
    event.preventDefault()

    query = $('#search').val()
    ren_query = $('#ren_search').val()
    ren_end_query = $('#ren_search_end').val()
    search_string = $.param({search: query}) if query
    # TODO: Add in ren_search and ren_search_end params to search_string
    download_uri = _.compact([$(@).prop('href'), search_string]).join('?')

    window.location = download_uri
