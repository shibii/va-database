/*
  returns urls not already in database

  WARNING: inserts $1 as a raw string!
  safe when parameter is generated with
  helpers.values
*/
   SELECT urls.url
     FROM (VALUES $1:raw) AS urls (url)
LEFT JOIN vacancies ON urls.url = vacancies.url
    WHERE vacancies.url IS NULL;