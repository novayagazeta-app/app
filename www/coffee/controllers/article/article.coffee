newspaper_controllers
.controller('ArticleCtrl', ['$scope', '$http', 'domain_name', '$stateParams',

    ($scope, $http, domain_name, $stateParams) ->

        $scope.article = {}

        get_article = () ->
            id = $stateParams.articleId
            $http.get("#{domain_name}/article/",
                params:
                    "article_id": id
            )
            .success((response) ->
                $scope.article = response
            )
            .finally(() ->
                do $scope.hide_spinner
            )


        do $scope.show_spinner
        do get_article

    ]
)
