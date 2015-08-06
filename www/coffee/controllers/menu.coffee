newspaper_controllers
.controller('MenuCtrl', ['$scope', 'rubrics', '$ionicLoading',
    ($scope, rubrics, $ionicLoading) ->

        $scope.rubrics = rubrics or []


        $scope.show_spinner = () ->
            $ionicLoading.show(
                template: '<ion-spinner icon="ios"></ion-spinner>'
        )

        $scope.hide_spinner = () ->
            do $ionicLoading.hide

])
