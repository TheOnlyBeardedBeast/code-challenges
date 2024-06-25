create extension if not exists fuzzystrmatch;

SELECT levenshtein('ümit', 'umit') as lev_ümit_umit, levenshtein('ümit', 'uemit') as lev_ümit_uemit,
	levenshtein('Dani', 'Dana') as lev_Dani_Dana, levenshtein('dani', 'Dana') as lev_dani_Dana
	


select soundex('ümit'), soundex('umit'), soundex('uemit') 
select soundex('Dani'), soundex('Dana')

-- only postgres 16
select daitch_mokotoff('ümit'), daitch_mokotoff('umit'), daitch_mokotoff('uemit') 
select daitch_mokotoff('Dani'), daitch_mokotoff('Dana')


select metaphone('ümit', 4), metaphone('umit', 4), metaphone('uemit', 4) 

-- only postgres 16
select dmetaphone('ümit') || ',' || dmetaphone_alt('ümit'),
	   dmetaphone('umit') || ',' || dmetaphone_alt('umit'),
	   dmetaphone('uemit') || ',' || dmetaphone_alt('uemit')