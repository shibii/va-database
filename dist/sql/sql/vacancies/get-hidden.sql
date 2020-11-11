/*
  returns hidden vacancies by user id
*/
SELECT v.id,
	v.url,
	v.header,
	v.source,
	v.ts,
	true AS hidden,
	CASE WHEN p.vacancy_id IS NOT NULL THEN true ELSE false END AS pinned
FROM (
	SELECT vacancy_id AS id
	FROM PUBLIC.hides
	WHERE $<offsetClause:raw> user_id = $<userId>
	) h
LEFT JOIN (
	SELECT id,
		url,
		header,
		source,
		ts
	FROM vacancies
	) v ON h.id = v.id
LEFT JOIN (
	SELECT pins.vacancy_id
	FROM PUBLIC.pins
	WHERE user_id = $<userId>
	) p ON v.id = p.vacancy_id
ORDER BY v.id DESC $<limitClause:raw>