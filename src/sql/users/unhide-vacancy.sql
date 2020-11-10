/*
  unhide vacancy
*/
DELETE FROM public.hides
	    WHERE user_id=$<userId> AND vacancy_id=$<vacancyId>;
