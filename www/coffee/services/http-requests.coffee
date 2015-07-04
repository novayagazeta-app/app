services
.factory("http", ["$http", "domain", ($http, domain) ->
    {
        rubrics: () ->
            $http.get("#{domain}/rubrics/")


        topnews: (limit, offset) ->
            $http.get("#{domain}/topnews/",
                params:
                    limit: limit
                    offset: offset
            )

        articles: (rubric_id, limit, offset) ->
            $http.get("#{domain}/articles/",
                params:
                    limit: limit
                    rubric_id: rubric_id
                    offset: offset
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
