controllers
.controller('CommentsCtrl', ['$scope', 'http', '$stateParams', ($scope, http, $stateParams) ->

        _create_child_tree = (elem, comments) ->
            childs = _.where comments, {in_reply_to: elem.comment_id}
            if childs.length
                elem["comments"] = []
                _.each childs, (child) ->
                    elem["comments"].push _create_child_tree child, comments
            return elem


        _create_tree = (comments) ->
            sorted_comments = _.sortBy(comments, (elem) ->
                return elem.comment_id
            )

            result = []
            _.each sorted_comments, (val) ->
                node = val
                unless val.in_reply_to
                    node = _create_child_tree node, comments
                    result.push node
            return result

        do $scope.show_spinner

        http.comments($stateParams.articleId)
            .success (response) ->
                $scope.comments = _create_tree(response.comments)
            .finally(() ->
                do $scope.hide_spinner
            )
    ]
)
