newspaper_controllers
.controller('ArticlesCtrl', ['$scope', '$http', '$stateParams', 'rubrics', '$controller', 'domain_name',
    ($scope, $http, $stateParams, rubrics, $controller, domain_name) ->

        # Inherits BaseController
        $controller "BaseArticlesCtrl", {$scope: $scope}

        rubric_id = parseInt($stateParams.rubricId)

        $scope.title = _.findWhere(rubrics, {rubric_id: rubric_id}).title


        $scope.make_request = (options) ->
            $http.get("#{domain_name}/articles/",
                params:
                    limit: options?.limit
                    rubric_id: options?.rubric_id
                    offset: options?.offset
            )
            .success((response) ->
                options.success(response) if options.success
            )
            .finally(->
                $scope.$broadcast('scroll.infiniteScrollComplete')
            )


        $scope.more_articles = () ->
            success = (response) ->
                $scope.push response.articles

            options = {limit: $scope.limit, offset: $scope.offset, rubric_id: rubric_id}
            options = _.extend options, {success: success}
            $scope.make_request options


    ]
)
