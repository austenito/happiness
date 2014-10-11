$ ->
  day_data = $(".happiness-per-day-chart").data('day-happiness-chart')

  $(".happiness-per-day-chart").highcharts
    chart:
      type: "column"

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
        data: [
          day_data[0] || 0,
          day_data[1] || 0,
          day_data[2] || 0,
          day_data[3] || 0,
          day_data[4] || 0,
          day_data[5] || 0,
          day_data[6] || 0
        ]
      }
    ]
