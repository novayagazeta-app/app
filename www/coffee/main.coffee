debug = yes # ToDo: turn on in production

requires = [
    'ionic'
    'angulartics'
]


requires.push 'angulartics.google.analytics.cordova' if ionic.Platform.isWebView()
requires.push 'angulartics.debug' if debug


app = angular.module 'app', requires


app.config ($sceProvider) -> $sceProvider.enabled no



if ionic.Platform.isWebView()
    app.config (googleAnalyticsCordovaProvider) ->
        console.log 'googleAnalyticsCordovaProvider', googleAnalyticsCordovaProvider
        googleAnalyticsCordovaProvider.trackingId = 'UA-66156255-1'
        googleAnalyticsCordovaProvider.period = 20
        googleAnalyticsCordovaProvider.debug = debug


app.run ($ionicPlatform, $analytics) ->
    $ionicPlatform.ready ->
        if window.cordova and window.cordova.plugins.Keyboard
            cordova.plugins.Keyboard.hideKeyboardAccessoryBar(yes)
        if window.StatusBar
            StatusBar.styleDefault()

        $analytics.eventTrack 'start_app',
            category: 'core'

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
