requires = [
    'ionic'
    'ngCordova'
    'angulartics'
    'ngSwipebox'
    'exceptionHandle'
]


requires.push 'angulartics.google.analytics.cordova' if ionic.Platform.isWebView()
requires.push 'angulartics.debug' if conf.debug and conf.env isnt 'test'


app = angular.module 'app', requires


app.config ($sceProvider) -> $sceProvider.enabled no

app.config ($ionicConfigProvider) ->
    $ionicConfigProvider.backButton.text ''


if ionic.Platform.isWebView()
    app.config (googleAnalyticsCordovaProvider) ->
        console.log 'googleAnalyticsCordovaProvider', googleAnalyticsCordovaProvider
        googleAnalyticsCordovaProvider.trackingId = conf.gaId
        googleAnalyticsCordovaProvider.period = 20
        googleAnalyticsCordovaProvider.debug = conf.debug


app.run ($ionicPlatform, $analytics, $cordovaInAppBrowser) ->
    $ionicPlatform.ready ->
        if window.cordova and window.cordova.plugins.Keyboard
            cordova.plugins.Keyboard.hideKeyboardAccessoryBar(yes)
        if window.StatusBar
            StatusBar.styleDefault()

        $analytics.eventTrack 'start_app',
            category: 'core'

        $('body').on 'click', 'a[target="_blank"]', (e) ->
            $cordovaInAppBrowser.open(@href, '_system')
            return false

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
