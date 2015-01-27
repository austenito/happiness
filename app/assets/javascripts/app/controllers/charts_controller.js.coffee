angular.module('app').controller 'chartsController', ($scope, Chart) ->
  Chart.getData("per-day").then (data) =>
    $scope.dayChartData = data

  Chart.getData("places").then (data) =>
    $scope.placeChartData = data

  Chart.getData("activity").then (data) =>
    $scope.activityChartData = data

  Chart.getData("daily").then (data) =>
    $scope.dailyChartData = data
