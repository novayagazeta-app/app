describe "Example", ->
  $httpBackend = {}
  http_requests = {}
  limit = 10
  offset = 0
  rubric_id = 20
  article_id = 'news1695694'

  beforeEach module 'starter.services'

  beforeEach inject ($injector) ->
    $httpBackend = $injector.get '$httpBackend'
    $httpBackend.when('GET', "/topnews/?limit=#{limit}&offset=#{offset}").respond(fixtures.topnews)
    $httpBackend.when('GET', "/articles/?limit=#{limit}&offset=#{offset}&rubric_id=#{rubric_id}").respond(fixtures.articles)
    $httpBackend.when('GET', "/article/?article_id=#{article_id}").respond(fixtures.article)
    $httpBackend.when('GET', "/comments/?article_id=#{article_id}").respond(fixtures.comments)

  beforeEach inject (_http_requests_) ->
    http_requests = _http_requests_

  afterEach ->
    do $httpBackend.verifyNoOutstandingExpectation
    do $httpBackend.verifyNoOutstandingRequest

  it 'should get all topnews', ->
    callback = (data) ->
      expect(data.articles.length).toBe 10
      expect(data.articles_count).toBe '91953'
      expect(data.error.code).toBe 200

    http_requests.topnews
      limit: limit
      offset: offset
    .success callback

    do $httpBackend.flush

  it 'should get all articles', ->
    callback = (data) ->
      expect(data.articles.length).toBe 10
      expect(data.articles_count).toBe '91953'
      expect(data.error.code).toBe 200

    http_requests.articles
      limit: limit
      offset: offset
      rubric_id: rubric_id
    .success callback

    do $httpBackend.flush

  it 'should get article', ->
    callback = (data) ->
      expect(data.article_id).toBe article_id

    http_requests.article article_id
    .success callback

    do $httpBackend.flush

  it 'should get comments', ->
    callback = (data) ->
      expect(data.comments.length).toBe 3

    http_requests.comments article_id
    .success callback

    do $httpBackend.flush


