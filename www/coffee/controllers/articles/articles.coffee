newspaper_controllers
.controller('ArticlesCtrl', ['$scope', 'http_requests', '$stateParams', 'rubrics', '$controller',
    ($scope, http_requests, $stateParams, rubrics, $controller) ->

        # Inherits BaseController
        $controller "BaseArticlesCtrl", {$scope: $scope}

        rubric_id = parseInt($stateParams.rubricId)

        $scope.title = _.findWhere(rubrics, {rubric_id: rubric_id}).title


        $scope.more_articles = () ->
            http_requests.articles({
                limit: $scope.limit,
                offset: $scope.offset,
                rubric_id: rubric_id})
            .success((response) ->
                $scope.push response.articles
            )
            .finally(->
                $scope.$broadcast('scroll.infiniteScrollComplete')
            )


        $scope.update_articles = () ->
            http_requests.articles()
            .success((response) ->
                $scope.unshift response.articles
            )
            .finally(->
                $scope.$broadcast('scroll.refreshComplete')
            )

    ]
)
