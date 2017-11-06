Codingate.LandMarksShow =
  init: ->
    @_initChart()

  _initChart: ->
    dates = []
    visitors = []
    for data in $('#echarts_bar').data('statistic')
      console.log(data)
      dates.push(data.date)
      visitors.push(data.visitors)
    myChart = echarts.init(document.getElementById('echarts_bar'));
    myChart.setOption({
      tooltip: {
        trigger: 'axis'
      },
      calculable: true,
      xAxis: [{
        type: 'category',
        data: dates
      }],
      yAxis: [{
        type: 'value',
        # splitArea: {
        #   show: true
        # }
      }],
      series: [{
        name: 'Visitor',
        type: 'line',
        data: visitors
      }]
    });


