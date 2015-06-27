angular.module('starter.controllers', []).controller('AppCtrl', function($scope, $ionicModal, $timeout) {
  $scope.loginData = {};
  $ionicModal.fromTemplateUrl('templates/login.html', {
    scope: $scope
  }).then(function(modal) {
    return $scope.modal = modal;
  });
  $scope.closeLogin = function() {
    return $scope.modal.hide();
  };
  $scope.login = function() {
    return $scope.modal.show();
  };
  return $scope.doLogin = function() {
    console.log('Doing login', $scope.loginData);
    return $timeout(function() {
      return $scope.closeLogin();
    }, 1000);
  };
}).controller('TopnewsCtrl', [
  '$scope', 'http', function($scope, http) {
    $scope.articles = [];
    return http.topnews().success(function(response) {
      return $scope.articles = response.articles;
    });
  }
]).controller('ArticleCtrl', [
  '$scope', 'http', '$stateParams', function($scope, http, $stateParams) {
    $scope.article = {};
    return http.article($stateParams.articleId).success(function(response) {
      $scope.article = response;
      return console.log($scope.article);
    });
  }
]);
