###
    factory http_requests
###

newspaper_services
.factory("http_requests", ["$http", "domain_name", ($http, domain_name) ->
    {

        topnews: (optinos) ->
            $http.get("#{domain_name}/topnews/",
                params:
                    limit: if options and options.limit then optinos.limit
                    offset: if options and options.offset then optinos.offset
            )

        articles: (limit, offset, rubric_id) ->
            $http.get("#{domain_name}/articles/",
                params:
                    limit: limit
                    offset: offset
                    rubric_id: rubric_id
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
