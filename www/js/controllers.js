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
    var _limit, _make_request, _offset;
    _limit = 10;
    _offset = 0;
    $scope.articles = [];
    _make_request = function() {
      return http.topnews(_limit, _offset).success(function(response) {
        $scope.articles = $scope.articles.concat(response.articles);
        return _offset = _offset + 10;
      });
    };
    _make_request();
    return $scope.more_articles = function() {
      return _make_request();
    };
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
