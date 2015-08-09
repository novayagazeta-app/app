app.controller "ArticlesCtrl", ($scope, api, $stateParams, rubrics, $controller) ->
  $controller "BaseArticlesCtrl", {$scope: $scope}

  rubric_id = parseInt($stateParams.rubricId, 10)

  $scope.title = _.findWhere(rubrics, {rubric_id: rubric_id}).title

  $scope.more_articles = ->
    api.articles rubric_id,
      offset: $scope.offset
    .success (data) -> $scope.push data.articles
    .finally -> $scope.$broadcast("scroll.infiniteScrollComplete")


  $scope.update_articles = ->
    api.articles()
    .success (data) -> $scope.unshift data.articles
    .finally -> $scope.$broadcast("scroll.refreshComplete")
