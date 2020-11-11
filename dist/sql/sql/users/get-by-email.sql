/*
  returns user by email
*/
SELECT *
  FROM public.users
 WHERE email = $<email>
 LIMIT 1