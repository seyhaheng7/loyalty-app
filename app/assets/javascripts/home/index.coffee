Codingate.HomeIndex =
  init: ->
    @_initChart()

  _initChart: ->
    statistic = $('#echarts_bar').data('statistic');
    myChart = echarts.init(document.getElementById('echarts_bar'));
    myChart.setOption({
      tooltip: {
        trigger: 'axis'
      },
      legend: {
        data: ['Cost', 'Expenses']
      },
      toolbox: {
        show: false
      },
      calculable: true,
      xAxis: [{
        type: 'category',
        data: statistic.months
      }],
      yAxis: [{
        type: 'value',
        splitArea: {
          show: true
        }
      }],
      series: statistic.data.map (data) ->
        data.type = 'bar'
        data

    });
