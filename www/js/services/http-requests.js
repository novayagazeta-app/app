services.factory("http", [
  "$http", "domain", function($http, domain) {
    return {
      topnews: function() {
        return $http.get(domain + "/topnews/");
      },
      article: function(id) {
        return $http.get(domain + "/article/", {
          params: {
            "article_id": id
          }
        });
      }
    };
  }
]);
