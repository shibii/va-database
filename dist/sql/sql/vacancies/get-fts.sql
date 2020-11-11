/*
  -returns all not-hidden fts matches from newest to oldest
  -adds pin and hide columns to vacancy columns
  -optional pagination uses vacancy id as offset
  -optional limit
*/
SELECT v.id,
	v.url,
	v.header,
	v.source,
	v.ts,
	false AS hidden,
	CASE WHEN p.vacancy_id IS NOT NULL THEN true ELSE false END AS pinned
FROM (
	SELECT *
	FROM vacancies
	WHERE $<offsetClause:raw> tscontents @@ to_tsquery('finnish', $<terms>)
	) v
LEFT JOIN (
	SELECT hides.vacancy_id
	FROM PUBLIC.hides
	WHERE user_id = $<userId>
	) h ON v.id = h.vacancy_id
LEFT JOIN (
	SELECT pins.vacancy_id
	FROM PUBLIC.pins
	WHERE user_id = $<userId>
	) p ON v.id = p.vacancy_id
WHERE h.vacancy_id IS NULL
ORDER BY id DESC $<limitClause:raw>