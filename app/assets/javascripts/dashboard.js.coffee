ready = ->
  jQuery ->
    if $("#canvas").length != 0
      data = {
        labels : window.chart_labels,
        datasets : [
          # {
          #   fillColor : "rgba(220,220,220,0.5)",
          #   strokeColor : "rgba(220,220,220,1)",
          #   pointColor : "rgba(220,220,220,1)",
          #   pointStrokeColor : "#fff",
          #   data : window.chart_data[1]
          # },
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
