controllers
.controller('AppCtrl', ['$scope', 'rubrics', ($scope, rubrics) ->

        $scope.rubrics = rubrics or []

])
