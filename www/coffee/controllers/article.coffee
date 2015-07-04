controllers
.controller('ArticleCtrl', ['$scope', 'http', '$stateParams', ($scope, http, $stateParams) ->

        $scope.article = {}

        http.article($stateParams.articleId)
        .success((response) ->
            $scope.article = response
        )

    ]
)
