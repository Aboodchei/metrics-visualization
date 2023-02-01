# Metrics Visualization 📊 Rails & React
This was a fun project, I enjoyed it! It took me ~3 days to complete.

This project is available live on Heroku! [Check it out here!](https://rocky-scrubland-41800.herokuapp.com/)

## What's the idea here? 💡
The main idea behind the backend design is to persist and cache aggregate data calculations, in order to improve performance once there is a huge volume of metric data per second.
- `MetricsAggregate` data is calculated and persisted once a `Metric` is created/destroyed.
- When a `Metric` is created, a maximum of 6 new `MetricsAggregates` are created. 3 of them are scoped to the Metric name, and 3 are not. Each 3 correspond to `minute`, `hour`, and `day`.
- Although it could seem counter-intuitive to create/update up to 6 `MetricAggregates` whenever a new `Metric` is added/removed, This idea drastically improves performance, especially when there is a huge number of `Metrics`.

The calculations are as follows:
```
Given that
- A is the number of aggregate functions being cached (in this case it is 1, since it is only the average)
- N being the number of different metric names being tracked

Maximum MetricAggregates per minute = A * (N + 1) * 60
Maximum MetricAggregates per hour = A * (N + 1) * 1440 (24*60)
Maximum MetricAggregates per day = A * (N + 1) * 1441 (24*60 + 1)
```

This means that, even if there are millions/billions of metric records in a given day, the number of metric aggregate statistics will always be capped to `A * (N + 1) * 1441`, which will vastly improve performance, instead of performing aggregate query functions on the fly upon user request.


I wanted to treat this project as I do my startup work. Get an MVP that works, and that meets requirements as quickly as possible, with as little technical debt as possible.

##### Setup
There should be nothing out of the ordinary.
- `$ bundle install` to install Ruby dependencies
- `$ nvm use && nvm install` to install Javascript and Frontend dependencies
- `$ rails db:setup` to setup database (Postgresql)
- `$ rails s` to run the server
- `$ rspec` to run the back-end tests (100% code coverage!)

##### React Components
There are 5 React components. I opted for functional components, and tried to kept the use of states to a minimum.
```
├── MetricsContainer
│   ├── MetricsGraph
│   ├── MetricForm
│   ├── MetricsAggregatesData
│   ├── MetricsTable
```

#### Areas of improvement
- Time zones were painful to deal with, I believe there was definitely be a cleaner way to deal with them.
- `MetricsAggregation`s should be removed once all metrics in corresponding timespan have been removed.
- Use pagination for `api/v1/metrics` instead of returning all of the data.
- Enable users to query metrics at a specific date range
- Display messages upon user interactions (creating or deleting)
- Better code formatting (rubocop/prettier)

#### Hope you like it!
