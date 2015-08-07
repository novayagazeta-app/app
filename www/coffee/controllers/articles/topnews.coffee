newspaper_controllers
.controller('TopnewsCtrl', ['$scope', 'http_requests', '$controller',
    ($scope, http_requests, $controller) ->

        # Inherits BaseController
        $controller "BaseArticlesCtrl", {$scope: $scope}

        $scope.title = "Топ новостей"


        $scope.more_articles = () ->
            http_requests.topnews({limit: $scope.limit, offset: $scope.offset})
            .success((response) ->
                $scope.push response.articles
            )
            .finally(->
                $scope.$broadcast('scroll.infiniteScrollComplete')
            )


        $scope.update_articles = () ->
            http_requests.topnews()
            .success((response) ->
                $scope.unshift response.articles
            )
            .finally(->
                $scope.$broadcast('scroll.refreshComplete')
            )

    ]
)