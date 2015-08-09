app.controller 'ArticleCtrl', ($scope, $stateParams, $ionicSlideBoxDelegate, api) ->
  do $scope.show_spinner

  $scope.article = {}

  api.article($stateParams.articleId)
  .success (data) -> $scope.article = data
  .finally -> do $scope.hide_spinner

  $scope.nextSlide = -> do $ionicSlideBoxDelegate.next
