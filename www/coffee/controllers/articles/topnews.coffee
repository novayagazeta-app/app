newspaper_controllers
.controller('TopnewsCtrl', ['$scope', '$http', '$controller', 'domain_name',
    ($scope, $http, $controller, domain_name) ->

        # Inherits BaseController
        $controller "BaseArticlesCtrl", {$scope: $scope}

        $scope.title = "Topnews"

        $scope.make_request = (options) ->
            $http.get("#{domain_name}/topnews/",
                params:
                    limit: options?.limit
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

            options = {limit: $scope.limit, offset: $scope.offset}
            options = _.extend options, {success: success}
            $scope.make_request options


    ]
)