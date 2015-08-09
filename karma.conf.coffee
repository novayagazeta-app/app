module.exports = (config) ->
  config.set
    frameworks: ['jasmine']

    files: [
      'www/lib/ionic/js/ionic.bundle.js'
      'www/lib/angular-mocks/angular-mocks.js'
      'www/lib/underscore/underscore-min.js'
      'www/lib/linkifyjs/linkify.min.js'
      'www/lib/linkifyjs/linkify-string.min.js'
      'www/templates/**/*.html'
      'www/js/newspaper.js'
      'test/main.coffee'
      'test/fixtures/**/*.coffee'
      'test/spec/**/*.coffee'
    ]

    preprocessors:
      'www/coffee/**/*.coffee': ['coffee']
      'test/**/*.coffee': ['coffee']
      'www/templates/**/*.html': ['ng-html2js']

    coffeePreprocessor:
      options:
        bare: yes
        sourceMap: no

    ngHtml2JsPreprocessor:
      stripPrefix: 'www/'
      moduleName: 'templates'

    reporters: ['progress']
    port: 9876
    colors: yes
    logLevel: config.LOG_INFO
    autoWatch: yes
    browsers: ['PhantomJS']
    singleRun: false
