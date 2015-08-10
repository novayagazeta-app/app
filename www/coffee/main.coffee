app = angular.module('app', ['ionic'])

app.run ($ionicPlatform) ->
  $ionicPlatform.ready ->
    if window.cordova and window.cordova.plugins.Keyboard
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(yes)
    if window.StatusBar
      StatusBar.styleDefault()


app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'app',
    url: "/app"
    abstract: true
    templateUrl: "templates/menu.html"
    controller: 'MenuCtrl'

  $stateProvider.state 'app.news',
    url: "/rubric/:rubricId"
    views:
      menuContent:
        templateUrl: "templates/articles.html"
        controller: 'ArticlesCtrl'

  $stateProvider.state 'app.article',
    url: "/article/:articleId"
    views:
      menuContent:
        templateUrl: "templates/article.html"
        controller: 'ArticleCtrl'

  $stateProvider.state 'app.comments',
    url: "/comments/:articleId"
    views:
      menuContent:
        templateUrl: "templates/comments.html"
        controller: 'CommentsCtrl'

  $urlRouterProvider.otherwise '/app/rubric/topnews'
