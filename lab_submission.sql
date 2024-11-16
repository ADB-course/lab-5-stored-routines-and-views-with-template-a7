-- (i) A Procedure called PROC_LAB5
DELIMITER $$  
CREATE PROCEDURE `PROC_LAB5`(IN employeeID INT)  
BEGIN  
    DECLARE totalOrders INT;  
    DECLARE totalSales DECIMAL(10, 2);  
    DECLARE averageOrderValue DECIMAL(10, 2);  

    SELECT COUNT(orders.orderNumber)   
    INTO totalOrders  
    FROM orders  
    WHERE orders.employeeNumber = employeeID;  

    SELECT SUM(orders.amount)   
    INTO totalSales  
    FROM orders  
    WHERE orders.employeeNumber = employeeID;  
 
    IF totalOrders > 0 THEN  
        SET averageOrderValue = totalSales / totalOrders;  
    ELSE  
        SET averageOrderValue = 0.00;  
    END IF;  

    SELECT  
        employees.firstName,  
        employees.lastName,  
        totalOrders AS 'Total Orders',   
        totalSales AS 'Total Sales',   
        averageOrderValue AS 'Average Order Value'  
    FROM  
        employees  
    WHERE  
        employees.employeeNumber = employeeID;  
END$$  
DELIMITER ;

-- (ii) A Function called FUNC_LAB5
DELIMITER $$  

CREATE FUNCTION `FUNC_LAB5`(employeeID INT) RETURNS DECIMAL(10, 2)  
DETERMINISTIC  
BEGIN  
    DECLARE totalSales DECIMAL(10, 2);  
    DECLARE commission DECIMAL(10, 2);  
    
    SELECT   
        SUM(orders.amount) INTO totalSales  
    FROM   
        orders  
    WHERE   
        orders.employeeNumber = employeeID;  

    IF totalSales IS NULL THEN  
        SET totalSales = 0.00;  
    END IF;  

    SET commission = totalSales * 0.05; 
    
    RETURN commission;  
END$$  

DELIMITER ;

-- (iii) A View called VIEW_LAB5

CREATE VIEW `VIEW_LAB5` AS  
SELECT  
    orders.orderNumber AS 'Order Number',  
    orders.orderDate AS 'Order Date',  
    orders.status AS 'Status',  
    customers.customerName AS 'Customer Name'  
FROM  
    orders  
JOIN  
    customers ON orders.customerNumber = customers.customerNumber;