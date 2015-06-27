services
.factory("http", ["$http", "domain", ($http, domain) ->
    {
        topnews: (limit, offset) ->
            $http.get("#{domain}/topnews/",
                params:
                    limit: limit
                    offset: offset
            )

        article: (id) ->
            $http.get("#{domain}/article/",
                params:
                    "article_id": id
            )

    }
])
