/*
  returns pinned vacancies by user id
*/
SELECT v.id,
	v.url,
	v.header,
	v.source,
	v.ts,
	CASE WHEN h.vacancy_id IS NOT NULL THEN true ELSE false END AS hidden,
	true as pinned
FROM (
	SELECT vacancy_id AS id
	FROM PUBLIC.pins
	WHERE $<offsetClause:raw> user_id = $<userId>
	) p
LEFT JOIN (
	SELECT id,
		url,
		header,
		source,
		ts
	FROM vacancies
	) v ON p.id = v.id
LEFT JOIN (
	SELECT hides.vacancy_id
	FROM PUBLIC.hides
	WHERE user_id = $<userId>
	) h ON v.id = h.vacancy_id
ORDER BY v.id DESC $<limitClause:raw>