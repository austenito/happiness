angular.module('app').controller 'chartsController', ($scope, Chart) ->
  Chart.getData("day_charts").then (data) =>
    $scope.dayChartData = data

  Chart.getData("place_charts").then (data) =>
    $scope.placeChartData = data

  Chart.getData("activity_charts").then (data) =>
    $scope.activityChartData = data
