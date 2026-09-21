-- =====================================
-- BÀI TẬP: QUẢN LÝ BÁN HÀNG
-- =====================================

CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

-- Xóa bảng nếu đã tồn tại
DROP TABLE IF EXISTS OrderDetail;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;

-- =====================================
-- TẠO BẢNG
-- =====================================

CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(25),
    cAge TINYINT
);

CREATE TABLE Orders (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);

CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES Orders(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);

-- =====================================
-- THÊM DỮ LIỆU
-- =====================================

INSERT INTO Customer VALUES
(1,'Minh Quan',10),
(2,'Ngoc Oanh',20),
(3,'Hong Ha',50);

INSERT INTO Orders VALUES
(1,1,'2006-03-21',NULL),
(2,2,'2006-03-23',NULL),
(3,1,'2006-03-16',NULL);

INSERT INTO Product VALUES
(1,'May Giat',3),
(2,'Tu Lanh',5),
(3,'Dieu Hoa',7),
(4,'Quat',1),
(5,'Bep Dien',2);

INSERT INTO OrderDetail VALUES
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- =====================================
-- CÂU 1
-- Hiển thị oID, oDate, oTotalPrice
-- =====================================

SELECT
    oID,
    oDate,
    oTotalPrice
FROM Orders;

-- =====================================
-- CÂU 2
-- Khách hàng đã mua hàng và sản phẩm mua
-- =====================================

SELECT
    c.Name AS CustomerName,
    p.pName AS ProductName
FROM Customer c
JOIN Orders o
    ON c.cID = o.cID
JOIN OrderDetail od
    ON o.oID = od.oID
JOIN Product p
    ON od.pID = p.pID;

-- =====================================
-- CÂU 3
-- Khách hàng chưa mua hàng
-- =====================================

SELECT
    Name
FROM Customer
WHERE cID NOT IN (
    SELECT cID
    FROM Orders
);

-- =====================================
-- CÂU 4
-- Mã hóa đơn, ngày bán và tổng tiền
-- =====================================

SELECT
    o.oID,
    o.oDate,
    SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM Orders o
JOIN OrderDetail od
    ON o.oID = od.oID
JOIN Product p
    ON od.pID = p.pID
GROUP BY o.oID, o.oDate;