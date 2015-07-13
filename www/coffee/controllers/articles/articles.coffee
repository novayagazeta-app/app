controllers
.controller('ArticlesCtrl', ['$scope', 'http', '$stateParams', 'rubrics', ($scope, http, $stateParams, rubrics) ->

        _init_parameters = () ->
            @_limit = 10
            @_offset = 0;
            $scope.articles = []
            do _detect_proper_params


        _detect_proper_params = () ->
            @_rubric_id = $stateParams.rubricId if $stateParams.rubricId
            if @_rubric_id
                $scope.current_rubric = (_.where rubrics, {rubric_id: parseInt(@_rubric_id)})[0]
                @_http_method = http.articles
                console.log $scope.current_rubric
            else
                $scope.current_rubric = rubrics[0]
                @_http_method = http.topnews


        _make_request = (options) ->
            callback = options.callback if options.callback
            limit = if options.limit then options.limit else @_limit
            offset = if options.offset then options.offset else @_offset
            rubric_id = if options.rubric_id then options.rubric_id else @_rubric_id

            @_http_method(limit, offset, rubric_id)
            .success((response) ->
                callback(response) if callback
            )
            .error(() ->
                do callback if callback
            )


        do _init_parameters


        $scope.update_articles = () ->
            complete = (response) ->
                first_ten_articles = _.first($scope.articles, 10)
                new_articles =  _.difference first_ten_articles, response
                if new_articles
                    #TODO: _.union() returns new copy
                    $scope.articles = _.union new_articles, $scope.articles
                $scope.$broadcast 'scroll.refreshComplete'

            _make_request {callback: complete, limit: 10, offset:0}


        $scope.more_articles = () ->
            complete = (response) ->
                #TODO: concat() returns new copy
                $scope.articles = $scope.articles.concat(response.articles)
                @_offset = @_offset + 10
                $scope.$broadcast 'scroll.infiniteScrollComplete'

            _make_request {callback: complete}

    ]
)
