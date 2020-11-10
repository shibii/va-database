/*
  hide vacancy
*/
INSERT INTO public.hides(user_id, vacancy_id)
	   VALUES ($<userId>, $<vacancyId>);