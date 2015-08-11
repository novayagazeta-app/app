describe "Articles", ->
    $httpBackend = {}
    rubric_id = ""
    offset = 0
    limit = 25

    scope =
        show_spinner: ()  ->
        hide_spinner: () ->

    beforeEach module 'templates'
    beforeEach module 'app'

    beforeEach inject ($injector, $controller) ->
        $httpBackend = $injector.get '$httpBackend'
        $httpBackend.when('GET', "/articles/?limit=#{limit}&offset=#{offset}&rubric_id=#{rubric_id}").respond(fixtures.articles)
        $httpBackend.when('GET', "/topnews/?limit=#{limit}&offset=#{offset}").respond(fixtures.articles)

        createController = () ->
            ArticlesCtrl = $controller 'ArticlesCtrl', {$scope: scope}
        do createController


    afterEach ->
        do $httpBackend.verifyNoOutstandingExpectation
        do $httpBackend.verifyNoOutstandingRequest


    describe "should get correct rubric", ->

        it 'should get topnews', ->
            rubric_id = "topnews"
            do scope.more_articles
            $httpBackend.expectGET("/topnews/?limit=#{limit}&offset=#{offset}")
            expect(scope.title).toEqual("Топ новостей")
            do $httpBackend.flush

        it 'should get rubric: politics', ->
            rubric_id = 8
            do scope.more_articles
            $httpBackend.expectGET("/articles/?limit=#{limit}&offset=#{offset}&rubric_id=#{rubric_id}")
            expect(scope.title).toEqual("Политика")
            do $httpBackend.flush


