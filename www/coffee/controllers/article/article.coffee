controllers
.controller('ArticleCtrl', ['$scope', 'http', '$stateParams', ($scope, http, $stateParams) ->

        $scope.article = {}
        do $scope.show_spinner

        http.article($stateParams.articleId)
        .success((response) ->
            $scope.article = response
        )
        .finally(() ->
            do $scope.hide_spinner
        )

    ]
)
