-- CREATE TABLE ItemCategories(id INTEGER PRIMARY KEY, title TEXT);
-- CREATE TABLE Items(id INTEGER PRIMARY KEY, category TEXT, imageURL TEXT, isInWash INTEGER, timeOfWash INTEGER);
-- CREATE TABLE OutfitCategories(id INTEGER PRIMARY KEY, title TEXT);
-- CREATE TABLE Outfits(id INTEGER PRIMARY KEY, category TEXT);  
-- CREATE TABLE OutfitItems(outfit_id INTEGER, item_id INTEGER, FOREIGN KEY(outfit_id) REFERENCES Outfits(id) ON DELETE CASCADE, FOREIGN KEY(item_id) REFERENCES Items(id) ON DELETE CASCADE);
-- CREATE TABLE Events(event_id INTEGER PRIMARY KEY, date TEXT, outfit_id INTEGER);

INSERT INTO ItemCategories('title') VALUES ('Pants');
INSERT INTO ItemCategories('title') VALUES ('Jackets');

SELECT * FROM ItemCategories;