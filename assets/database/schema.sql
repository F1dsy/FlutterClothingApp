CREATE TABLE ItemCategories(id INTEGER PRIMARY KEY, title TEXT);
CREATE TABLE Items(id INTEGER PRIMARY KEY, category_id INTEGER,  imageURL TEXT, FOREIGN KEY(category_id) REFERENCES ItemCategories(id));
CREATE TABLE ItemData(id INTEGER, temperature INTEGER, formality INTEGER, color TEXT, secondary_color TEXT, FOREIGN KEY(id) REFERENCES Items(id) ON DELETE CASCADE);
CREATE TABLE OutfitCategories(id INTEGER PRIMARY KEY, title TEXT);
CREATE TABLE Outfits(id INTEGER PRIMARY KEY, category_id INTEGER, feature_imageURL TEXT, FOREIGN KEY(category_id) REFERENCES OutfitCategories(id));  
CREATE TABLE OutfitItems(id INTEGER, item_id INTEGER, FOREIGN KEY(id) REFERENCES Outfits(id) ON DELETE CASCADE, FOREIGN KEY(id) REFERENCES Items(id) ON DELETE CASCADE);
CREATE TABLE Events(id INTEGER PRIMARY KEY, date TEXT, outfit_id INTEGER);


