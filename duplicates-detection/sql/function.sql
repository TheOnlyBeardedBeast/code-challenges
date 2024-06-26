CREATE EXTENSION IF NOT EXISTS UNACCENT;

DO $$ BEGIN
	CREATE TYPE NGRAM_CASES_TYPE AS (
    	TARGET VARCHAR(20),
        REPLACEMENT VARCHAR(20),
        ALLOWED_COUNTRIES TEXT []
);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;
 
CREATE OR REPLACE FUNCTION public.normalize_names(nameValue text, addressName text, country text)
 RETURNS text
 LANGUAGE plpgsql
 IMMUTABLE
AS $function$
DECLARE
    -- ü = u = ue, a = ä = ae ...
    ngramCases ngram_cases_type[] = ARRAY[
        ('ue', 'ü', ARRAY['DE', 'AT', 'CH']),
        ('ae', 'ä', ARRAY['DE', 'AT', 'CH']),
        ('oe', 'ö', ARRAY['DE', 'AT', 'CH'])
    ];
    replacedValue text = lower(nameValue);
    ngramCase ngram_cases_type;
	street_string text;
BEGIN
    CASE country
      	WHEN 'DE' THEN street_string := 'strasse|str';
		WHEN 'RO' THEN street_string := 'strada|str';
		WHEN 'CZ' THEN street_string := 'ulice|ul';
		WHEN 'PL' THEN street_string := 'ulica|ul';
        WHEN 'SK' THEN street_string := 'ulica|ul';
    ELSE
        street_string := '';
    END CASE;
                
	FOREACH ngramCase IN ARRAY ngramCases
    LOOP
       IF ngramCase.allowed_countries @> array[country] THEN
            replacedValue = replace(replacedValue, ngramCase.target, ngramCase.replacement);
            addressName = replace(addressName, ngramCase.target, ngramCase.replacement);
       END IF;
    END LOOP;

    addressName := lower(REGEXP_REPLACE(unaccent(addressName), format('(%s)(?=\s|\d|\.)', street_string), '', 'gi'));

    RETURN  unaccent(REGEXP_REPLACE(replacedValue || addressName, '[\s\.\/-]+', '', 'g'));
END;
$function$;


CREATE INDEX normalized_lastName ON "users"
(normalize_names("lastName", "address", "country"));