create extension if not exists unaccent;

select unaccent('ümit') = unaccent('umit')

select unaccent('ümit') = unaccent('uemit')