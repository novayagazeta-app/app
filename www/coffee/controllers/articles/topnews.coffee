app.controller 'TopnewsCtrl', ($scope, $controller, api) ->
  $controller "BaseArticlesCtrl", {$scope: $scope}

  $scope.title = "Топ новостей"

  $scope.more_articles = ->
    api.topnews offset: $scope.offset
    .success (data) -> $scope.push data.articles
    .finally -> $scope.$broadcast('scroll.infiniteScrollComplete')

  $scope.update_articles = ->
    api.topnews()
    .success (data) -> $scope.unshift data.articles
    .finally -> $scope.$broadcast('scroll.refreshComplete')
