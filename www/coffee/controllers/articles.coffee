controllers
.controller('ArticlesCtrl', ['$scope', 'http', '$stateParams', ($scope, http, $stateParams) ->

        _init_parameters = () ->
            @_rubric_id = $stateParams.rubricId if $stateParams.rubricId
            @_limit = 10
            @_offset = 0;
            $scope.articles = []
            $scope.currebnt_rubric = (_.where $scope.rubrics, {rubric_id: parseInt(this._rubric_id)})[0]


        _make_request = (callback) ->
            http.articles(@_rubric_id, @_limit, @_offset)
            .success((response) ->
                $scope.articles = $scope.articles.concat(response.articles)
                @_offset = @_offset + 10

                do callback if callback
            )
            .error(() ->
                do callback if callback
            )

        do _init_parameters

        $scope.update_articles = () ->
            do _init_parameters
            complete = () ->
                $scope.$broadcast 'scroll.refreshComplete'

            _make_request complete


        $scope.more_articles = () ->
            complete = () ->
                $scope.$broadcast 'scroll.infiniteScrollComplete'

            _make_request complete

    ]
)
