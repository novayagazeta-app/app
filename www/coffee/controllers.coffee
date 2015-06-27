angular.module('starter.controllers', [])

.controller('AppCtrl', ($scope, $ionicModal, $timeout) ->

# With the new view caching in Ionic, Controllers are only called
# when they are recreated or on app start, instead of every page change.
# To listen for when this page is active (for example, to refresh data),
# listen for the $ionicView.enter event:
#$scope.$on('$ionicView.enter', function(e) {
#});

# Form data for the login modal
    $scope.loginData = {}

    # Create the login modal that we will use later
    $ionicModal.fromTemplateUrl('templates/login.html',
        scope: $scope
    ).then((modal) ->
        $scope.modal = modal
    )

    # Triggered in the login modal to close it
    $scope.closeLogin = () ->
        $scope.modal.hide()

    # Open the login modal
    $scope.login = () ->
        $scope.modal.show()

    # Perform the login action when the user submits the login form
    $scope.doLogin = () ->
        console.log('Doing login', $scope.loginData)

        # Simulate a login delay. Remove this and replace with your login
        # code if using a login system
        $timeout(() ->
            $scope.closeLogin();
        , 1000);
)

.controller('TopnewsCtrl', ['$scope', 'http', ($scope, http) ->
        _limit = 10
        _offset = 0;
        $scope.articles = []

        _make_request = () ->
            http.topnews(_limit, _offset)
            .success((response) ->
                $scope.articles = $scope.articles.concat(response.articles)
                _offset = _offset + 10
            )

        do _make_request

        $scope.more_articles = () ->
            do _make_request
    ]
)

.controller('ArticleCtrl', ['$scope', 'http', '$stateParams', ($scope, http, $stateParams) ->

        $scope.article = {}
        http.article($stateParams.articleId)
        .success((response) ->
            $scope.article = response
            console.log $scope.article
        )
    ]
)
