app.factory "api", ($http, settings) ->
    articles: (rubric_id, {limit, offset} = {}) ->
        limit ?= settings.limit
        offset ?= 0

        params =
            limit: limit
            offset: offset

        if rubric_id is 'topnews'
            url = "#{settings.domain}/topnews/"
        else
            url = "#{settings.domain}/articles/"
            params.rubric_id = rubric_id

        $http.get url,
            params: params

    article: (id) ->
        $http.get "#{settings.domain}/article/",
            params:
                "article_id": id

    comments: (id) ->
        $http.get("#{settings.domain}/comments/",
            params:
                "article_id": id
        )
