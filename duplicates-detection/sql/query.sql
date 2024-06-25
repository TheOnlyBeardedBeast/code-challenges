-- explain analyse
select * from "users" where 
normalize_names("lastName", "address", "country") 
= normalize_names('Mueller', 'Weissenseestraße 50a Apt438', 'DE')


-- select
-- 	normalize_names('Ümit', 'Barüstraße 1', 'DE'),
-- 	normalize_names('Uemit', 'Baruestrasse 1', 'DE'),
-- 	normalize_names('Umit', 'Barustr. 1', 'DE')