import React from "react"
import { deleteMetric } from "./ApiFunctions";

function MetricsForm(props) {

  return (
    <table className="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Value</th>
        <th colSpan={2}>Timestamp</th>
      </tr>
      </thead>
      <tbody>
      {props.metrics.map((metric) => (
        <tr>
          <td>{metric.id}</td>
          <td>{metric.name}</td>
          <td>{metric.value}</td>
          <td>{metric.timestamp}</td>
          <td><button className="btn btn-sm btn-danger" onClick={() => deleteMetric({metric_id: metric.id}, props.successCallback)}>Delete</button></td>
        </tr>
      ))}
      </tbody>
    </table>
  );
}

export default MetricsForm

