CREATE COLLATION ignore_accent_case (provider = icu, deterministic = false, locale = 'de_DE-u-ks-level1');

SELECT 'Å' = 'A' COLLATE ignore_accent_case; -- true
SELECT 'z' = 'Z' COLLATE ignore_accent_case; -- true
SELECT 'ü' = 'ue' COLLATE ignore_accent_case; -- false