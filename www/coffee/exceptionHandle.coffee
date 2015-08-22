
angular.module("exceptionHandle", [])

    .config( ['$provide',
        ($provide) ->

            # Installs Raven object
            DSN = "http://bf9edff504ed45e9b4ba2d1f1017d054@sentry.yurtaev.link/2"
            configs = {}
            do Raven.config(DSN, configs).install

            # Sets decorator to $exceptionHandler
            $provide.decorator('$exceptionHandler', ['$delegate',
                ($delegate) ->
                    (exception, cause) ->
                        $delegate(exception, cause)
                        Raven.captureException(exception, {extra: {cause: cause}})
        ])
    ])

    # Factory 'raven' for external call method captureException()
    .factory("raven", () ->
        return Raven
    )
