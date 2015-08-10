app.controller "ArticlesCtrl", ($scope, api, $stateParams, rubrics, $controller, $analytics) ->
    $controller "BaseArticlesCtrl", {$scope: $scope}

    rubric_id = parseInt($stateParams.rubricId, 10) or $stateParams.rubricId

    $scope.title = _.findWhere(rubrics, {rubric_id: rubric_id}).title

    $scope.more_articles = ->
        $analytics.eventTrack 'more_articles',
            category: 'UI'
            label: $scope.title
            value: $scope.offset

        api.articles rubric_id,
            offset: $scope.offset
        .success (data) -> $scope.push data.articles
        .finally -> $scope.$broadcast("scroll.infiniteScrollComplete")


    $scope.update_articles = ->
        $analytics.eventTrack 'update_articles',
            category: 'UI'
            label: $scope.title

        api.articles()
        .success (data) -> $scope.unshift data.articles
        .finally -> $scope.$broadcast("scroll.refreshComplete")
