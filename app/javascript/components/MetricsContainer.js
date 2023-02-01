import React from "react"
import { fetchMetrics } from "./ApiFunctions";
import MetricForm from "./MetricForm";
import MetricsTable from "./MetricsTable"
import MetricsGraph from "./MetricsGraph"
import MetricsAggregatesData from "./MetricsAggregatesData"

function MetricsContainer() {
  const [metrics, setMetrics] = React.useState([]);
  const [metricsAggregates, setMetricsAggregates] = React.useState([]);

  React.useEffect(() => {
    fetchMetrics(successCallback);
  }, []);

  const successCallback = (data) => {
    setMetrics(data["metrics"])
    setMetricsAggregates(data["metrics_aggregates"])
  }

  return (
    <div className="container">
      <div>
        <h1>Visualization</h1>
        <MetricsGraph metrics={metrics}/>
      </div>
      <div className="px-4 py-5 my-2">
        <h1>Form</h1>
        <MetricForm successCallback={successCallback} />
      </div>
      <div className="px-4 py-5 my-2">
        <h1>Aggregate Data</h1>
        <MetricsAggregatesData metricsAggregates={metricsAggregates}/>
      </div>
      <div className="px-4 py-5 my-2">
        <h1>Metrics</h1>
        <MetricsTable metrics={metrics} successCallback={successCallback} />
      </div>
    </div>
  );
}

export default MetricsContainer
