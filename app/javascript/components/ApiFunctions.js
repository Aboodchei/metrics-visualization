export const fetchMetrics = (successCallback) => {
  const url = "api/v1/metrics";
  fetch(url)
    .then((data) => {
      if (data.ok) {
        return data.json();
      }
      throw new Error("Network error.");
    })
    .then((data) => {
      successCallback(data)
    })
    .catch((err) => alert("Loading Error: " + err));
};

export const createMetric = ({metric_name, metric_value, timestamp}, successCallback) => {
  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ metric_name, metric_value, timestamp })
  };
  const url = "api/v1/metrics"
  fetch(url, requestOptions)
  .then((data) => {
    if (!data.ok) {
      throw new Error("Network error.");
    }
  })
  .then(() => {
    fetchMetrics(successCallback);
  })
  .catch((err) => alert("Creation Error: " + err));
}

export const deleteMetric = ({metric_id}, successCallback) => {
  const requestOptions = { method: 'DELETE' };
  const url = `api/v1/metrics/${metric_id}`
  fetch(url, requestOptions)
  .then((data) => {
    if (!data.ok) {
      throw new Error("Network error.");
    }
  })
  .then(() => {
    fetchMetrics(successCallback);
  })
  .catch((err) => alert("Deletion Error: " + err));
}
