
services
.factory("domain", () ->
    name = "localhost:5000"
    protocol = "http"
    return "#{protocol}://#{name}"
)
