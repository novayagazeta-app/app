###
    factory http_requests
###

newspaper_services
.factory("http_requests", ["$http", "domain_name", ($http, domain_name) ->
    {

        topnews: (options) ->
            $http.get("#{domain_name}/topnews/",
                params:
                    limit: if options then options.limit
                    offset: if options then options.offset
            )

        articles: (options) ->
            $http.get("#{domain_name}/articles/",
                params:
                    limit: if options then options.limit
                    rubric_id: if options then options.rubric_id
                    offset: if options then options.offset
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
