module.exports = (config) ->
  config.set
    frameworks: ['jasmine']

    files: [
      './www/lib/angular/angular.min.js'
      'www/lib/angular-mocks/angular-mocks.js'
      'www/lib/underscore/underscore-min.js'
      'www/lib/linkifyjs/linkify.min.js'
      'www/lib/linkifyjs/linkify-string.min.js'
      'www/js/newspaper.js'
      'test/spec/**/*.coffee',
    ]

    preprocessors: {
      'www/coffee/**/*.coffee': ['coffee']
      'test/**/*.coffee': ['coffee']
    }


    coffeePreprocessor:
      options:
        bare: yes
        sourceMap: no

    reporters: ['progress']
    port: 9876
    colors: yes
    logLevel: config.LOG_INFO
    autoWatch: yes
    browsers: ['PhantomJS']
    singleRun: false
