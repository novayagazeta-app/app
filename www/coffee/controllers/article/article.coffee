app.controller 'ArticleCtrl', ($scope, $stateParams, $ionicSlideBoxDelegate,
    $cordovaSocialSharing, $analytics, api) ->

    do $scope.show_spinner

    $scope.share = ->
        $analytics.eventTrack 'share',
            category: 'UI'
        
        $cordovaSocialSharing.share($scope.article.title,
            null, $scope.article.image_url, $scope.article.source_url)

    $scope.article = {}

    api.article($stateParams.articleId)
    .success (data) -> $scope.article = data
    .finally -> do $scope.hide_spinner

    $scope.nextSlide = -> do $ionicSlideBoxDelegate.next
