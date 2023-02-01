import Chart from 'chart.js/auto';
import 'chartjs-adapter-date-fns';
import React from "react"

function MetricsGraph(props) {

  React.useEffect(() => {
    drawChart();
  }, [props.metrics]);

  const drawChart = () => {
    if( props.metrics.length === 0 ){
      return
    }

    if(window.chart != undefined){
      window.chart.destroy();
    }

    const grouped = props.metrics.reduce((group, metric) => {
      const { name } = metric;
      group[name] = group[name] ?? [];
      group[name].push(metric);
      return group;
    }, {});

    const datasets = Object.entries(grouped).map((grouped_data) => {
      return {
        label: grouped_data[0],
        data: grouped_data[1].map((metric) => {
          return {x: metric.timestamp, y: metric.value}
        }),
      }
    })

    const data = {
      labels: [],
      datasets: datasets
    }

    const config = {
      type: 'scatter',
      data,
      options: {
        scales: {
          x: {
            type: 'time',
          },
        },
        interaction: {
          y: true
        },
      }
    }

    window.chart = new Chart(document.getElementById('myChart'), config);
  }

  return (
    <canvas id="myChart"></canvas>
  )
}

export default MetricsGraph
