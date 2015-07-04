controllers
.controller('CommentsCtrl', ['$scope', 'http', '$stateParams', ($scope, http, $stateParams) ->



        _create = (comments) ->
            _.reduce comments, (memo, comment) ->
                unless comment.in_reply_to
                    memo.push comment
                else
                    _comment = _.find memo, (i) -> i.comment_id == comment.in_reply_to
                    _comment.comments = _create comments
                return memo
            , []


        _create_tree = (comments) ->
            sorted_array = _.sortBy(comments, (elem) ->
                        return elem.comment_id
                    )

            $scope.comments = _create sorted_array

            $scope.comments = {}


        http.comments($stateParams.articleId)
            .success (response) ->
                $scope.comments = _create_tree(response.comments)
                console.log $scope.comments
                console.log $stateParams.articleId

    ]
)
