angular.module('app').service('Chart', ($http) ->
  getData: (chartName) ->
    $http.get("/#{chartName}").then( (response)->
      response.data
    )
)


