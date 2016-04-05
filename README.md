### analyst-collective/models

A collection of data models and corresponding analysis for common data sets in SQL. These models are designed to be portable across organizations with minimal configuration.

### Design Principles

This repository contains two primary types of objects: data models and data analyses.

##### Models
- A model is a table or view built either on top of raw data or other models. Models are not transient; they are materialized in the database.
- Models are composed of a single SQL `select` statement. Any valid SQL can be used. As such, models can provide functionality such as data cleansing, data transformation, etc.
- All models are built to be compiled and run with [dbt](https://github.com/analyst-collective/dbt).
- Models can be configured in dbt to be materialized as either views or tables.
- Model files should go into `/models` and saved with a `.sql` extension.
- Each model should be stored in its own `.sql` file. The file name will become the name of the table or view in the database.
- Environment configuration should be supplied via `{{env}}`.
- Models should be designed to minimize the selection from raw data tables. This minimizes the amount of mapping end users of models will need to do when configuring them for their local environment.

##### Analysis
- Analyses are `.sql` files that can be executed within a database query tool.
- All analysis should be built on top of models, not raw data.
- All named fields in a given analysis should be named within a given model.
- Confining analysis in this way ensures portability of analysis across multiple environments.


### Contributing
All contributions to this repository must be for analytics on top of standardized datasets. The current process for contributing is to:
- fork this repo,
- build a test dataset,
- make and test changes, and
- submit a PR.

PRs without accompanying datasets cannot be tested and therefore will not be accepted. We suggest you use [data-generator](https://github.com/analyst-collective/data-generator) to generate your test datasets.

We do not believe that this is the ideal workflow to facilitate the Analyst Collective vision for open source analytics. In the future, we plan to extend dbt to be a package manager. Once this is accomplished, you can own your own analytics repositories and publish them to a common index that others can use. We will update the contribution guidelines here once this is accomplished.
