angular.module('app').controller 'dayChartsController', ($scope, Chart) ->
  Chart.getData("day_charts").then (data) =>
    $scope.chartData = data

