SELECT COUNT(*) FROM (SELECT DISTINCT User.userID FROM User, Bid, Item WHERE User.userID = Bid.UserID AND User.userID = Item.userID) AS D;
