services
.factory("http", ["$http", "domain", ($http, domain) ->
    {
        topnews: () ->
            $http.get("#{domain}/topnews/")

        article: (id) ->
            $http.get("#{domain}/article/",
                params:
                    "article_id": id
            )

    }
])
