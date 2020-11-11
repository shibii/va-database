/*
  pin vacancy
*/
INSERT INTO public.pins(user_id, vacancy_id)
	   VALUES ($<userId>, $<vacancyId>);