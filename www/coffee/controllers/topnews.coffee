controllers
.controller('TopnewsCtrl', ['$scope', 'http', ($scope, http) ->

        _init_parameters = () ->
            @_limit = 10
            @_offset = 0;
            $scope.articles = []

        _make_request = (callback) ->
            http.topnews(@_limit, @_offset)
            .success((response) ->
                $scope.articles = $scope.articles.concat(response.articles)
                @_offset = @_offset + 10

                do callback if callback
            )
            .error(() ->
                do callback if callback
            )

        do _init_parameters
        do _make_request

        $scope.update_articles = () ->
            do _init_parameters
            complete = () ->
                $scope.$broadcast('scroll.refreshComplete')

            _make_request complete


        $scope.more_articles = () ->
            complete = () ->
                $scope.$broadcast 'scroll.infiniteScrollComplete'

            _make_request complete

    ]
)
