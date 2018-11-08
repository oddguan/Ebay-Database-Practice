SELECT itemID FROM Item WHERE buy_price = (
SELECT MAX(buy_price)
FROM Item);
