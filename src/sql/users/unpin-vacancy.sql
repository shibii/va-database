/*
  unpin vacancy
*/
DELETE FROM public.pins
	    WHERE user_id=$<userId> AND vacancy_id=$<vacancyId>;
