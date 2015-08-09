app.controller 'CommentsCtrl', ($scope, $stateParams, api, utils) ->
  do $scope.show_spinner

  api.comments($stateParams.articleId)
  .success (data) -> $scope.comments = utils.comments_parser data.comments
  .finally -> do $scope.hide_spinner
