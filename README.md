# va-database

Typescript version of the database interface for vacancy-aggregator stack. It uses the [pg-promise](https://www.npmjs.com/package/pg-promise) package to handle the postgres database connections and run the prepared queries.

Postgres database dump (dataless) for restoration in the [database.sql](https://github.com/shibii/va-database/blob/master/database.sql) file.

Accesses the following self-explanatory environment variables to connect to the database: _DB_HOST, DB_PORT, DB_DATABASE, DB_USER, DB_PASSWORD_
