describe "Article", ->
    $httpBackend = {}
    stateParams =
        articleId: "news1695764"

    scope =
        show_spinner: ()  ->
        hide_spinner: () ->

    beforeEach module 'templates'
    beforeEach module 'app'

    beforeEach inject ($injector, $controller) ->
        $httpBackend = $injector.get '$httpBackend'
        $httpBackend.when('GET', "/article/?article_id=#{stateParams.articleId}").respond(fixtures.article)

        createController = () ->
            ArticleCtrl = $controller 'ArticleCtrl', {$scope: scope, $stateParams: stateParams}
        do createController


    afterEach ->
        do $httpBackend.verifyNoOutstandingExpectation
        do $httpBackend.verifyNoOutstandingRequest


    it 'should update scope', ->
        $httpBackend.expectGET("/article/?article_id=#{stateParams.articleId}")
        do $httpBackend.flush

        expect(scope.article).toBeDefined()
        expect(scope.article.title).toBeDefined()
        expect(scope.article.article_body).toBeDefined()

