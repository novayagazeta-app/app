# Ionic Starter App
#
# angular.module is a global place for creating, registering and retrieving Angular modules
# 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
# the 2nd parameter is an array of 'requires'
# 'starter.controllers' is found in controllers.js
angular.module('starter', ['ionic', 'starter.controllers', 'starter.services'])
.run( ($ionicPlatform) ->
	$ionicPlatform.ready(() ->
# Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
# for form inputs)
		if window.cordova and window.cordova.plugins.Keyboard
			cordova.plugins.Keyboard.hideKeyboardAccessoryBar(yes)
		if window.StatusBar
            # org.apache.cordova.statusbar required
			StatusBar.styleDefault()
	)
)
.config( ($stateProvider, $urlRouterProvider) ->
	$stateProvider

	.state('app',
		url: "/app",
		abstract: true,
		templateUrl: "templates/menu.html",
		controller: 'MenuCtrl'
	)

	.state('app.topnews',
		url: "/topnews",
		views:
			'menuContent':
				templateUrl: "templates/articles.html",
				controller: 'TopnewsCtrl'
	)

	.state('app.news',
		url: "/rubric/:rubricId",
		views:
			'menuContent':
				templateUrl: "templates/articles.html",
				controller: 'ArticlesCtrl'
	)

	.state('app.article',
		url: "/article/:articleId",
		views:
			'menuContent':
				templateUrl: "templates/article.html",
				controller: 'ArticleCtrl'
	)

	.state('app.comments',
		url: "/comments/:articleId",
		views:
			'menuContent':
				templateUrl: "templates/comments.html",
				controller: 'CommentsCtrl'
	)

	# if none of the above states are matched, use this as the fallback

	$urlRouterProvider.otherwise('/app/topnews')

)