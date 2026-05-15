SELECT current_database();

SELECT current_user();

SELECT schema_name
FROM information_schema.schemata
ORDER BY schema_name;

SELECT table_schema,
       table_name
FROM information_schema.tables
ORDER BY table_schema,
         table_name;