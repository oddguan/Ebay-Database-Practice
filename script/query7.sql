SELECT COUNT(DISTINCT B1.userID, B2.userID) AS Count
FROM Bid AS B1, Bid AS B2
WHERE B1.itemID = B2.itemID AND B1.userID < B2.userID;
