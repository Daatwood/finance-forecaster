ready = ->
  jQuery ->
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
          fillColor : "rgba(151,187,205,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : window.chart_data
        }
      ]
    }
    if $("#canvas").length != 0
        myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data)

$(document).ready ready
$(document).on 'page:load', ready
