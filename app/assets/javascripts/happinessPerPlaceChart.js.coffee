$ ->
  place_data = $(".happiness-per-place-chart").data('place-happiness-chart')
  places = _.keys(place_data)
  data = _.values(place_data)

  $(".happiness-per-place-chart").highcharts
    chart:
      type: "column"

    title:
      text: "Where do you feel the best?"

    xAxis:
      categories: places

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
        data: data
      }
    ]
