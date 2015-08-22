angular.module("exceptionHandle", [])

.config ($provide) ->
    # Installs Raven object
    configs = {}
    do Raven.config(conf.DSN, configs).install

    # Sets decorator to $exceptionHandler
    $provide.decorator '$exceptionHandler', ($delegate) ->
        (exception, cause) ->
            $delegate(exception, cause)
            Raven.captureException exception,
                extra:
                    cause: cause
                    env: conf.env

# Factory 'raven' for external call method captureException()
.factory "raven", ->
    return Raven
