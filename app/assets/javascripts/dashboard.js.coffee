ready = ->
  jQuery ->
    if $("#canvas").length != 0
      data = {
        labels : window.chart_labels,
        datasets : [
          {
            fillColor : window.chart_colors[0],
            strokeColor : window.chart_colors[1],
            pointColor : window.chart_colors[2],
            pointStrokeColor : "#fff",
            data : window.chart_data
          }
        ]
      }
      myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data)

$(document).ready ready
$(document).on 'page:load', ready
