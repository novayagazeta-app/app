controllers
.controller('AppCtrl', ['$scope', 'http', ($scope, http) ->

# With the new view caching in Ionic, Controllers are only called
# when they are recreated or on app start, instead of every page change.
# To listen for when this page is active (for example, to refresh data),
# listen for the $ionicView.enter event:
#$scope.$on('$ionicView.enter', function(e) {
#});

# Form data for the login modal
        $scope.rubrics = []

        http.rubrics()
        .success((response) ->
            $scope.rubrics = response.rubrics
        )

])
