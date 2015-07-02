controllers
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
