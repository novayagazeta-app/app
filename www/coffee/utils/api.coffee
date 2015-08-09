app.factory "api", ($http, settings) ->
  topnews: ({limit, offset} = {}) ->
    limit ?= settings.limit
    offset ?= 0

    $http.get "#{settings.domain}/topnews/",
      params:
        limit: limit
        offset: offset

  articles: (rubric_id, {limit, offset} = {}) ->
    limit ?= settings.limit
    offset ?= 0

    $http.get "#{settings.domain}/articles/",
      params:
        rubric_id: rubric_id
        limit: limit
        offset: offset

  article: (id) ->
    $http.get("#{settings.domain}/article/",
      params:
        "article_id": id
    )

  comments: (id) ->
    $http.get("#{settings.domain}/comments/",
      params:
        "article_id": id
    )

