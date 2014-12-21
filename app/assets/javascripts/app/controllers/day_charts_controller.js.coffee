angular.module('app').controller('dayChartsController', ($scope, Chart) ->
  $scope.populateChart = (chart) ->
    Chart.getData('day_charts').then( (data) ->
      chart.series[0].setData(data)
    )

  $scope.buildChart = (populateChart) ->
    $(".happiness-per-day-chart").highcharts
      chart:
        type: "column"
        events:
          load: -> populateChart(this)

      title:
        text: "How do you feel each day?"

      xAxis:
        categories: [
          "Sunday",
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday"
        ]

      yAxis:
        min: 0
        max: 10
        title:
          text: "How do you feel?"

      tooltip:
        headerFormat: "<span style=\"font-size:10px\">{point.key}</span><table>"
        pointFormat: "<tr><td style=\"color:{series.color};padding:0\">{series.name}: &nbsp;</td>" + "<td style=\"padding:0\"><b>{point.y:.1f}</b></td></tr>"
        footerFormat: "</table>"
        shared: true
        useHTML: true

      plotOptions:
        column:
          pointPadding: 0.2
          borderWidth: 0

      series: [
        {
          name: "How do you feel from 0 - 10"
          data: []
        }
      ]

  $scope.buildChart($scope.populateChart)
)

