app.factory "settings", ->
  domain: do -> if ionic.Platform.isWebView() then "http://api.novayagazeta.ru" else ""
  limit: 25
