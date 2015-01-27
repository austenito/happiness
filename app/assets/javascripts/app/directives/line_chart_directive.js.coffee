angular.module('app').directive 'zoomLineChart', (Chart) ->
  scope:
    min: '@'
    max: '@'
    title: '@'
    chartData: '='

  link: (scope, element, attrs) ->
    scope.chart = new Highcharts.Chart
      chart:
        zoomType: 'x'
        type: 'spline'
        renderTo: element[0]

      title:
        text: scope.title

      xAxis:
        type: 'datetime'

      yAxis:
        min: scope.min
        max: scope.max
        title:
          text: scope.title

      series: [
        name: scope.title
      ]

    scope.$watch 'chartData', (value) =>
      if value
        data = []
        _.each(value.values, (pair) ->
          data.push([pair[0], pair[1]])
        )

        scope.chart.series[0].setData(data)
        scope.chart.xAxis[0].setCategories(value.categories)
