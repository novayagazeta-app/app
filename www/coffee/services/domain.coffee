
services
.factory("domain", () ->
    if ionic.Platform.isWebView()
        url = "http://api.novayagazeta.ru"
    else
        url = ""
    return url
)
