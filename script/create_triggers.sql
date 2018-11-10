DELIMITER ;
DROP TRIGGER IF EXISTS item_check_before;
DROP TRIGGER IF EXISTS before_insert_bid;
DROP TRIGGER IF EXISTS after_insert_bid;
DROP TRIGGER IF EXISTS before_update_time;

DELIMITER //
CREATE TRIGGER item_check_before BEFORE INSERT ON Item
FOR EACH ROW
BEGIN
IF NEW.ends < NEW.started THEN
CALL `Error0:The end time must be after its start time/`;
END IF;
END;//

# Constraints for Bidding
CREATE TRIGGER before_insert_bid BEFORE INSERT ON Bid
FOR EACH ROW
BEGIN
  IF NEW.userID = ANY (SELECT userID FROM Item WHERE NEW.itemID = Item.itemID) THEN
    CALL `Error1:Bid own item`; 
 
  ELSEIF NEW.time = ANY (SELECT Bid.time FROM Bid,Item WHERE Bid.itemID = Item.itemID AND Bid.itemID = NEW.itemID) THEN
    CALL `Error2:No same time auction`;

  ELSEIF NEW.time < ANY (SELECT Item.started FROM Item WHERE Item.itemID = NEW.itemID)
  OR
  NEW.time > ANY (SELECT Item.ends FROM Item WHERE Item.itemID = NEW.itemID) THEN
    CALL `Error3:No start end time violation`;

  ELSEIF NEW.amount = ANY (SELECT amount FROM Bid WHERE NEW.amount = Bid.amount AND NEW.itemID = Bid.itemID AND NEW.userID = Bid.userID) THEN
    CALL `Error4:No same amount bid`;

  ELSEIF NEW.amount <= ANY (SELECT Item.currently FROM Item WHERE Item.itemID = NEW.itemID) THEN
    CALL `Error5:Bid amount must be higher than current`;

  ELSEIF NEW.time != ANY (SELECT timeNow FROM CurrentTime) THEN
    CALL `Error6:Must match current time`;
  END IF;
END;//


# Constraints for Items
CREATE TRIGGER after_insert_bid AFTER INSERT ON Bid
FOR EACH ROW
BEGIN
  UPDATE Item
  SET Item.currently = NEW.amount
  WHERE NEW.itemID = Item.itemID;
END;//


#Constraints for Time
CREATE TRIGGER before_update_time BEFORE UPDATE ON CurrentTime
FOR EACH ROW
BEGIN
IF NEW.timeNow < ANY (SELECT timeNow FROM CurrentTime) THEN
  CALL `Error8:Must advance in time`;
END IF;
END;//

DELIMITER ;

 


