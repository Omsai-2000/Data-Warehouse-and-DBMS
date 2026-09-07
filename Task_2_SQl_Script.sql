-- 1. Available Properties and Assigned Agents
SELECT  p.PropertyID, p.PropertyType, p.City, p.Price,  p.Status,
       CONCAT(a.FirstName, ' ', a.LastName) AS AgentName FROM property p
INNER JOIN agent a  ON p.AgentID = a.AgentID
WHERE p.Status = 'Available';

-- 2. Transactions handled by agents
SELECT t.TransactionID,  t.TransactionDate,  t.TransactionType,  t.Price,
    CONCAT(a.FirstName, ' ', a.LastName) AS AgentName FROM `transaction` t
INNER JOIN agent a  ON t.AgentID = a.AgentID
ORDER BY t.TransactionDate DESC;

-- 3. Transactions for clients
SELECT t.TransactionID, t.TransactionDate, t.TransactionType, t.Price,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName FROM `transaction` t
INNER JOIN client c  ON t.ClientID = c.ClientID
ORDER BY t.TransactionDate DESC;

SELECT p.PropertyID, p.PropertyType, p.City, p.Price, 
CONCAT(o.FirstName, ' ', o.LastName) AS OwnerName FROM property p
INNER JOIN propertyowner po ON p.PropertyID = po.PropertyID
INNER JOIN owner o ON po.OwnerID = o.OwnerID;

SELECT  a.AgentID, CONCAT(a.FirstName, ' ', a.LastName) AS AgentName, t.TransactionID, 
        t.TransactionDate, t.Price FROM agent a 
LEFT JOIN `transaction` t ON a.AgentID = t.AgentID
ORDER BY a.AgentID;