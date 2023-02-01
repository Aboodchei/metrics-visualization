import React from "react"
import { createMetric } from "./ApiFunctions";
function MetricForm(props) {
  const [metricName, setMetricName] = React.useState("");
  const [metricValue, setMetricValue] = React.useState(0.0);
  const [timestamp, setTimestamp] = React.useState("");

  const submitForm = (event) => {
    createMetric({
      metric_name: metricName,
      metric_value: metricValue,
      timestamp: timestamp,
    }, props.successCallback);
    setMetricName("")
    setMetricValue(0)
    setTimestamp("")
    event.preventDefault();
  }

  return (
    <form onSubmit={submitForm}>
      <div className="form-row">
        <div className="form-group col-md-6">
          <label>
            Name:
          </label>
          <input id="metric_name" className="form-control form-control-sm" required type="text" value={metricName} onChange={(event) => {setMetricName(event.target.value)}} />
        </div>
        <div className="form-group col-md-6">
          <label>
            Value:
          </label>
          <input id="metric_value" className="form-control form-control-sm" required type="number" step="0.01" min="-100" max="100" value={metricValue} onChange={(event) => {setMetricValue(event.target.value)}} />
        </div>
        <div className="form-group col-md-6">
          <label>
            Timestamp:
          </label>
          <input id="metric_timestamp" className="form-control form-control-sm" required type="datetime-local" step="1" value={timestamp} onChange={(event) => {setTimestamp(event.target.value)}} />
        </div>
        <input type="submit" value="Submit" className="btn btn-primary"/>
      </div>
    </form>
  );
}

export default MetricForm
