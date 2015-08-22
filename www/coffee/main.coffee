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

app.config ($ionicConfigProvider) -> $ionicConfigProvider.backButton.text ''

app.config ($provide) ->
    $provide.decorator '$browser', ($delegate) ->
        origUrl = $delegate.url
        pendingHref = null
        pendingHrefTimer = null

        newUrl = (url, replace, state) ->
            if url
                result = origUrl(url, replace, state)

                unless window.location.href == url
                    unless pendingHref == url
                        pendingHref = url
                        clearTimeout(pendingHrefTimer) if pendingHrefTimer
                        pendingHrefTimer = setTimeout ->
                            pendingHref = null if window.location.href == pendingHref
                            pendingHrefTimer = null
                        , 0
                return result

            else
                pendingHref = null if pendingHref == window.location.href
                return pendingHref or origUrl(url, replace, state)

        $delegate.url = newUrl
        return $delegate



if ionic.Platform.isWebView()
    app.config (googleAnalyticsCordovaProvider) ->
        console.log 'googleAnalyticsCordovaProvider', googleAnalyticsCordovaProvider
        googleAnalyticsCordovaProvider.trackingId = conf.gaId
        googleAnalyticsCordovaProvider.period = 20
        googleAnalyticsCordovaProvider.debug = conf.debug


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
