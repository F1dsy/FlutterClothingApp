rm app_en.db
rm app_de.db
rm app_da.db

touch app_en.db
touch app_de.db
touch app_da.db

sqlite3 app_en.db < schema.sql;
sqlite3 app_en.db < data_en.sql;

sqlite3 app_de.db < schema.sql;
sqlite3 app_de.db < data_de.sql;

sqlite3 app_da.db < schema.sql;
sqlite3 app_da.db < data_da.sql;
