### analyst-collective/models

A collection of data models and corresponding analysis for common data sets in SQL. These models are designed to be portable across organizations with minimal configuration.

### Contributing

##### About Models
- A model is a table or view built either on top of raw data or other models. Models are not transient; they are materialized in the database.
- Currently all models are views. Support for models-as-tables is anticipated at some point.
- Model files should go into `/models` and saved with a `.sql` extension. Folder structure within `/models` is for logical grouping only.
- All models are built to be compiled and run with [dbt](https://github.com/analyst-collective/dbt). Environment configuration should be supplied via `{{env}}`
- All models will need to be adapted to your environment so as to select data from the appropriate raw data tables and fields. Once this mapping has been completed, all subsequent analysis built on top of these models will function normally.

##### About Analysis
- All analysis should be built on top of models.
- All named fields in a given analysis should be named within a given model.
- Confining analysis in this way ensures portability of analysis across multiple environments.
