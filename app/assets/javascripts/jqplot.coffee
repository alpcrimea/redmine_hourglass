#= require jqplot/jquery.jqplot
#= require jqplot/jqplot.barRenderer
#= require jqplot/jqplot.categoryAxisRenderer
#= require jqplot/jqplot.highlighter

renderToolTip = (str, seriesIndex, pointIndex, plot) ->
  point = chronos.jqplotData.highlightData[pointIndex]
  point[0] + this.tooltipSeparator + point[1]

$ ->
  if chronos.jqplotData.data.length > 0
    plot = $.jqplot 'chart-container', [chronos.jqplotData.data],
      seriesColors: (['#999'] if $('#chart-container').hasClass('js-print'))
      seriesDefaults:
        renderer: $.jqplot.BarRenderer
        rendererOptions:
          fillToZero: true
          shadow: false
          barMargin: 2
      axes:
        xaxis:
          renderer: $.jqplot.CategoryAxisRenderer
          ticks: chronos.jqplotData.ticks
        yaxis:
          autoscale: true
          min: 0
          pad: 1
          tickInterval: 1
          tickOptions: {formatString: "%d #{chronos.jqplotData.hourSign}"}
      grid:
        background: "#ffffff"
        shadow: false
      highlighter:
        tooltipContentEditor: renderToolTip
        show: true
        showMarker: false

  $(window).resize ->
    plot.replot resetAxes: true
