services.factory("http", [
  "$http", "domain", function($http, domain) {
    return {
      topnews: function(limit, offset) {
        return $http.get(domain + "/topnews/", {
          params: {
            limit: limit,
            offset: offset
          }
        });
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
