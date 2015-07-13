services
.factory("http", ["$http", "domain", ($http, domain) ->
    {

        topnews: (limit, offset) ->
            $http.get("#{domain}/topnews/",
                params:
                    limit: limit
                    offset: offset
            )

        articles: (limit, offset, rubric_id) ->
            $http.get("#{domain}/articles/",
                params:
                    limit: limit
                    offset: offset
                    rubric_id: rubric_id
            )

        article: (id) ->
            $http.get("#{domain}/article/",
                params:
                    "article_id": id
            )

        comments: (id) ->
            $http.get("#{domain}/comments/",
                params:
                    "article_id": id
            )

    }
])
