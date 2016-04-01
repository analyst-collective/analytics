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
- Models in a given domain should be designed to minimize the selection from raw data tables. The prim

##### Analysis
- Analyses are `.sql` files that can be executed within a database query tool.
- All analysis should be built on top of models.
- All named fields in a given analysis should be named within a given model.
- Confining analysis in this way ensures portability of analysis across multiple environments.


### Contributing
