
CREATE TABLE online_retail (
    Invoice VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TIMESTAMP,
    Price NUMERIC(10,2),
    "Customer ID" INTEGER,
    Country VARCHAR(100)
);
SELECT * FROM online_retail1 limit 10;


CREATE TABLE online_retail1 (
    Invoice VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TIMESTAMP,
    Price NUMERIC(10,2),
    "Customer ID" INTEGER,
    Country VARCHAR(100)
);

select count(*) as total_row
from online_retail;
select count(*) as total_row
from online_retail1;

CREATE TABLE combined_retail AS
SELECT * FROM online_retail

UNION ALL

SELECT * FROM online_retail1;

SELECT COUNT(*) AS total_rows
FROM combined_retail;

-- check missing customer id
select count(*) as customer_id
from combined_retail
where  "Customer ID" is null;

-- check negative missing quantity
select count(*) as negative_quantity
from combined_retail
where  Quantity<=0;

-- check missing description
select count(*) as missing_description
from combined_retail
where   Description is null;

-- check duplicatr row
select Invoice,StockCode,Description,Quantity,InvoiceDate,Price,"Customer ID",Country,
count(*) as exact_duplicate
from combined_retail
group by Invoice,StockCode,Description,Quantity,InvoiceDate,Price,"Customer ID",Country
having count(*)>1;



CREATE TABLE final_retail AS
SELECT DISTINCT ON (
    invoice,
    stockcode,
    description,
    quantity,
    invoicedate,
    price,
    "Customer ID",
    country
)
    *
FROM combined_retail
ORDER BY
    invoice,
    stockcode,
    description,
    quantity,
    invoicedate,
    price,
    "Customer ID",
    country;
	
SELECT COUNT(*) AS total_rows
FROM final_retail;

SELECT
    invoice,
    stockcode,
    description,
    quantity,
    invoicedate,
    price,
    "Customer ID",
    country,
    COUNT(*) AS duplicate_count
FROM final_retail
GROUP BY
    invoice,
    stockcode,
    description,
    quantity,
    invoicedate,
    price,
    "Customer ID",
    country
HAVING COUNT(*) > 1;

select *from final_retail;
