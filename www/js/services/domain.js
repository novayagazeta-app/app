services.factory("domain", function() {
  var name, protocol;
  name = "localhost:5000";
  protocol = "http";
  return protocol + "://" + name;
});
