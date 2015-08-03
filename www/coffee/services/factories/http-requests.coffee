###
    factory http_requests
###

newspaper_services
.factory("http_requests", ["$http", "domain_name", ($http, domain_name) ->
    {

        topnews: (options) ->
            $http.get("#{domain_name}/topnews/",
                params:
                    limit: options?.limit
                    offset: options?.offset
            )

        articles: (options) ->
            $http.get("#{domain_name}/articles/",
                params:
                    limit: options?.limit
                    rubric_id: options?.rubric_id
                    offset: options?.offset
            )

        article: (id) ->
            $http.get("#{domain_name}/article/",
                params:
                    "article_id": id
            )

        comments: (id) ->
            $http.get("#{domain_name}/comments/",
                params:
                    "article_id": id
            )

    }
])
