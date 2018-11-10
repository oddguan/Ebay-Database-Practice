SELECT COUNT(*) FROM Bid, Category WHERE Bid.itemID = Category.itemID AND Bid.amount > 1000;
