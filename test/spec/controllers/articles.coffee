describe "Articles", ->
    $httpBackend = {}
    stateParams =
        rubricId: ""
    offset = 0
    limit = 25
    createController = ->

    scope =
        show_spinner: ()  ->
        hide_spinner: () ->

    beforeEach module 'templates'
    beforeEach module 'app'

    beforeEach inject ($injector, $controller) ->
        $httpBackend = $injector.get '$httpBackend'
        $httpBackend.when('GET', "/topnews/?limit=#{limit}&offset=#{offset}").respond(fixtures.articles)
        $httpBackend.when('GET', "/articles/?limit=#{limit}&offset=#{offset}&rubric_id=#{stateParams.rubricId}").respond(fixtures.articles)

        createController = () ->
            ArticlesCtrl = $controller 'ArticlesCtrl', {$scope: scope, $stateParams: stateParams}


    afterEach ->
        do $httpBackend.verifyNoOutstandingExpectation
        do $httpBackend.verifyNoOutstandingRequest


    describe "should get correct rubric: ", ->

        it 'get topnews', ->
            stateParams.rubricId = "topnews"
            do createController

            do scope.more_articles
            $httpBackend.expectGET("/topnews/?limit=#{limit}&offset=#{offset}").respond(fixtures.articles)
            expect(scope.title).toEqual("Топ новостей")
            do $httpBackend.flush


        it 'get rubric "politics"', ->
            stateParams.rubricId = 8
            do createController

            do scope.more_articles
            expect(scope.title).toEqual("Политика")
            $httpBackend.expectGET("/articles/?limit=#{limit}&offset=#{offset}&rubric_id=#{stateParams.rubricId}").respond(fixtures.articles)
            do $httpBackend.flush


    describe "should update list of articles:", ->
        first_article_id = null

        beforeEach ->
            stateParams.rubricId = "topnews"
            do createController
            do scope.more_articles
            $httpBackend.when('GET', "/topnews/?limit=25&offset=25").respond(fixtures.new_articles)
            do $httpBackend.flush
            first_article_id = scope.articles[0].article_id


        it "get more articles", ->
            expect(scope.articles.length).toEqual 25
            expect(scope.offset).toEqual 25

            do scope.more_articles

            $httpBackend.expectGET("/topnews/?limit=25&offset=25").respond(fixtures.new_articles)
            do $httpBackend.flush
            expect(scope.articles.length).toEqual 50
            expect(scope.offset).toEqual 50
            expect(scope.articles[0].article_id).toEqual(first_article_id)


        it "get new articles", ->
            expect(scope.articles.length).toEqual 25
            expect(scope.offset).toEqual 25

            $httpBackend.when('GET', "/topnews/?limit=25&offset=0").respond(fixtures.new_articles)
            do scope.update_articles
            $httpBackend.expectGET("/topnews/?limit=25&offset=0").respond(fixtures.new_articles)
            do $httpBackend.flush
            expect(scope.articles.length).toEqual 50
            expect(scope.offset).toEqual 50
            expect(scope.articles[0].article_id).not.toEqual(first_article_id)
