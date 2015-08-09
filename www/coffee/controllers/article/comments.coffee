app.controller 'CommentsCtrl', ($scope, api, $stateParams) ->
  make_level = (comments, level = 0) ->
    return _.map comments, (comment) ->
      comment.level = level
      comment.comments = make_level(comment.comments, level + 1) if comment.comments
      return comment

  parse_comment = (comment) ->
    text = comment.text
    text = linkifyStr(text) # needs optimization
    text = text.replace(/(?:\r\n|\r|\n)/g, '<br/>');
    text = text.replace /(^.*(-|\/|\+){3,})/, '<blockquote>$1</blockquote>'
    text = text.replace /(^\/".*\/")/, '<blockquote>$1</blockquote>'
    comment.text = text
    return comment

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

  api.comments($stateParams.articleId)
  .success (response) ->
    comments = _.map response.comments, parse_comment
    comments = make_level _create_tree(comments)
    $scope.comments = comments

  .finally(() ->
    do $scope.hide_spinner
  )
