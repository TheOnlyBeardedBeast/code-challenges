explain analyse
select * from "users" where 
normalize_names("lastName", "address", "country") 
= normalize_names('Mueller', 'Weissenseestraße 50a Apt438', 'DE')

select normalize_names('Müller', 'Weißenseestr. 50a Apt. 438', 'DE'),
	normalize_names('Mueller', 'Weissenseestraße 50a Apt438', 'DE')

select * from "users" where 
"lastName" = 'Müller' and "address" like 'Wei%50a%'


select
	normalize_names('Ümit', 'Barüstraße 1', 'DE'),
	normalize_names('Uemit', 'Baruestrasse 1', 'DE'),
	normalize_names('Umit', 'Barustr. 1', 'DE'),
	normalize_names('Ștefan cel Mare', 'Strada Soarelui 123', 'RO'),
	normalize_names('stefan cel mare', 'Str soarelui 123', 'RO'),