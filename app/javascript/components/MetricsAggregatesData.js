import React from "react"

function MetricsAggregatesData(props) {

  const formatted_date = (timestamp, timespan) => {
    if(timespan == "day"){
      return timestamp.slice(0,10)
    }else if(timespan == "hour"){
      return timestamp.slice(0,13)
    }else{
      return timestamp
    }
  }

  return (
    <div>
      {
        props.metricsAggregates.map((m_a, index) => {
          return <div key={index}>
            {
            (m_a.metric_name == null) ?
              <b>
                Aggregate {m_a.aggregate_type} per {m_a.timespan} on {formatted_date(m_a.timestamp, m_a.timespan)} -{">"} {m_a.value.toFixed(4)}
              </b>
            :
              <small style={{paddingLeft: 15}}>
                [{m_a.metric_name}] {m_a.aggregate_type} -{">"} {m_a.value.toFixed(4)}
              </small>
            }
          </div>

        })
      }
    </div>
  )
}

export default MetricsAggregatesData
