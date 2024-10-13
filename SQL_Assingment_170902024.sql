select year(ActionDate) as year,sum(ApplNo) as 
Total_application_approved from regactiondate
 where ActionType="AP" group by ActionDate;
WITH RankedApplications AS (
    SELECT YEAR(ActionDate) AS year, 
        SUM(ApplNo) AS Total_application_approved,
        RANK() OVER (ORDER BY SUM(ApplNo) DESC) AS RNK
    FROM regactiondate
    WHERE ActionType = 'AP'
    GROUP BY YEAR(ActionDate)
)SELECT year, Total_application_approved
FROM RankedApplications
WHERE RNK <= 3
ORDER BY Total_application_approved DESC;
WITH RankedApplications AS (
    SELECT YEAR(ActionDate) AS year, 
        SUM(ApplNo) AS Total_application_approved,
        RANK() OVER (ORDER BY SUM(ApplNo) ASC) AS RNK
    FROM regactiondate
    WHERE ActionType = 'AP'
    GROUP BY YEAR(ActionDate)
)SELECT year, Total_application_approved
FROM RankedApplications
WHERE RNK <= 3
ORDER BY Total_application_approved ASC;
SELECT application.SponsorApplicant,YEAR(regactiondate.ActionDate) AS Year, 
SUM(regactiondate.ApplNo) AS Total_Application FROM application
JOIN regactiondate ON application.ApplNo = regactiondate.ApplNo
WHERE YEAR(regactiondate.ActionDate) BETWEEN 2014 AND 2016
GROUP BY application.SponsorApplicant, YEAR(regactiondate.ActionDate)
ORDER BY application.SponsorApplicant, Year;
SELECT application.SponsorApplicant,YEAR(regactiondate.ActionDate) AS Year, 
SUM(regactiondate.ApplNo) AS Total_Application,RANK() OVER
(PARTITION BY YEAR(regactiondate.ActionDate) ORDER BY SUM(regactiondate.ApplNo) DESC) AS RNK
FROM application JOIN regactiondate ON application.ApplNo = regactiondate.ApplNo
WHERE YEAR(regactiondate.ActionDate) BETWEEN 1939 AND 1960
GROUP BY application.SponsorApplicant, YEAR(regactiondate.ActionDate)
ORDER BY Year, RNK;
SELECT
    CASE 
        WHEN ProductMktStatus = 1 THEN 'Marketed'
        WHEN ProductMktStatus = 2 THEN 'Withdrawn'
        WHEN ProductMktStatus = 3 THEN 'Pending'
        ELSE 'Pre-Market'
    END AS Product_group,
    COUNT(*) AS Product_count
FROM product
GROUP BY
    CASE 
        WHEN ProductMktStatus = 1 THEN 'Marketed'
        WHEN ProductMktStatus = 2 THEN 'Withdrawn'
        WHEN ProductMktStatus = 3 THEN 'Pending'
        ELSE 'Pre-Market'END;
SELECT
    CASE 
        WHEN ProductMktStatus = 1 THEN 'Marketed'
        WHEN ProductMktStatus = 2 THEN 'Withdrawn'
        WHEN ProductMktStatus = 3 THEN 'Pending'
        ELSE 'Pre-Market'
    END AS Product_group,
    COUNT(application.ApplNo) AS Total_Application
FROM product
JOIN application ON product.ApplNo = application.ApplNo 
JOIN regactiondate ON application.ApplNo = regactiondate.ApplNo
WHERE regactiondate.ActionDate > '2010-01-01'
GROUP BY
    CASE 
        WHEN ProductMktStatus = 1 THEN 'Marketed'
        WHEN ProductMktStatus = 2 THEN 'Withdrawn'
        WHEN ProductMktStatus = 3 THEN 'Pending'
        ELSE 'Pre-Market'
    END;
SELECT
    CASE 
        WHEN ProductMktStatus = 1 THEN 'Marketed'
        WHEN ProductMktStatus = 2 THEN 'Withdrawn'
        WHEN ProductMktStatus = 3 THEN 'Pending'
        ELSE 'Pre-Market'
    END AS Product_group,
    COUNT(application.ApplNo) AS Total_Application
FROM product
JOIN application ON product.ApplNo = application.ApplNo 
JOIN regactiondate ON application.ApplNo = regactiondate.ApplNo
GROUP BY
    CASE 
        WHEN ProductMktStatus = 1 THEN 'Marketed'
        WHEN ProductMktStatus = 2 THEN 'Withdrawn'
        WHEN ProductMktStatus = 3 THEN 'Pending'
        ELSE 'Pre-Market'
    END
ORDER BY Total_Application DESC;
select Dosage,count(*) as Total_Dosage from product group by Dosage;
select product.Dosage,sum(regactiondate.ApplNo) as Total_Apllication
 from product join regactiondate on product.ApplNo=regactiondate.ApplNo
 where regactiondate.ActionType="AP" group by product.Dosage,regactiondate.ApplNo;
 SELECT Form, COUNT(*) AS Total FROM product WHERE 
ProductMktStatus = 1 GROUP BY Form ORDER BY Total DESC;
select product_tecode.TECode,count(regactiondate.ApplNo) as Total_Approve from product_tecode join regactiondate on product_tecode.ApplNo=regactiondate.ApplNo
where regactiondate.ActionType="AP" group by product_tecode.TECode order by Total_Approve desc;
select product_tecode.TECode,year(regactiondate.ActionDate) as Year,count(regactiondate.ApplNo) as Total_Approve from product_tecode join regactiondate on product_tecode.ApplNo=regactiondate.ApplNo
where regactiondate.ActionType="AP" group by year,product_tecode.TECode order by Total_Approve desc;
