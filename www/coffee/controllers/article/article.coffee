newspaper_controllers
.controller('ArticleCtrl', ['$scope', 'http_requests', '$stateParams', '$ionicSlideBoxDelegate',

    ($scope, http, $stateParams, $ionicSlideBoxDelegate) ->

        do $scope.show_spinner

        $scope.article = {}


        http.article($stateParams.articleId)
        .success((response) ->
            $scope.article = response
        )
        .finally(() ->
            do $scope.hide_spinner
        )

        $scope.nextSlide = () ->
            do $ionicSlideBoxDelegate.next

    ]
)
