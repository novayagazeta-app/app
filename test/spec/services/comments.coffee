describe "Comments", ->
  utils = {}

  beforeEach module 'templates'
  beforeEach module 'app'

  beforeEach inject (_utils_) ->
    utils = _utils_

  it 'parser', ->
    expect(fixtures.comments_tree_raw.comments.length).toBe 61

    comments = utils.comments_parser fixtures.comments_tree_raw.comments

    expect(comments.length).toBe 33
    expect(comments).toEqual fixtures.comments_tree

