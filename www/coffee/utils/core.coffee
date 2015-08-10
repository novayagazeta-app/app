app.factory 'utils', ->
    prepare_comments = (comments, level = 0) ->
        return _.map comments, (comment) ->
            comment.level = level
            comment.comments = prepare_comments(comment.comments, level + 1) if comment.comments
            return comment

    parse_comment = (comment) ->
        text = comment.text
        text = linkifyStr(text) # needs optimization
        text = text.replace(/(?:\r\n|\r|\n)/g, '<br/>')
        text = text.replace /(^.*(-|\/|\+){3,})/, '<blockquote>$1</blockquote>'
        text = text.replace /(^\/".*\/")/, '<blockquote>$1</blockquote>'
        comment.text = text
        return comment

    comments_parser = (comments) ->
        callback = (comments, comments_tree) ->
            unless comments
                return comments_tree

            comment = comments.shift()

            unless comment
                return comments_tree

            unless comment.in_reply_to
                comments_tree.unshift comment
            else
                _.map _.where(comments, {comment_id: comment.in_reply_to}), (i) ->
                    i.comments.unshift comment

            return callback(comments, comments_tree)

        comments = _.sortBy comments, (i) -> i.comment_id
        comments = _.map comments, (i) ->
            i.comments = []
            return i
        comments = _.map comments, parse_comment
        comments = callback(comments.reverse(), [])
        comments = prepare_comments comments
        return comments

    return {
        comments_parser: comments_parser
    }