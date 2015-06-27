angular.module('starter', ['ionic', 'starter.controllers', 'starter.services']).run(function($ionicPlatform) {
  return $ionicPlatform.ready(function() {
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      return StatusBar.styleDefault();
    }
  });
}).config(function($stateProvider, $urlRouterProvider) {
  $stateProvider.state('app', {
    url: "/app",
    abstract: true,
    templateUrl: "../templates/menu.html",
    controller: 'AppCtrl'
  }).state('app.search', {
    url: "/search",
    views: {
      'menuContent': {
        templateUrl: "../templates/search.html"
      }
    }
  }).state('app.browse', {
    url: "/browse",
    views: {
      'menuContent': {
        templateUrl: "../templates/browse.html"
      }
    }
  }).state('app.topnews', {
    url: "/topnews",
    views: {
      'menuContent': {
        templateUrl: "../templates/topnews.html",
        controller: 'TopnewsCtrl'
      }
    }
  }).state('app.article', {
    url: "/article/:articleId",
    views: {
      'menuContent': {
        templateUrl: "../templates/article.html",
        controller: 'ArticleCtrl'
      }
    }
  });
  return $urlRouterProvider.otherwise('/app/topnews');
});
