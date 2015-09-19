module.exports = (config) ->
  config.set
    frameworks: ['jasmine']

    files: [
      'www/lib/angular/angular.min.js'
      'www/lib/ionic/js/ionic.bundle.min.js'
      'www/lib/ngCordova/dist/ng-cordova.min.js'
      'www/lib/angulartics/dist/angulartics.min.js'
      'www/lib/angulartics/dist/angulartics-debug.min.js'
      'www/lib/angulartics/dist/angulartics-ga-cordova-google-analytics-plugin.min.js'
      'www/lib/angular-mocks/angular-mocks.js'
      'www/lib/underscore/underscore-min.js'
      'www/lib/linkifyjs/linkify.min.js'
      'www/lib/linkifyjs/linkify-string.min.js'
      'www/lib/jquery/dist/jquery.min.js'
      'www/lib/swipebox/src/js/jquery.swipebox.min.js'
      'www/lib/angular-swipebox/dist/angular-swipebox.min.js'
      'www/templates/**/*.html'
      'www/js/conf.js'
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
