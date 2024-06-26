-- CREATE COLLATION german (provider = icu, locale = 'de');
SELECT 'ü' = 'u' COLLATE german; -- false

CREATE COLLATION ignore_accent_case (provider = icu, deterministic = false, locale = 'de_DE-u-ks-level1');

SELECT 'Å' = 'A' COLLATE ignore_accent_case_2; -- true
SELECT 'z' = 'Z' COLLATE ignore_accent_case; -- true
SELECT 'ü' = 'ue' COLLATE ignore_accent_case; -- true