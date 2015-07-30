###
    constant domain_name
###

newspaper_services
.factory("domain_name", () ->
    if ionic.Platform.isWebView()
        return  "http://api.novayagazeta.ru"
    else
        return ""
)
