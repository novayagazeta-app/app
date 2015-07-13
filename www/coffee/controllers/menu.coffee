controllers
.controller('MenuCtrl', ['$scope', 'rubrics', ($scope, rubrics) ->

        $scope.rubrics = rubrics or []

])
