newspaper_controllers
.controller('BaseArticlesCtrl', ['$scope', ($scope) ->

        $scope.limit = 10
        $scope.offset = 0
        $scope.articles = []
        $scope.isArcticles = yes


        $scope.push = (new_articles) ->
            # Checks there is more articles
            stop_infinite_scroll new_articles

            # Updates $scope.offset
            $scope.offset = $scope.offset + 10

            # Push new_articles
            _.each new_articles, (new_article) ->
                $scope.articles.push new_article


        $scope.unshift = (new_articles) ->
            new_articles = _.filter(new_articles, (val, key) ->
                $scope.articles[key].article_id isnt val.article_id
            )
            if new_articles
                _.each new_articles.reverse(), (article) ->
                    $scope.articles.unshift article


        stop_infinite_scroll = (articles) ->
            if articles.length < $scope.limit
                $scope.isArcticles = no

    ]
)