select normalize('Å', NFD), normalize('A', NFD), normalize('Å', NFD) = normalize('A', NFD)

-- https://www.compart.com/en/unicode/category/Mn
SELECT REGEXP_REPLACE(NORMALIZE('Å', NFD), '[\u0300-\u036f]', '', 'g')
       = REGEXP_REPLACE(NORMALIZE('A', NFD), '[\u0300-\u036f]', '', 'g');
	   