angular.module('app').service('Chart', ($http) ->
  getData: (chartName) ->
    $http.get("/charts/#{chartName}").then( (response)->
      response.data
    )
)


