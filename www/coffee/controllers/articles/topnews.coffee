controllers
.controller('TopnewsCtrl', ['$scope', 'http_requests', '$stateParams', 'rubrics',
    ($scope, http_requests, $stateParams, rubrics) ->
        limit = 10
        offset = 0
        $scope.articles = []
        $scope.isArcticles = yes

        @push = (new_articles) ->
            _.each new_articles, (new_article) ->
                $scope.articles.push new_article

        @unshift = (new_articles) ->
            new_articles = _.filter(new_articles, (val, key) ->
                $scope.articles[key].article_id isnt val.article_id
            )
            if new_articles
                _.each new_articles.reverse(), (article) ->
                    $scope.articles.unshift article


        $scope.title = "Topnews"

        $scope.more_articles = () =>
            http_requests.topnews({limit: limit, offset: offset})
            .success((response) =>
                offset = offset + 10
                $scope.isArcticles = if response.articles then yes else no
                @push response.articles
            )
            .finally(->
                $scope.$broadcast('scroll.infiniteScrollComplete')
            )


        $scope.update_articles = () =>
            http_requests.topnews()
            .success((response) =>
                @unshift response.articles
            )
            .finally(->
                $scope.$broadcast('scroll.refreshComplete')
            )

    ]
)