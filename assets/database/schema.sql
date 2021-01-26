CREATE TABLE ItemCategories(id INTEGER PRIMARY KEY, title TEXT);
CREATE TABLE Items(id INTEGER PRIMARY KEY, category_id INTEGER,  imageURL TEXT, isInWash INTEGER, timeOfWash INTEGER, FOREIGN KEY(category_id) REFERENCES ItemCategories(id));
CREATE TABLE OutfitCategories(id INTEGER PRIMARY KEY, title TEXT);
CREATE TABLE Outfits(id INTEGER PRIMARY KEY, category_id INTEGER, FOREIGN KEY(category_id) REFERENCES OutfitCategories(id));  
CREATE TABLE OutfitItems(outfit_id INTEGER, item_id INTEGER, FOREIGN KEY(outfit_id) REFERENCES Outfits(id) ON DELETE CASCADE, FOREIGN KEY(item_id) REFERENCES Items(id) ON DELETE CASCADE);
CREATE TABLE Events(event_id INTEGER PRIMARY KEY, date TEXT, outfit_id INTEGER);


