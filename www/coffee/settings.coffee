app.factory "settings", ->
#    domain: do -> if ionic.Platform.isWebView() then "http://api.novayagazeta.ru" else ""
    domain: do -> if ionic.Platform.isWebView() then "http://home.yurtaev.link:5000" else ""
    limit: 25
