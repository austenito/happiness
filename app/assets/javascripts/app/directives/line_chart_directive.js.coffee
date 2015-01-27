angular.module('app').directive 'zoomLineChart', (Chart) ->
  scope:
    min: '@'
    max: '@'
    title: '@'
    chartData: '='

  link: (scope, element, attrs) ->
    scope.chart = new Highcharts.StockChart
      chart:
        zoomType: 'x'
        type: 'areaspline'
        renderTo: element[0]

      title:
        text: scope.title

      xAxis:
        type: 'datetime'
        dateTimeLabelFormats:
          day: '%b %e'
          week: '%b %e'

      yAxis:
        min: scope.min
        max: scope.max
        title:
          text: scope.title

      series: [
        name: scope.title
      ]

      rangeSelector:
        allButtonsEnabled: true

    scope.$watch 'chartData', (value) =>
      if value
        data = []
        _.each(value.values, (pair) ->
          data.push([Date.parse(pair[0]), pair[1], pair[1]])
        )

        scope.chart.series[0].setData(data)
        scope.chart.rangeSelector.clickButton(0, {},true)
