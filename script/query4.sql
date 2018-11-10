SELECT COUNT(*) FROM (SELECT DISTINCT Item.userID FROM Item, User WHERE Item.userID = User.userID AND User.rating > 1000) AS D;
