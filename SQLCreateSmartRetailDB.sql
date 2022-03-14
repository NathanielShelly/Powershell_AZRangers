
/**************************************/
/*     SQLCreateSmartRetailDB.sql     */
/*******************************************************/
/* Define Import Functions for your Stored Procedures   */
/********************************************************/
/* Click .edmx file to open databse model view          */
/* 1. Right click view, Select Model Browser.           */
/* 2. Expand Stored Procedures.                         */
/*          -- For Each Stored Procedure --             */ 
/* 3. Right Click each Stored                           */
/* 4. Select Add Function Import                        */
/* 5. Choose import type given below for each procedure */
/*    -- Close Model Browser and ReviewModel --         */
/********************************************************/
/*       Import Table and Procedure definitions         */
/********************************************************/
/* 1. Delete dbo folder in Terawe.Retail.SQL.Database   */
/* 2. Right Click on Terawe.Retail.SQL.Database         */
/* 3. Select Import                                     */
/* 4. Select Database                                   */
/* 5. select database connection and connect.           */
/* 6. Click Start                                       */
/* 7. When available - Click Finish.                    */
/********************************************************/
/* You are Done! Clean and Rebuild your solution!!!     */
/**********************************************************/
/* You may need to change the name of a connection string */
/* in App.config - retailstardbEntities but that's ALL!   */
/**********************************************************/

/* Focus on your database manually.
   use galieyedemodb
   use retailstardb
   GO */

SET ANSI_PADDING ON
GO

/**********************/
/*   gauge_limits     */
/**********************/

/* drop table gauge_limits
  GO */

CREATE TABLE [dbo].[gauge_limits] (
    [g_min]        SMALLINT NOT NULL,
    [g_max]        SMALLINT NOT NULL,
    [red_start]    SMALLINT NOT NULL,
    [red_stop]     SMALLINT NOT NULL,
    [yellow_start] SMALLINT NOT NULL,
    [yellow_stop]  SMALLINT NOT NULL
)
GO

insert gauge_limits values(0,100,0,20,20,50)
GO

/**********************/
/*    review_text     */
/**********************/

/* drop table review_text
GO */

CREATE TABLE [dbo].[review_text] (
    [row_id]        INT           IDENTITY (1, 1) NOT NULL,
    [revid]         INT           NOT NULL,
    [lineid]        INT           NOT NULL,
	[prod_id]		INT,
	[vend_id]		INT,
    [rev_text]      NVARCHAR (Max) NOT NULL,
    [rev_lang]      NVARCHAR (4)   NOT NULL,
    [sentid]        INT           NOT NULL,
    [rev_sentiment] REAL          NOT NULL,
	[import_date]   datetime      NOT NULL default (GETDATE()),
    CONSTRAINT [PK_RevTextRowId] PRIMARY KEY CLUSTERED ([row_id] ASC)
)

GO

/* select * from review_text
GO */

/************************/
/*    review_phrase     */
/************************/


/* drop table review_phrase
GO */

CREATE TABLE review_phrase
(
   pid		int  NOT NULL IDENTITY(1,1),
   p_text	nvarchar(256)  NOT NULL,
   p_count 	smallint	NOT NULL,
   p_sentiment	real	NOT NULL,
   p_sentiment100	AS (p_sentiment * 100.0) PERSISTED NOT NULL
CONSTRAINT [PK_RevPhraseId] PRIMARY KEY CLUSTERED ([pid] ASC)
)
GO


/******************************/
/*    review_phrase_topic     */
/******************************/

/* drop Table review_phrase_topic
GO */

CREATE TABLE review_phrase_topic
(  
   rid				int     NOT NULL,
   lineid			int     NOT NULL,
   rev_text			nvarchar(Max)	NOT NULL,
   pid				int     NOT NULL,
   rev_sentiment	float(24)	NOT NULL,
   rev_sentiment100	AS (rev_sentiment * 100.0) PERSISTED NOT NULL,
   vend_id			int,
   vendor_name		nvarchar(100),
   vendor_sentiment	float(24),
   vendor_sentiment100	AS (vendor_sentiment * 100.0) PERSISTED,
   prod_id			int,
   prod_name		nvarchar(256),
   prod_quality		float(24),
   prod_comfort		float(24),
   prod_value		float(24),
   topid			int,
   topic_score		int,
   topic_text		nchar(100)
   PRIMARY KEY CLUSTERED(rid, lineid, pid)
 )
GO

/* select * from review_phrase_topic
GO */

/************************/
/*    review_vendor      */
/************************/

/* drop table review_vendor
GO */

CREATE TABLE review_vendor(
vend_id			int  IDENTITY (1, 1) NOT NULL,
vendor_name		nvarchar(100)	NOT NULL,
vendor_description nvarchar(512),
vendor_sentiment	float(24)	NOT NULL,
price_sentiment		float(24)	NOT NULL,
product_sentiment	float(24)	NOT NULL,
service_sentiment	float(24)	NOT NULL,
alexa_us			int,
us_in_10000	AS (10000 - alexa_us) PERSISTED,
alexa_global		int,
global_in_50000	AS (50000 - alexa_global) PERSISTED,
global_delta		int,
IsChecked bit DEFAULT 0,
CONSTRAINT [PK_review_vendor] PRIMARY KEY CLUSTERED ([vend_id] ASC)
)
GO

/************************/
/*    vendor_ranking    */
/************************/

CREATE TABLE vendor_ranking(
vend_id				int  NOT NULL,
alexa_us			int	 NOT NULL,
us_in_10000	AS (10000 - alexa_us) PERSISTED,
alexa_global		int,
global_in_50000	AS (50000 - alexa_global) PERSISTED,
global_delta		int  NOT NULL,
ranking_date		datetime NOT Null,
CONSTRAINT [PK_vendor_ranking] PRIMARY KEY CLUSTERED ([vend_id], [ranking_date] ASC)
)
GO

-- Jamuary 2022
insert vendor_ranking values(1,641,2635,-478,'01/31/2022')
insert vendor_ranking values(2,4,8,-1,'01/31/2022')
insert vendor_ranking values(3,1464,4674,433,'01/31/2022')
insert vendor_ranking values(4,522,1087,-43,'01/31/2022')
insert vendor_ranking values(5,9691,34119,-6820,'01/31/2022') 
insert vendor_ranking values(6,3407,10279,-787,'01/31/2022') 
insert vendor_ranking values(7,39,116,68,'01/31/2022') 
GO

-- February 2022
insert vendor_ranking values(1,737,2938,-383,'02/28/2022')
insert vendor_ranking values(2,4,9,-1,'02/28/2022')
insert vendor_ranking values(3,1354,5496,-383,'02/28/2022')
insert vendor_ranking values(4,539,1180,-119,'02/28/2022')
insert vendor_ranking values(5,9461,35784,-108,'02/28/2022') 
insert vendor_ranking values(6,2845,10924,-512,'02/28/2022') 
insert vendor_ranking values(7,37,184,-68,'02/28/2022') 
GO

insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(1,405,2680,-74,'2022-03-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(2,5,13,-5,'2022-03-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(3,1236,5872,-1127,'2022-03-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(4,425,1220,-187,'2022-03-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(5,8680,34729,-345,'2022-03-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(6,3256,11840,-1919,'2022-03-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(7,45,211,-46,'2022-03-30 00:00:00.000')
GO

insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(1,361,2245,361,'2022-04-28 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(2,5,14,-6,'2022-04-28 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(3,1392,5907,-1314,'2022-04-28 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(4,391,1167,-76,'2022-04-28 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(5,8477,32435,1441,'2022-04-28 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(6,2792,11309,-1098,'2022-04-28 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(7,47,213,-51,'2022-04-28 00:00:00.000')
GO

insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(1,314,1802,443,'2022-05-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(2,5,12,2,'2022-05-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(3,1350,6010,-103,'2022-05-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(4,379,1149,18,'2022-05-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(5,10172,32477,-42,'2022-05-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(6,23770,16174,-4865,'2022-05-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(7,41,215,-2,'2022-05-31 00:00:00.000')
GO

insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(1,380,1774,28,'2022-06-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(2,5,12,0,'2022-06-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(3,1360,6549,-539,'2022-06-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(4,363,1163,-14,'2022-06-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(5,9367,33611,-1134,'2022-06-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(6,35368,36981,-20807,'2022-06-30 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(7,37,204,11,'2022-06-30 00:00:00.000')
GO

insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(1,392,1770,4,'2022-07-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(2,4,11,1,'2022-07-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(3,1367,6439,110,'2022-07-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(4,352,1175,-12,'2022-07-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(5,9250,33874,-263,'2022-07-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(6,79130,179710,-142729,'2022-07-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(7,34,188,16,'2022-07-31 00:00:00.000')
GO

insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(1,341,1796,-26,'2022-08-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(2,5,10,1,'2022-08-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(3,1159,5880,559,'2022-08-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(4,370,1239,-64,'2022-08-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(5,8770,31948,1926,'2022-08-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(6,89590,351687,-171977,'2022-08-31 00:00:00.000')
insert into vendor_ranking(vend_id,alexa_us,alexa_global,global_delta,ranking_date) values(7,35,175,13,'2022-08-31 00:00:00.000')
GO


/************************/
/*    vendor_rating     */
/************************/

CREATE TABLE vendor_rating(
vend_id				int  NOT NULL,
vendor_sentiment	float(24)	NOT NULL,
price_sentiment		float(24)	NOT NULL,
product_sentiment	float(24)	NOT NULL,
service_sentiment	float(24)	NOT NULL,
rating_date			datetime	NOT Null,
CONSTRAINT [PK_vendor_rating] PRIMARY KEY CLUSTERED ([vend_id], [rating_date] ASC)
)
GO

-- Jamuary 2022
insert vendor_rating values(1,6.67,5.10,3.73,5.78,'01/31/2022')
insert vendor_rating values(2,7.29,7.68,7.31,7.09,'01/31/2022')
insert vendor_rating values(3,4.96,5.38,4.72,4.35,'01/31/2022')
insert vendor_rating values(4,8.60,6.53,9.76,7.76,'01/31/2022')
insert vendor_rating values(5,4.75,10.00,5.83,0.0,'01/31/2022') 
insert vendor_rating values(6,3.57,3.03,3.22,1.08,'01/31/2022') 
insert vendor_rating values(7,7.47,6.91,6.32,5.74,'01/31/2022') 
GO

-- February 2022
insert vendor_rating values(1,6.67,5.10,3.73,5.78,'02/28/2022')
insert vendor_rating values(2,7.43,7.32,7.34,7.09,'02/28/2022')
insert vendor_rating values(3,6.44,6.79,6.15,5.78,'02/28/2022')
insert vendor_rating values(4,8.20,6.22,7.78,7.12,'02/28/2022')
insert vendor_rating values(5,4.80,10.00,5.83,0.0,'02/28/2022') 
insert vendor_rating values(6,2.20,3.85,3.50,1.09,'02/28/2022') 
insert vendor_rating values(7,7.48,6.91,6.33,5.74,'02/28/2022') 
GO

-- March 2022
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(1,6.67,5.08,3.69,5.77,'2022-03-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(2,7.53,7.8,7.41,7.12,'2022-03-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(3,6.35,8.52,7.96,7.21,'2022-03-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(4,8.46,6.25,7.8,7.02,'2022-03-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(5,4.6,10,5.83,0,'2022-03-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(6,2.04,4.7,3.37,0.91,'2022-03-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(7,6.37,6.26,5.28,4.85,'2022-03-30 00:00:00.000')
GO

insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(1,6.45,4.66,3.69,5.08,'2022-04-28 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(2,7.53,7.86,7.41,7.43,'2022-04-28 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(3,6.25,8.68,8.08,7.46,'2022-04-28 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(4,8.02,6.26,7.81,7.15,'2022-04-28 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(5,4.98,10,5,3.33,'2022-04-28 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(6,1.96,4.14,2.15,0.84,'2022-04-28 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(7,6.35,6.296,5.28,4.88,'2022-04-28 00:00:00.000')
GO

insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(1,6.03,4.27,3.30,4.31,'2022-05-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(2,7.26,7.85,7.64,7.45,'2022-05-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(3,6.54,9.03,9.46,8.83,'2022-05-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(4,7.37,6.59,7.81,7.81,'2022-05-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(5,5.28,10,3.33,3.33,'2022-05-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(6,1.47,4.26,2.32,1.02,'2022-05-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(7,6.30,6.29,5.45,4.85,'2022-05-31 00:00:00.000')
GO

insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(1,5.87,3.13,2.15,3.54,'2022-06-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(2,7.00,7.74,7.19,7.10,'2022-06-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(3,6.32,8.72,9.53,8.60,'2022-06-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(4,7.60,6.59,7.81,7.81,'2022-06-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(5,4.51,5.00,2.50,2.50,'2022-06-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(6,1.45,3.74,1.39,1.14,'2022-06-30 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(7,6.11,3.45,5.51,5.01,'2022-06-30 00:00:00.000')
GO

insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(1,5.99,3.13,2.15,3.39,'2022-07-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(2,7.00,7.62,7.15,7.04,'2022-07-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(3,6.32,7.94,8.57,7.80,'2022-07-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(4,7.37,6.59,7.81,7.81,'2022-07-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(5,4.51,6,3.20,2.50,'2022-07-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(6,1.41,3.27,1.25,0.70,'2022-07-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(7,6.11,3.44,5.49,4.99,'2022-07-31 00:00:00.000')
GO

insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(1,6.38,3.17,2.13,2.99,'2022-08-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(2,7.03,7.59,7.21,7.03,'2022-08-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(3,6.22,6.96,7.78,5.95,'2022-08-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(4,7.50,6.60,7.82,7.82,'2022-08-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(5,4.64,6.88,4.00,2.50,'2022-08-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(6,1.36,2.55,1.15,0.13,'2022-08-31 00:00:00.000')
insert into vendor_rating(vend_id,vendor_sentiment,price_sentiment,product_sentiment,service_sentiment,rating_date) values(7,6.16,6.25,5.50,4.96,'2022-08-31 00:00:00.000')
GO


/*************************************/
/*      Add Reviewed Vendors         */
/*************************************/

insert review_vendor values('REI', 'At Recreational Equipment, Inc. we design and sell our own line of award-winning REI brand outdoor gear and clothing.',6.67,5.10,3.73,5.78,641,2635,-478,1)
GO
insert review_vendor values('Amazon', 'At Amazon we serve consumers through our retail websites, manufacture and sell electronic devices, and offer programs that allow sellers to publish and sell content.',7.29,7.68,7.31,7.09,4,8,-1,0)
GO
insert review_vendor values('Backcountry','Backcountry.com began with two guys in 1996. We''ve grown since then, but our vision is still clear: to provide the best outdoor gear�and to be the best at doing it.',4.96,5.38,4.72,4.35,1464,4674,433,0)
GO
insert review_vendor values('Zappos','Zappos.com is an online shoe and clothing shop based in Las Vegas, Nevada.In July 2009, the company was acquired and became part of Amazon.com.',8.60,6.53,9.76,7.76,522,1087,-43,0)
GO
insert review_vendor values('CampSaver','CampSaver.com began its life in 2003 and has grown into a leading online retailer of fine outdoor merchandise.',4.75,10.00,5.83,0.0,9691,34119,-6820,0) 
GO
insert review_vendor values('ShoeBuy','Shoebuy is the largest retailer on the Internet focused on all categories of footwear and related apparel. Shoebuy has partnerships with over 250 manufacturers.',3.57,3.03,3.22,1.08,3407,10279,-787,0) 
GO
insert review_vendor values('Walmart','At Walmart.com We feature a great selection of high-quality merchandise, friendly service and, of course, Every Day Low Prices. Our goal: bring you the best shopping experience on the Internet.',7.47,6.91,6.32,5.74,39,116,68,0) 
GO


/************************/
/*   review_product     */
/************************/

/* drop table review_product
GO */

CREATE TABLE review_product(
prod_id			int  IDENTITY (1, 1) NOT NULL,
prod_name		nvarchar(256)	NOT NULL,
prod_description	nvarchar(1024),
product_image_str	nvarchar(256),
CONSTRAINT new_product_false default IsChecked (0),
CONSTRAINT [PK_review_product] PRIMARY KEY CLUSTERED ([prod_id] ASC)
)
GO

insert review_product values('Vasque Mantra 2.0', 'Our most stable and protective low hiking shoe has a proven track record as a trail performer and top notch travel companion.','Vasque_Mantra_2_0.jpg',1);
GO
insert review_product values('Vasque Talus Trek Low UltraDry','Vasque Talus Trek Low UltraDry Hiking Shoes feature waterproof protection, low-cut ankles and athletic midsoles that protect your feet and return energy to your step.','Vasque_Talus_Trek_Low_UltraDry.jpg',0)
GO
insert review_product values('Vasque Talus Trek Mid UltraDry','Vasque Talus Trek Mid UltraDry Hiking Boots offer lightweight, waterproof performance to comfortably protect the feet during your outdoor adventures.','Vasque_Talus_Trek_Mid_UltraDry.jpg',0)
GO
insert review_product values('Vasque Grand Traverse','Bridging the performance of an approach shoe with the all-day comfort of athletic footwear, Vasque Grand Traverse hiking shoes keep you moving fast over a variety of terrain.','Vasque_Grand_Traverse.jpg',0)
GO
insert review_product values('Vasque Juxt Trail Shoes','Providing athletic fit for quickness and agility over challenging ground. The Vasque Juxt''s aggressive toe spring helps you clear obstacles at high speeds.','Vasque_Juxt_Trail_Shoe.jpg',0)
GO
insert review_product values('KEEN Targhee II Hiking Boots','KEEN Targhee II waterproof day hikers deliver tenacious traction, stability and comfort.','Keen_Targhee_II_Boot.jpg',0)
GO


/************************/
/*    vendor_product    */
/************************/

CREATE TABLE vendor_product(
vend_id			int  NOT NULL,
prod_id			int  NOT NULL,
webProductString nvarchar(256),
CONSTRAINT [pk_vendor_product] PRIMARY KEY CLUSTERED ([vend_id],[prod_id])
)
GO
-- REI
insert vendor_product values(1,1,'Vasque Mantra 2.0 Hiking Shoes - Men''s')
insert vendor_product values(1,2,'Vasque Talus Trek Low UltraDry Hiking Shoes - Men''s')
insert vendor_product values(1,3,'Vasque Breeze 2.0 Low GTX Hiking Shoes - Men''s')
insert vendor_product values(1,4,'Vasque Grand Traverse Hiking Shoes - Men''s')
insert vendor_product values(1,6,'KEEN Targhee II Mid Hiking Boots - Men''s')
-- Amazon
insert vendor_product values(2,1,'Vasque Men''s Mantra 2.0 Hiking Shoe')
insert vendor_product values(2,2,'Vasque Men''s Talus Trek Low Ultradry Hiking Shoe')
insert vendor_product values(2,3,'Vasque Men''s Talus Trek Ultradry Hiking Boot')
insert vendor_product values(2,4,'Vasque Men''s Grand Traverse Performance Hiking Shoe')
insert vendor_product values(2,5,'Vasque Men''s Juxt Multi-Sport Shoe')
insert vendor_product values(2,6,'KEEN Men''s Targhee II Mid Wide Hiking Shoe')
-- BackCountry
insert vendor_product values(3,1,'Vasque Mantra 2.0 Hiking Shoe - Men''s')
insert vendor_product values(3,2,'Vasque Talus Trek Low UltraDry Hiking Shoe - Men''s')
insert vendor_product values(3,3,'Vasque Talus UltraDry Hiking Boot - Men''s')
insert vendor_product values(3,4,'Vasque Grand Traverse Hiking Shoe - Men''s')
insert vendor_product values(3,5,'Vasque Juxt Hiking Shoe - Men''s')
insert vendor_product values(3,6,'KEEN Targhee II Hiking Shoe - Men''s')
-- Zappos
insert vendor_product values(4,1,'Vasque Mantra 2.0')
insert vendor_product values(4,2,'Vasque Talus UltraDry')
insert vendor_product values(4,3,'Vasque Talus Trek UltraDry')
insert vendor_product values(4,4,'Vasque Grand Traverse')
-- CampSaver
insert vendor_product values(5,1,'Vasque Mantra 2.0')
-- ShoeBuy
insert vendor_product values(6,1,'Vasque Mantra 2.0')
insert vendor_product values(6,4,'Vasque Grand Traverse')
-- Walmart
insert vendor_product values(7,1,'Vasque Men Mantra 2.0 Sneakers')
insert vendor_product values(7,2,'Vasque Talus Trek Low UltraDry')
insert vendor_product values(7,3,'Vasque Talus Trek Mid UltraDry')
insert vendor_product values(7,4,'Vasque Men Grand Traverse Sneakers')
insert vendor_product values(7,5,'Vasque Men Juxt Hiking Sneakers')
insert vendor_product values(7,6,'Keen Targhee II Mid Wide Hiking Boots Men''s Shoes')


/************************/
/*      vend_phrase     */
/************************/

CREATE TABLE [dbo].[vend_phrase](
[vpid] [int] IDENTITY(1,1) NOT NULL,
[vp_text] [nvarchar](256) NOT NULL,
[vp_count] [smallint] NOT NULL,
[vp_sentiment] [real] NOT NULL,
[vp_sentiment100]  AS ([vp_sentiment]*(100.0)) PERSISTED NOT NULL,
 CONSTRAINT [PK_VendPhraseId] PRIMARY KEY CLUSTERED 
(
[vpid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/************************/
/*      vend_text       */
/************************/

CREATE TABLE [dbo].[vend_text](
	[row_id] [int] IDENTITY(1,1) NOT NULL,
	[vrevid] [int] NOT NULL,
	[vlineid] [int] NOT NULL,
	[vend_id] [int] NULL,
	[vrev_text] [nvarchar](max) NOT NULL,
	[vrev_lang] [nvarchar](4) NOT NULL,
	[vsentid] [int] NOT NULL,
	[vrev_sentiment] [real] NOT NULL,
	[import_date] [datetime] NOT NULL,
 CONSTRAINT [PK_VendTextRowId] PRIMARY KEY CLUSTERED 
(
	[row_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[vend_text] ADD  DEFAULT (getdate()) FOR [import_date]
GO

/************************/
/*   vend_review_fact   */
/************************/

CREATE TABLE [dbo].[vend_review_fact](
	[vrid] [int] NOT NULL,
	[vlineid] [int] NOT NULL,
	[vrev_text] [nvarchar](max) NOT NULL,
	[vpid] [int] NOT NULL,
	[vrev_sentiment] [real] NOT NULL,
	[vrev_sentiment100]  AS ([vrev_sentiment]*(100.0)) PERSISTED NOT NULL,
	[vend_id] [int] NULL,
	[vendor_name] [nvarchar](100) NULL,
	[vendor_sentiment] [real] NULL,
	[vendor_sentiment100]  AS ([vendor_sentiment]*(100.0)) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[vrid] ASC,
	[vlineid] ASC,
	[vpid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/************************/
/*    review_topic      */
/************************/

/* drop table dbo.review_topic
GO */

CREATE TABLE [dbo].[review_topic](
	[topid]      INT     IDENTITY (1, 1) NOT NULL,
	[topic_id]   [nchar](50) NOT NULL,
	[topic_score] [int] NOT NULL,
	[topic_text]  [nchar](100) NOT NULL,
CONSTRAINT [PK_review_topic] PRIMARY KEY CLUSTERED ([topid] ASC)
)
GO

/******************************/
/*    review_phrase_topic     */
/******************************/

/* drop table product_recommendations
GO */

CREATE TABLE [dbo].[product_recommendations] (
    [itemid]    INT         IDENTITY (1, 1) NOT NULL,
    [item_ID]   INT         NOT NULL,
    [item_name] NCHAR (300) NULL,
    [rating]    FLOAT (53)  NULL,
    [userid]    INT         NULL,
    [reasons]   NCHAR (300) NULL,
    CONSTRAINT [PK_product_recommendations] PRIMARY KEY CLUSTERED ([itemid] ASC)
)
GO


Create Table [dbo].[review_process_control] (
  [process_id]    int         IDENTITY (1, 1) NOT NULL,
  [last_text_sent_id] int NOT NULL,
  [last_import_processed_date] datetime NOT NULL,
   CONSTRAINT [PK_process_control] PRIMARY KEY CLUSTERED ([process_id] ASC)
)

CREATE UNIQUE INDEX UNQ_RPControl
on review_process_control (last_text_sent_id, last_import_processed_date)
GO

insert [dbo].[review_process_control] values (0,'20220401')
go

/******************************/
/*     Stored Procedures      */
/******************************/

/***************************************/
/*        GetLikeReviewTexts           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> review_text           */
/***************************************/

/* Drop Procedure GetLikeReviewTexts
GO */

Create Procedure [dbo].[GetLikeReviewTexts]
	@thisPhrase nvarchar(100),
	@lastSentId int
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT *
    	FROM review_text
    	WHERE rev_text Like CONCAT('%',@thisPhrase,'%')
		AND sentid > = @lastSentId;
	END
GO

/***************************************/
/*         GetMatchingPhrase           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> review_phrase         */
/***************************************/

/* Drop Procedure GetMatchingPhrase
GO */

Create Procedure [dbo].[GetMatchingPhrase]
	@thisPhrase nvarchar(100)
	AS
	BEGIN
	SET NOCOUNT ON;
		SELECT rp.p_count
		FROM review_phrase rp
		WHERE rp.p_text = @thisPhrase
	END
GO

/* 
   exec GetMatchingPhrase @thisPhrase = 'rocks' 
   go
*/

/* Drop Procedure GetMatchingPhraseInfo
GO */

Create Procedure GetMatchingPhraseInfo
    @thisVendId int,
	@thisProdId int,
	@thisPhrase nvarchar(100)
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT p.pid phraseId, count(rpt.rev_sentiment100) size
    	FROM review_phrase p, review_phrase_topic rpt
    	WHERE p.p_text = @thisPhrase
		and p.pid = rpt.pid
		and rpt.vend_id = @thisVendId
		and rpt.prod_id = @thisProdId
	group by p.pid
	
	END
GO

/* exec GetMatchingPhraseInfo @thisVendId = 1, @thisProdId = 1, @thisPhrase = 'rocks' 
   go
*/

select p.p_text 
FROM review_phrase p, review_phrase_topic rpt
where rpt.vend_id = 1
and rpt.prod_id = 1
and rpt.pid = p.pid

GO

/* Drop Procedure GetMatchingIdforPhraseText
GO */

/*******************************************/
/* TRICK - First DECLARE @ReturnScalar INT */
/*         Select  @ReturnScalar = pid     */
/*         RETURN ISNULL(@ReturnScalar,0)  */
/* This causes Entity Framework to create  */
/* A non-Null entry for the result set!!!  */
/*******************************************/
/*  Still Screwed Up! */
/* 
Create Procedure GetMatchingIdforPhraseText
	@thisPhrase nvarchar(100)
	AS
	BEGIN
		SELECT pid 
    	FROM review_phrase
    	WHERE p_text = @thisPhrase
	END
GO
*/

/***************************************/
/*      DoProductStringsMatch          */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> vendor_product        */
/***************************************/

CREATE PROCEDURE [dbo].[DoProductStringsMatch]
	@vendNum int,
	@prodNum int,
	@prodString nvarchar(256)
	As
	  Begin
		SET NOCOUNT ON
		SELECT count(*) 
		from vendor_product vp
		where vp.vend_id = @vendNum
		and vp.prod_id = @prodNum
		and vp.webProductString = @prodString
	  END
GO

/***************************************/
/*        GetMoreReviewTexts           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> review_text           */
/***************************************/

/* Drop Procedure GetMoreReviewTexts
GO */

CREATE PROCEDURE GetMoreReviewTexts 
    @LastSentId int   
    AS
    BEGIN
  SET NOCOUNT ON;
    	SELECT *
    	FROM review_text
    	WHERE sentid > @LastSentId
    END
GO

/***************************************/
/*         GetRevidForSentid           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Scalars -> int(32)                */
/***************************************/

/* Drop Procedure GetRevidForSentid
GO */

Create Procedure [dbo].[GetRevidForSentid]
	@thisSentId int
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT revid 
    	FROM review_text
    	WHERE sentid = @thisSentId;
	END
GO

/***************************************/
/*           IsReviewSaved             */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Scalars -> int(32)                */
/***************************************/

/* Drop Procedure IsReviewSaved
GO */

CREATE PROCEDURE [dbo].[IsReviewSaved]
	@vendNum int,
	@prodNum int,
	@firstLine nvarchar(50)
	As
	  Begin
		SET NOCOUNT ON
		SELECT count(*) FROM review_text
		WHERE vend_id = @vendNum
		AND prod_id = @prodNum
		AND lineid = 1
		AND SUBSTRING(rev_text,0, 50) = @firstLine
	  END
GO


/***************************************/
/*        PostReviewSentiment          */
/***************************************/
/* NO import Function needed           */
/***************************************/

/* Drop Procedure PostReviewSentiment
GO */

Create Procedure PostReviewSentiment
	@thisRevId int,
	@thisSentiment float
	AS
	BEGIN
	SET NOCOUNT ON;
    	Update review_text
    	set rev_sentiment = @thisSentiment
    	WHERE revid = @thisRevId;
	END
GO

/* drop procedure GetTopIdForTopics
GO */

/***************************************/
/*         GetTopidForTopics           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Scalars -> int(32)                */
/***************************************/
CREATE PROCEDURE [dbo].[GetTopIdForTopics]
	@thisTopicId nvarchar(50) 
AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT topid 
    	FROM review_topic
    	WHERE topic_id = @thisTopicId;
	END
GO

/***************************************/
/*        IsEntryInFactTable           */
/***************************************/
/* NO import Function needed           */
/***************************************/

Create Procedure [dbo].[IsEntryInFactTable]
	@thisRid int,
	@thisLid int,
	@thisPid int
	AS
	BEGIN
	SET NOCOUNT ON;
    	select count(*) from review_phrase_topic
    	WHERE rid = @thisRid and
		      lineid = @thisLid and
			  pid = @thisPid
	END
GO

/***************************************/
/*       IsVendorProductLinked         */
/***************************************/
/* NO import Function needed           */
/***************************************/

Create Procedure [dbo].[IsVendorProductLinked]
	@thisVendId int,
	@thisProdId int
	AS
	BEGIN
	SET NOCOUNT ON;
		select count(*) from vendor_product
		where vend_id = @thisVendId
		and prod_id = @thisProdId
	END
GO

/***************************/
/*       GetReview         */
/***************************/


CREATE PROCEDURE [dbo].[GetReview]
    @LastSentId int   
    AS
    BEGIN
  SET NOCOUNT ON;
    	SELECT *
    	FROM review_text
    	WHERE sentid > @LastSentId
		order by sentid
    END
	GO

/*** Records/Returns Last Imported Review Info After Processing ***/

Create Procedure [dbo].[RecordReviewsProcessed]
AS
	BEGIN
	   Insert into [review_process_control] (last_text_sent_id , last_import_processed_date)
	   select sentid , import_date
	   from [review_text]
	   where sentid = (select Max(sentid) from review_text)
	END
GO


Create Procedure [dbo].[GetProcessedInfo]
AS
	BEGIN
	   select last_text_sent_id , last_import_processed_date
	   from review_process_control
	   where last_text_sent_id = (select Max(last_text_sent_id) from review_process_control)
	END
GO

/***************************************/
/*    Procedures to support Web Page   */
/***************************************/


/*** Fills Vendor Checkbox ***/

/* drop procedure GetVendorIdNames
GO */

Create Procedure [dbo].[GetVendorIdNames]
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT vend_id, vendor_name, IsChecked
    	FROM review_vendor
		order by vend_id
	END
GO

/*** Fills Product Checkbox ***/

/* drop procedure GetProductNameForId
GO */

Create Procedure [dbo].[GetProductIdNames]
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT prod_id,prod_name,IsChecked 
    	FROM review_product
		order by prod_id
	END
GO

/* drop procedure GetPhraseKeysForProductName
GO */

Create Procedure [dbo].[GetPhraseKeysForProductName]
@prodName nvarchar(256)
AS 
BEGIN
  Declare @prodID int
  Set @prodID = (select prod_id 
   from review_product 
    where prod_name = @prodName)

  select rid, lineid, pid, prod_id
  from review_phrase_topic
  where prod_id = @prodID
END

GO

/* drop procedure GetHighCountPhrases
GO */

CREATE PROCEDURE [dbo].[GetHighCountPhrases]
 @vend_id int,
 @prod_id int
 AS
 BEGIN

	SET rowcount 50
	select revid, lineid, (rev_sentiment * 100) as rev_sentiment100 , rev_text
	into #tempHighReviewList
	from review_text
	where vend_id = @vend_id
	and prod_id = @prod_id
	order by rev_sentiment desc, revid, lineid

	SET rowcount 50
	SET NOCOUNT ON;
    	select distinct p.p_count, p.pid, p.p_text
		into #tempHighPhraseList
		from Review_phrase_topic f
		JOIN #tempHighReviewList as t
		On f.rid = t.revid
		and f.lineid = t.lineid 
		JOIN review_phrase as p
		on f.pid = p.pid
		order by p.p_count desc

		select p_count, pid, p_text
		from #tempHighPhraseList
		order by p_text asc
 END
 GO

 /* drop procedure GetTopPositivePhrases
GO */

  CREATE PROCEDURE [dbo].[GetTopPositivePhrases]
 @vend_id int,
 @prod_id int
 AS
 BEGIN

	SET rowcount 50
	select revid, lineid, (rev_sentiment * 100) as rev_sentiment100 , rev_text
	into #tempTopReviewList
	from review_text
	where vend_id = @vend_id
	and prod_id = @prod_id
	and rev_sentiment > .75
	order by rev_sentiment desc, revid, lineid

	SET rowcount 50
	SET NOCOUNT ON;
    	select distinct p.p_sentiment100, f.pid, p.p_text
		into #tempTopPhraseList
		from Review_phrase_topic f
		JOIN #tempTopReviewList as t
		On f.rid = t.revid
		and f.lineid = t.lineid 
		JOIN review_phrase as p
		on f.pid = p.pid
		order by p.p_sentiment100 desc

		select distinct p_sentiment100, pid, p_text
		from #tempTopPhraseList
		order by p_text asc
 END
GO


/* drop procedure GetTopNegativePhrases
GO */

 CREATE PROCEDURE [dbo].[GetTopNegativePhrases]
 @vend_id int,
 @prod_id int
 AS
 BEGIN
 
	SET rowcount 50
	select revid, lineid, (rev_sentiment * 100) as rev_sentiment100 , rev_text
	into #tempNegReviewList
	from review_text
	where vend_id = @vend_id
	and prod_id = @prod_id
	and rev_sentiment < .37
	order by rev_sentiment asc, revid, lineid

	SET rowcount 50
	SET NOCOUNT ON;
    	select distinct p.p_sentiment100, f.pid, p.p_text
		into #tempNegPhraseList
		from Review_phrase_topic f
		JOIN #tempNegReviewList as t
		On f.rid = t.revid
		and f.lineid = t.lineid 
		JOIN review_phrase as p
		on f.pid = p.pid
		order by p.p_sentiment100 asc

		select distinct p_sentiment100, pid, p_text
		from #tempNegPhraseList
		order by p_text asc
 END
GO

/* drop procedure GetVendProdSentiment
GO */

 CREATE PROCEDURE [dbo].[GetVendProdSentiment]
 @vend_id int,
 @prod_id int
 AS
 BEGIN
  Select avg(f.rev_sentiment100) 
	from review_phrase_topic f
	JOIN review_phrase as p
	on f.pid = p.pid
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
  END
 GO

/* drop procedure GetVendProdPhraseSentiment
GO */

 CREATE PROCEDURE [dbo].[GetVendProdPhraseSentiment]
 @vend_id int,
 @prod_id int,
 @phrase nvarchar(256)
 AS
 BEGIN
  Select avg(f.rev_sentiment100) 
	from review_phrase_topic f
	JOIN review_phrase as p
	on f.pid = p.pid
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
	and p.p_text = @phrase
  END
 GO

 /* drop procedure GetReviewTextforVendProd
GO */

 CREATE PROCEDURE [dbo].[GetReviewTextforVendProd]
 @vend_id int,
 @prod_id int
 AS
 BEGIN
  Select distinct rev_text 
	from review_phrase_topic f
	JOIN review_phrase as p
	on f.pid = p.pid
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
  END
 GO

 /* drop procedure GetReviewTextforVendProdPhrase
GO */

 CREATE PROCEDURE [dbo].[GetReviewTextforVendProdPhrase]
 @vend_id int,
 @prod_id int,
 @phrase nvarchar(256)
 AS
 BEGIN
  Select distinct rev_text 
	from review_phrase_topic f
	JOIN review_phrase as p
	on f.pid = p.pid
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
	and p.p_text = @phrase
  END
 GO

 /* drop procedure GetPositiveReviewTextforVendProd */

 CREATE PROCEDURE [dbo].[GetPositiveReviewTextforVendProd]
 @vend_id int,
 @prod_id int
 AS
 BEGIN
   SET rowcount 50
   Select distinct rev_text, rev_sentiment100 
	 from review_phrase_topic f
	 JOIN review_phrase as p
	 on f.pid = p.pid
	 where f.vend_id = @vend_id
	 and f.prod_id = @prod_id
	 and rev_sentiment100 > 75
	 order by rev_sentiment100 desc
  END
GO

/* drop procedure GetPositiveReviewTextforVendProdPid */

CREATE PROCEDURE [dbo].[GetPositiveReviewTextforVendProdPid]
 @vend_id int,
 @prod_id int,
 @pid int
 AS
 BEGIN
 SET rowcount 50
  Select distinct rev_text, rev_sentiment100 
	from review_phrase_topic f
	JOIN review_phrase as p
	on f.pid = p.pid
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
	and p.pid = @pid
	and rev_sentiment100 > 75
  END
GO

/* drop procedure GetNegativeReviewTextforVendProd */

CREATE PROCEDURE [dbo].[GetNegativeReviewTextforVendProd]
 @vend_id int,
 @prod_id int
 AS
 BEGIN
   SET rowcount 50
   Select distinct rev_text, rev_sentiment100 
	 from review_phrase_topic f
	 JOIN review_phrase as p
	 on f.pid = p.pid
	 where f.vend_id = @vend_id
	 and f.prod_id = @prod_id
	 and rev_sentiment100 < 37
	 order by rev_sentiment100 asc
  END
GO

/* drop procedure GetNegativeReviewTextforVendProdPid 
GO  */

CREATE PROCEDURE [dbo].[GetNegativeReviewTextforVendProdPid]
 @vend_id int,
 @prod_id int,
 @pid int
 AS
 BEGIN
 SET rowcount 50
  Select distinct rev_text, rev_sentiment100 
	from review_phrase_topic f
	JOIN review_phrase as p
	on f.pid = p.pid
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
	and p.pid = @pid
	and rev_sentiment100 < 37
  END
GO

/* drop procedure GetHighCountReviewTextforVendProd 
GO  */

CREATE PROCEDURE [dbo].[GetHighCountReviewTextforVendProd]
 @vend_id int,
 @prod_id int
 AS
 BEGIN
   SET rowcount 50
   Select distinct rev_text, rev_sentiment100, p.p_count
	 from review_phrase_topic f
	 JOIN review_phrase as p
	 on f.pid = p.pid
	 where f.vend_id = @vend_id
	 and f.prod_id = @prod_id
	 order by p.p_count desc
  END
GO

/* drop procedure GetReviewTextforVendProdPid */

CREATE PROCEDURE [dbo].[GetReviewTextforVendProdPid]
 @vend_id int,
 @prod_id int,
 @pid int
 AS
 BEGIN
 SET rowcount 50
  Select distinct rev_text, rev_sentiment100 
	from review_phrase_topic f
	JOIN review_phrase as p
	on f.pid = p.pid
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
	and p.pid = @pid
	order by rev_sentiment100 desc
  END
GO

/* NEW Power BI Replacement Stored Procedures */

/* DROP procedure GetReviewsforVendProd */

CREATE PROCEDURE [dbo].[GetReviewsforVendProd]
 @vend_id int,
 @prod_id int
 AS
 BEGIN
  Select distinct f.rid, f.lineid,f.rev_text 
	from review_phrase_topic f
	where f.vend_id = @vend_id
	and f.prod_id = @prod_id
	group by f.rid, f.lineid, f.rev_text 
	order by f.rid asc, f.lineid asc
  END
 GO

/* 
    exec GetReviewsforVendProd @vend_id = 2, @prod_id = 1
    go
*/


/* DROP procedure GetAvgVendorSiteRankingsBetweenDates*/


CREATE PROCEDURE [dbo].[GetAvgVendorSiteRankingsBetweenDates]
 @startDate datetime = '01/01/22',
 @endDate datetime = NULL
 AS
 BEGIN
	if (@endDate IS NOT NULL)
		select review_vendor.vendor_name, avg(vendor_ranking._in_10) as 'global_in_50000' , avg(vendor_ranking.us_in_10000) as 'us_in_10000'
		from [dbo].[vendor_ranking], [dbo].[review_vendor]
		where ranking_date >= @startDate
		and ranking_date <= @endDate
		and vendor_ranking.vend_id = review_vendor.vend_id
		group by vendor_ranking.vend_id, review_vendor.vendor_name
		order by vendor_ranking.vend_id asc, review_vendor.vendor_name
  END
GO

/*
	exec GetAvgVendorSiteRankingsBetweenDates @startDate = '02/01/22', @endDate = '03/01/22'
	go
*/

/*
	drop procedure GetDeltaVendorSiteRankingsBetweenDates
	go
*/

CREATE PROCEDURE [dbo].[GetDeltaVendorSiteRankingsBetweenDates]
 @startDate datetime = '01/01/22',
 @endDate datetime = NULL
 AS
 BEGIN
	if (@endDate IS NOT NULL)
		select review_vendor.vendor_name, avg(vendor_ranking.global_delta) as ranking_delta
		from [dbo].[vendor_ranking], [dbo].[review_vendor]
		where ranking_date >= @startDate
		and ranking_date <= @endDate
		and vendor_ranking.vend_id = review_vendor.vend_id
		group by vendor_ranking.vend_id, review_vendor.vendor_name
		order by vendor_ranking.vend_id asc, review_vendor.vendor_name
  END
GO

/*
	exec GetDeltaVendorSiteRankingsBetweenDates @startDate = '01/01/22', @endDate = '05/31/22'
	go
*/

/* drop procedure GetAvgVendorSiteRatingsBetweenDates */

CREATE PROCEDURE [dbo].[GetAvgVendorSiteRatingsBetweenDates]
 @startDate datetime = '01/01/22',
 @endDate datetime = NULL
 AS
 BEGIN
	if (@endDate IS NOT NULL)
		select review_vendor.vendor_name, round(avg(vendor_rating.vendor_sentiment), 2) as vendor_satisfaction
		from [dbo].[vendor_rating], [dbo].[review_vendor]
		where rating_date >= @startDate
		and rating_date <= @endDate
		and vendor_rating.vend_id = review_vendor.vend_id
		group by vendor_rating.vend_id, review_vendor.vendor_name
		/* order by vendor_rating.vend_id asc, review_vendor.vendor_name */
		order by vendor_satisfaction desc
  END
GO

/*
	exec GetAvgVendorSiteRatingsBetweenDates @startDate = '01/01/2022', @endDate = '05/31/2022'
	GO
*/


/* drop procedure GetAvgProductSatisfactionBetweenDates */

CREATE PROCEDURE [dbo].[GetAvgProductSatisfactionBetweenDates]
 @startDate datetime = '01/01/22',
 @endDate datetime = NULL
 AS
 BEGIN
	if (@endDate IS NOT NULL)
		select review_vendor.vendor_name, round(avg(vendor_rating.product_sentiment), 2) as product_satisfaction
		from [dbo].[vendor_rating], [dbo].[review_vendor]
		where rating_date >= @startDate
		and rating_date <= @endDate
		and vendor_rating.vend_id = review_vendor.vend_id
		group by vendor_rating.vend_id, review_vendor.vendor_name
		/* order by vendor_rating.vend_id asc, review_vendor.vendor_name */
		order by product_satisfaction desc
  END
GO

/*
	exec GetAvgProductSatisfactionBetweenDates @startDate = '01/01/2022', @endDate = '05/31/2022'
	GO
*/

/* drop procedure GetAvgPriceSatisfactionBetweenDates */

CREATE PROCEDURE [dbo].[GetAvgPriceSatisfactionBetweenDates]
 @startDate datetime = '01/01/22',
 @endDate datetime = NULL
 AS
 BEGIN
	if (@endDate IS NOT NULL)
		select review_vendor.vendor_name, round(avg(vendor_rating.price_sentiment), 2) as price_satisfaction
		from [dbo].[vendor_rating], [dbo].[review_vendor]
		where rating_date >= @startDate
		and rating_date <= @endDate
		and vendor_rating.vend_id = review_vendor.vend_id
		group by vendor_rating.vend_id, review_vendor.vendor_name
		/* order by vendor_rating.vend_id asc, review_vendor.vendor_name */
		order by price_satisfaction desc
  END
GO

/*
	exec GetAvgPriceSatisfactionBetweenDates @startDate = '01/01/2022', @endDate = '05/31/2022'
	GO
*/

/* drop procedure GetAvgServiceSatisfactionBetweenDates */

CREATE PROCEDURE [dbo].[GetAvgServiceSatisfactionBetweenDates]
 @startDate datetime = '01/01/22',
 @endDate datetime = NULL
 AS
 BEGIN
	if (@endDate IS NOT NULL)
		select review_vendor.vendor_name, round(avg(vendor_rating.service_sentiment), 2) as service_satisfaction
		from [dbo].[vendor_rating], [dbo].[review_vendor]
		where rating_date >= @startDate
		and rating_date <= @endDate
		and vendor_rating.vend_id = review_vendor.vend_id
		group by vendor_rating.vend_id, review_vendor.vendor_name
		/* order by vendor_rating.vend_id asc, review_vendor.vendor_name */
		order by service_satisfaction desc
  END
GO

/*
	exec GetAvgServiceSatisfactionBetweenDates @startDate = '01/01/2022', @endDate = '05/31/2022'
	GO
*/

/*  drop procedure GetAvgProductSentiment100RatingsforVendor */

create procedure dbo.GetAvgProductSentiment100RatingsforVendor @vendNum int, @prodNum1 int = null, @prodNum2 int = null, @prodNum3 int = null, @prodNum4 int = null, @prodNum5 int = null, @prodNum6 int = null, @prodNum7 int = null
AS
select review_phrase_topic.vendor_name, review_phrase_topic.prod_name, round(avg(rev_sentiment100), 2) as 'sentiment_rating'
from dbo.review_phrase_topic
where review_phrase_topic.vend_id = @vendNum
and prod_id IN (@prodNum1, @prodNum2, @prodNum3, @prodNum4, @prodNum5, @prodNum6, @prodNum7)
group by prod_name, vendor_name
order by sentiment_rating desc
go

/*
exec GetAvgProductSentiment100RatingsforVendor @vendNum = 2, @prodNum1 = 1, @prodNum2 = 2, @prodNum3 = 3, @prodNum4 = 4, @prodNum5 = 5, @prodNum6 = 6, @prodNum7 = 13
go
*/

/*  drop procedure GetAvgProdQualityRatingsforVendor */

create procedure dbo.GetAvgProdQualityRatingsforVendor @vendNum int, @prodNum1 int = null, @prodNum2 int = null, @prodNum3 int = null, @prodNum4 int = null, @prodNum5 int = null, @prodNum6 int = null, @prodNum7 int = null
AS
select review_phrase_topic.vendor_name, review_phrase_topic.prod_name, round(avg(prod_quality), 2) as 'quality_rating'
from dbo.review_phrase_topic
where review_phrase_topic.vend_id = @vendNum
and prod_id IN (@prodNum1, @prodNum2, @prodNum3, @prodNum4, @prodNum5, @prodNum6, @prodNum7)
group by prod_name, vendor_name
order by quality_rating desc
go

/*
exec GetAvgProdQualityRatingsforVendor @vendNum = 2, @prodNum1 = 1, @prodNum2 = 2, @prodNum3 = 3, @prodNum4 = 4, @prodNum5 = 5, @prodNum6 = 6, @prodNum7 = 13
go
*/

/*  drop procedure GetAvgProdComfortRatingsforVendor */

create procedure dbo.GetAvgProdComfortRatingsforVendor @vendNum int, @prodNum1 int = null, @prodNum2 int = null, @prodNum3 int = null, @prodNum4 int = null, @prodNum5 int = null, @prodNum6 int = null, @prodNum7 int = null
AS
select review_phrase_topic.vendor_name, review_phrase_topic.prod_name, round(avg(prod_comfort), 2) as 'comfort_rating'
from dbo.review_phrase_topic
where review_phrase_topic.vend_id = @vendNum
and prod_id IN (@prodNum1, @prodNum2, @prodNum3, @prodNum4, @prodNum5, @prodNum6, @prodNum7)
group by prod_name, vendor_name
order by comfort_rating desc
go
/*
exec GetAvgProdComfortRatingsforVendor @vendNum = 2, @prodNum1 = 1, @prodNum2 = 2, @prodNum3 = 3, @prodNum4 = 4, @prodNum5 = 5, @prodNum6 = 6, @prodNum7 = 13
go 
*/

/*  drop procedure GetAvgProdValueRatingsforVendor */

create procedure dbo.GetAvgProdValueRatingsforVendor @vendNum int, @prodNum1 int = null, @prodNum2 int = null, @prodNum3 int = null, @prodNum4 int = null, @prodNum5 int = null, @prodNum6 int = null, @prodNum7 int = null
AS
select review_phrase_topic.vendor_name, review_phrase_topic.prod_name, round(avg(prod_value), 2) as 'value_rating'
from dbo.review_phrase_topic
where review_phrase_topic.vend_id = @vendNum
and prod_id IN (@prodNum1, @prodNum2, @prodNum3, @prodNum4, @prodNum5, @prodNum6, @prodNum7)
group by prod_name, vendor_name
order by value_rating desc
go

/*
exec GetAvgProdValueRatingsforVendor @vendNum = 2, @prodNum1 = 1, @prodNum2 = 2, @prodNum3 = 3, @prodNum4 = 4, @prodNum5 = 5, @prodNum6 = 6, @prodNum7 = 13
go 
*/

/* Database Maintenance Stored Procedures */

/* drop procedure MakeNewProductName 
GO   */

CREATE PROCEDURE [dbo].[MakeNewProductName]
 @oldName nvarchar(256),
 @newName nvarchar(256)
 AS
 BEGIN Transaction
     
	 update review_phrase_topic
	 set prod_name = @newName
	 where prod_id IN
           (select prod_id 
           from review_product
		   where @oldName = prod_name)
     
	 update review_product
	 set prod_name = @newName
	 where prod_id IN
	       (select prod_id 
           from review_product
		   where @oldName = prod_name)
  Commit;
GO

/* drop procedure ChangeWebsiteString 
GO   */

CREATE PROCEDURE [dbo].[ChangeWebsiteString]
 @vendorName nvarchar(100),
 @productName nvarchar(256),
 @newWebString nvarchar(256)
 AS
 BEGIN Transaction
     
	 update vendor_product
	 set webProductString = @newWebString
	 where prod_id IN
           (select prod_id 
           from review_product
		   where prod_name = @productName)
		   and vend_id IN
		   ( select vend_id
		   from review_vendor
		   where vendor_name = @vendorName)
     
  Commit;

GO

/*  drop procedure FullyRemoveExistingProduct
GO  */

Create Procedure FullyRemoveExistingProduct
@prodName nvarchar(256)
AS 
BEGIN
  Declare @prodid int  -- Product ID
  Set @prodid = (select prod_id 
   from review_product 
    where prod_name = @prodName)

  Declare @rid int     -- Review ID
  Declare @lineid int  -- Line ID
  Declare @pid int     -- Phrase ID
  
  DECLARE Key_Phrase_cursor CURSOR FOR
  select rid, lineid, pid
  from review_phrase_topic
  where prod_id = @prodid

  OPEN Key_Phrase_cursor�� 
  FETCH NEXT FROM Key_Phrase_cursor INTO @rid, @lineid, @pid

  WHILE @@FETCH_STATUS = 0�� 
	BEGIN�
	  Declare @pCount int
	  set @pCount = 
	  (SELECT p_count
	  FROM review_phrase p
	  where pid = @pid)

	  if (@pCount < 2) -- Last Join for this phrase, just delete it.
	  BEGIN
	    delete from review_phrase 
		where pid = @pid

		delete from review_phrase_topic
		where pid = @pid
	  END
	  ELSE  -- Remove Join, update the existing sentiments and count.
	    BEGIN
	      declare @current_p_sentiment real
		  SET @current_p_sentiment = (select p_sentiment from review_phrase where pid = @pid)
		  declare @current_rev_sentiment real
		  SET @current_rev_sentiment = (select rev_sentiment from review_phrase_topic where rid = @rid and lineid = @lineid and pid = @pid)

		  update review_phrase 
		  set p_sentiment = (((@current_p_sentiment * @pCount) - @current_rev_sentiment) / (p_count -1)) , 
	      p_count = @pCount -1 where pid = @pid

		  delete from review_phrase_topic
		  where rid = @rid
		  and lineid = @lineid
		  and pid = @pid
	    END
	-- Get another Key Phrase Join
	FETCH NEXT FROM Key_Phrase_cursor INTO @rid, @lineid, @pid
	END -- End of While Loop

	CLOSE Key_Phrase_cursor�� 
	DEALLOCATE Key_Phrase_cursor 
	-- All Joins Remocved, now remove the Product and its Reviews.
	DELETE from review_text where prod_id = @prodid    -- Delete Reviews
	DELETE from vendor_product where prod_id = @prodid -- Delete Vendor Joins
    DELETE from review_product where prod_id = @prodid -- Delete Product
	
END

GO

/****************************************************************************************/
/*                       Vendor Rating Stored Procedures                                */
/****************************************************************************************/

/***************************************/
/*        GetLikeVendTexts           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> vend_text             */
/***************************************/

/* Drop Procedure GetLikeVendTexts
GO */

Create Procedure [dbo].[GetLikeVendTexts]
	@thisPhrase nvarchar(100),
	@lastSentId int
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT *
    	FROM vend_text
    	WHERE vrev_text Like CONCAT('%',@thisPhrase,'%')
		AND vsentid > = @lastSentId;
	END
GO

/***************************************/
/*       GetMatchingVendPhrase         */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> vend_phrase           */
/***************************************/

/* Drop Procedure GetMatchingVendPhrase
GO */

Create Procedure GetMatchingVendPhrase
    @thisVendId int,
	@thisPhrase nvarchar(100)
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT p.vpid phraseId, count(vrf.vrev_sentiment100) size
    	FROM vend_phrase p, vend_review_fact vrf
    	WHERE p.vp_text = @thisPhrase
		and p.vpid = vrf.vpid
		and vrf.vend_id = @thisVendId
	group by p.vpid
	END
GO

/***************************************/
/*      DoVendorStringsMatch          */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> vendor_product        */
/***************************************/

CREATE PROCEDURE [dbo].[DoVendorStringsMatch]
	@vendNum int,
	@vendString nvarchar(256)
	As
	  Begin
		SET NOCOUNT ON
		SELECT count(*) 
		from vend_text vt
		where vt.vend_id = @vendNum
		and vt.vrev_text = @vendString
	  END
GO

/***************************************/
/*        GetMoreVendTexts           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> vend_text           */
/***************************************/

/* Drop Procedure GetMoreVendTexts
GO */

CREATE PROCEDURE GetMoreVendTexts 
    @LastSentId int   
    AS
    BEGIN
  SET NOCOUNT ON;
    	SELECT *
    	FROM vend_text
    	WHERE vsentid > @LastSentId
    END
GO

/***************************************/
/*         GetRevidForSentid           */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Scalars -> int(32)                */
/***************************************/

/* Drop Procedure GetRevidForSentid
GO */

Create Procedure [dbo].[GetVrevidForSentid]
	@thisSentId int
	AS
	BEGIN
	SET NOCOUNT ON;
    	SELECT vrevid 
    	FROM vend_text
    	WHERE vsentid = @thisSentId;
	END
GO

/***************************************/
/*        PostVendReviewSentiment          */
/***************************************/
/* NO import Function needed           */
/***************************************/

/* Drop Procedure PostVendReviewSentiment
GO */

Create Procedure PostVendReviewSentiment
	@thisRevId int,
	@thisSentiment float
	AS
	BEGIN
	SET NOCOUNT ON;
    	Update vend_text
    	set vrev_sentiment = @thisSentiment
    	WHERE vrevid = @thisRevId;
	END
GO

/***************************************/
/*        IsEntryInVendFactTable           */
/***************************************/
/* NO import Function needed           */
/***************************************/

Create Procedure [dbo].[IsEntryInVendFactTable]
	@thisRid int,
	@thisLid int,
	@thisPid int
	AS
	BEGIN
	SET NOCOUNT ON;
    	select count(*) from vend_review_fact
    	WHERE vrid = @thisRid and
		      vlineid = @thisLid and
			  vpid = @thisPid
	END
GO

/***************************************/
/*           IsVendReviewSaved             */
/***************************************/
/*   Browse Model: Stored Procedures   */
/*   Add Function Import               */
/*   Entities -> vend_text             */
/***************************************/

/* Drop Procedure IsVendReviewSaved
GO */

CREATE PROCEDURE [dbo].[IsVendReviewSaved]
	@vendNum int,
	@firstLine nvarchar(50)
	As
	  Begin
		SET NOCOUNT ON
		SELECT count(*) FROM vend_text
		WHERE vend_id = @vendNum
		and vlineid = 1
		AND SUBSTRING(vrev_text,0, 50) = @firstLine
	  END
GO



