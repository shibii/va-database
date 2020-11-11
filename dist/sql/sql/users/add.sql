/*
  insert new user
*/
INSERT INTO public.users(email, pwhash)
     VALUES($<email>, $<pwhash>)
  RETURNING *