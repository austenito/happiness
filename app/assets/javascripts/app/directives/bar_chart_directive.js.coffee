angular.module('app').directive 'barChart', (Chart) ->
  scope:
    min: '@'
    max: '@'
    title: '@'
    chartData: '='

  link: (scope, element, attrs) ->
    scope.chart = new Highcharts.Chart
      chart:
        type: "column"
        renderTo: element[0]

      title:
        text: scope.title

      xAxis:
        categories: scope.categories

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
        scope.chart.series[0].setData(value.values)
        scope.chart.xAxis[0].setCategories(value.categories)
