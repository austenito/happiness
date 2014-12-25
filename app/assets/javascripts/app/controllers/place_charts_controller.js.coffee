angular.module('app').controller 'placeChartsController', ($scope, Chart) ->
  Chart.getData('place_charts').then (data) ->
    $scope.chartData = data
