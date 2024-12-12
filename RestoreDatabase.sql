/*
 *	Vantage
 */

use master;


--	Switch the database to single user mode to make sure noone else uses it while we restore it.
ALTER DATABASE b944p SET SINGLE_USER WITH ROLLBACK AFTER 20;

--	Restore the database
RESTORE DATABASE b944p FROM DISK='C:\Impress\b944p\ImpressData.bak'
WITH REPLACE,
MOVE 'Impress' TO 'C:\Impress\MSSQL\data\b944p.mdf',
MOVE 'Impress_log' TO 'C:\Impress\MSSQL\data\b944p_log.ldf';
GO

--	Clear out the private information (ie.  Merchant Service, E-Mails, EDI, etc.)
USE b944p;
declare @mailAddr varchar(max) = 'manoj.pulapaiahgari@aptean.com';

update MSETUP set MAINSETUP_APPSERVERNAME = 'APT04-D6H88D3', MAINSETUP_USEDESIGNWAREHOUSE = 0, MAINSETUP_LOOKUPBUTTONIMAGE = 0, MAINSETUP_BUTTONIMAGE = '';
update MSETUP set MAINSETUP_TESTVERSION = (select MAX(ARSETUP_NAME) from ARSETUP)
update ARSETUP set ARSETUP_MERCHANTLOGIN = '', ARSETUP_MERCHANTCERTIFICATE = '', ARSETUP_MERCHANTOPTION1 = 0x, ARSETUP_MERCHANTOPTION2 = 0x, ARSETUP_MERCHANTOPTION3 = 0x,
		ARSETUP_MERCHANTOPTION4 = 0x, ARSETUP_MERCHANTOPTION5 = 0x, ARSETUP_MERCHANTOPTION6 = 0x, ARSETUP_MERCHANTOPTION7 = 0x, ARSETUP_MERCHANTOPTION8 = 0x,
		ARSETUP_MERCHANTOPTION9 = 0x, ARSETUP_MERCHANTOPTION10 = 0x, ARSETUP_MERCHANTOPTION11 = 0x, ARSETUP_MERCHANTOPTION12 = 0x,
		ARSETUP_EDIEMAIL=@mailAddr, ARSETUP_EDIREPLACEMENTEMAIL=@mailAddr;
update VENDOR set VENDOR_DISTRIBUTORINTERFACE = '', VENDOR_ACCOUNTNBR = 0x, VENDOR_PASSWORD = 0x
update EDIVAN set EDIVAN_FTPSERVER = '', EDIVAN_FTPLOGIN = 0x, EDIVAN_FTPPASSWORD = 0x

-- Make sure we don't accidentally e-mail customers!
update CUSTSHIP set CUSTSHIP_EMAIL = @mailAddr where CUSTSHIP_EMAIL <> ''
update CUSTOMER set CUSTOMER_EMAIL = @mailAddr where CUSTOMER_EMAIL <> ''
update INVOICE set INVOICE_BUYEREMAIL = @mailAddr where INVOICE_BUYEREMAIL <> ''
update SORDER set SORDER_BUYEREMAIL = @mailAddr where SORDER_BUYEREMAIL <> ''
delete  FROM PREFEREN where PREFERENCE_KEY = 'EmailNotifications'

GO

-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE b944p SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (Impress_Log, 1);
GO
ALTER DATABASE b944p SET RECOVERY FULL;

-- Make the database multi-user again
ALTER DATABASE b944p SET MULTI_USER;
GO






/*
 *	Vantage
 */

use master;
--	Switch the database to single user mode to make sure noone else uses it while we restore it.
ALTER DATABASE Vantage SET SINGLE_USER WITH ROLLBACK AFTER 20;

--	Restore the database
RESTORE DATABASE Vantage FROM DISK='C:\Impress\DEMO\ImpressData.bak'
WITH REPLACE,
MOVE 'Impress' TO 'C:\Users\mpulapaiahgari\Documents\MYSQL\DATA\Vantage.mdf',
MOVE 'Impress_log' TO 'C:\Users\mpulapaiahgari\Documents\MYSQL\DATA\Vantage_log.ldf';
GO

--	Clear out the private information (ie.  Merchant Service, E-Mails, EDI, etc.)
USE Vantage;
update MSETUP set MAINSETUP_TESTVERSION = 'Vantage', MAINSETUP_APPSERVERNAME = 'APT04-D6H88D3', MAINSETUP_USEDESIGNWAREHOUSE = 0, MAINSETUP_LOOKUPBUTTONIMAGE = 0, MAINSETUP_BUTTONIMAGE = '';
update ARSETUP set ARSETUP_MERCHANTLOGIN = '', ARSETUP_MERCHANTCERTIFICATE = '', ARSETUP_MERCHANTOPTION1 = 0x, ARSETUP_MERCHANTOPTION2 = 0x, ARSETUP_MERCHANTOPTION3 = 0x,
		ARSETUP_MERCHANTOPTION4 = 0x, ARSETUP_MERCHANTOPTION5 = 0x, ARSETUP_MERCHANTOPTION6 = 0x, ARSETUP_MERCHANTOPTION7 = 0x, ARSETUP_MERCHANTOPTION8 = 0x,
		ARSETUP_MERCHANTOPTION9 = 0x, ARSETUP_MERCHANTOPTION10 = 0x, ARSETUP_MERCHANTOPTION11 = 0x, ARSETUP_MERCHANTOPTION12 = 0x;
update VENDOR set VENDOR_DISTRIBUTORINTERFACE = '', VENDOR_ACCOUNTNBR = 0x, VENDOR_PASSWORD = 0x
update EDIVAN set EDIVAN_FTPSERVER = '', EDIVAN_FTPLOGIN = 0x, EDIVAN_FTPPASSWORD = 0x
GO

-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE Vantage SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (Impress_Log, 1);
GO
ALTER DATABASE Vantage SET RECOVERY FULL;

-- Make the database multi-user again
ALTER DATABASE Vantage SET MULTI_USER;
GO


-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

/*
 *	impress (precise)
 */

use master;
--	Switch the database to single user mode to make sure noone else uses it while we restore it.
ALTER DATABASE Impress SET SINGLE_USER WITH ROLLBACK AFTER 20;

--	Restore the database
RESTORE DATABASE Impress FROM DISK='C:\Impress\impressDemo\ImpressData.bak'
WITH REPLACE,
MOVE 'Impress' TO 'C:\Impress\SQL\DATA\ImpressDemo.mdf',
MOVE 'Impress_log' TO 'C:\Impress\SQL\DATA\ImpressDemo_log.ldf';
GO

--	Clear out the private information (ie.  Merchant Service, E-Mails, EDI, etc.)
USE Impress;
update MSETUP set MAINSETUP_TESTVERSION = 'Impress', MAINSETUP_APPSERVERNAME = 'APT04-D6H88D3', MAINSETUP_USEDESIGNWAREHOUSE = 0, MAINSETUP_LOOKUPBUTTONIMAGE = 0, MAINSETUP_BUTTONIMAGE = '';
update ARSETUP set ARSETUP_MERCHANTLOGIN = '', ARSETUP_MERCHANTCERTIFICATE = '', ARSETUP_MERCHANTOPTION1 = 0x, ARSETUP_MERCHANTOPTION2 = 0x, ARSETUP_MERCHANTOPTION3 = 0x,
		ARSETUP_MERCHANTOPTION4 = 0x, ARSETUP_MERCHANTOPTION5 = 0x, ARSETUP_MERCHANTOPTION6 = 0x, ARSETUP_MERCHANTOPTION7 = 0x, ARSETUP_MERCHANTOPTION8 = 0x,
		ARSETUP_MERCHANTOPTION9 = 0x, ARSETUP_MERCHANTOPTION10 = 0x, ARSETUP_MERCHANTOPTION11 = 0x, ARSETUP_MERCHANTOPTION12 = 0x;
-- update VENDOR set VENDOR_DISTRIBUTORINTERFACE = '', VENDOR_ACCOUNTNBR = 0x, VENDOR_PASSWORD = 0x
update EDIVAN set EDIVAN_FTPSERVER = '', EDIVAN_FTPLOGIN = 0x, EDIVAN_FTPPASSWORD = 0x
GO

-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE Impress SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (Impress_Log, 1);
GO
ALTER DATABASE Impress SET RECOVERY FULL;

-- Make the database multi-user again
ALTER DATABASE Impress SET MULTI_USER;
GO


-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

/*
 *	SOP
 */

use master;
--	Switch the database to single user mode to make sure noone else uses it while we restore it.
ALTER DATABASE ImpressStoked SET SINGLE_USER WITH ROLLBACK AFTER 20;

--	Restore the database
RESTORE DATABASE ImpressStoked FROM DISK='C:\Impress\STOKED\ImpressData.bak'
WITH REPLACE,
MOVE 'Impress' TO 'C:\Impress\SQL\DATA\ImpressStoked.mdf',
MOVE 'Impress_log' TO 'C:\Impress\SQL\DATA\ImpressStoked_log.ldf';
GO

--	Clear out the private information (ie.  Merchant Service, E-Mails, EDI, etc.)
USE ImpressStoked;
update MSETUP set MAINSETUP_TESTVERSION = 'ImpressStoked', MAINSETUP_APPSERVERNAME = 'APT04-D6H88D3', MAINSETUP_USEDESIGNWAREHOUSE = 0, MAINSETUP_LOOKUPBUTTONIMAGE = 0, MAINSETUP_BUTTONIMAGE = '';
update ARSETUP set ARSETUP_MERCHANTLOGIN = '', ARSETUP_MERCHANTCERTIFICATE = '', ARSETUP_MERCHANTOPTION1 = 0x, ARSETUP_MERCHANTOPTION2 = 0x, ARSETUP_MERCHANTOPTION3 = 0x,
		ARSETUP_MERCHANTOPTION4 = 0x, ARSETUP_MERCHANTOPTION5 = 0x, ARSETUP_MERCHANTOPTION6 = 0x, ARSETUP_MERCHANTOPTION7 = 0x, ARSETUP_MERCHANTOPTION8 = 0x,
		ARSETUP_MERCHANTOPTION9 = 0x, ARSETUP_MERCHANTOPTION10 = 0x, ARSETUP_MERCHANTOPTION11 = 0x, ARSETUP_MERCHANTOPTION12 = 0x;
-- update VENDOR set VENDOR_DISTRIBUTORINTERFACE = '', VENDOR_ACCOUNTNBR = 0x, VENDOR_PASSWORD = 0x
update EDIVAN set EDIVAN_FTPSERVER = '', EDIVAN_FTPLOGIN = 0x, EDIVAN_FTPPASSWORD = 0x
GO

-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE ImpressStoked SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (Impress_Log, 1);
GO
ALTER DATABASE ImpressStoked SET RECOVERY FULL;

-- Make the database multi-user again
ALTER DATABASE ImpressStoked SET MULTI_USER;
GO


-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------



/*
 *	costal
 */

use master;
--	Switch the database to single user mode to make sure noone else uses it while we restore it.
ALTER DATABASE costal SET SINGLE_USER WITH ROLLBACK AFTER 20;

--	Restore the database
RESTORE DATABASE costal FROM DISK='C:\Impress\costal\ImpressData.bak'
WITH REPLACE,
MOVE 'Impress' TO 'C:\Impress\SQL\DATA\costal.mdf',
MOVE 'Impress_log' TO 'C:\Impress\SQL\DATA\costal_log.ldf';
GO

--	Clear out the private information (ie.  Merchant Service, E-Mails, EDI, etc.)
USE costal;
update MSETUP set MAINSETUP_TESTVERSION = 'costal', MAINSETUP_APPSERVERNAME = 'APT04-D6H88D3', MAINSETUP_USEDESIGNWAREHOUSE = 0, MAINSETUP_LOOKUPBUTTONIMAGE = 0, MAINSETUP_BUTTONIMAGE = '';
update ARSETUP set ARSETUP_MERCHANTLOGIN = '', ARSETUP_MERCHANTCERTIFICATE = '', ARSETUP_MERCHANTOPTION1 = 0x, ARSETUP_MERCHANTOPTION2 = 0x, ARSETUP_MERCHANTOPTION3 = 0x,
		ARSETUP_MERCHANTOPTION4 = 0x, ARSETUP_MERCHANTOPTION5 = 0x, ARSETUP_MERCHANTOPTION6 = 0x, ARSETUP_MERCHANTOPTION7 = 0x, ARSETUP_MERCHANTOPTION8 = 0x,
		ARSETUP_MERCHANTOPTION9 = 0x, ARSETUP_MERCHANTOPTION10 = 0x, ARSETUP_MERCHANTOPTION11 = 0x, ARSETUP_MERCHANTOPTION12 = 0x;
-- update VENDOR set VENDOR_DISTRIBUTORINTERFACE = '', VENDOR_ACCOUNTNBR = 0x, VENDOR_PASSWORD = 0x
update EDIVAN set EDIVAN_FTPSERVER = '', EDIVAN_FTPLOGIN = 0x, EDIVAN_FTPPASSWORD = 0x
GO

-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE costal SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (Impress_Log, 1);
GO
ALTER DATABASE costal SET RECOVERY FULL;

-- Make the database multi-user again
ALTER DATABASE costal SET MULTI_USER;
GO




-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------



/*
 */

use master;
--	Switch the database to single user mode to make sure noone else uses it while we restore it.
ALTER DATABASE b948sop SET SINGLE_USER WITH ROLLBACK AFTER 20;

--	Restore the database
RESTORE DATABASE b948sop FROM DISK='C:\Impress\b948sop\ImpressData.bak'
WITH REPLACE,
MOVE 'Impress' TO 'C:\Impress\SQL\DATA\b948sop.mdf',
MOVE 'Impress_log' TO 'C:\Impress\SQL\DATA\b948sop_log.ldf';
GO

--	Clear out the private information (ie.  Merchant Service, E-Mails, EDI, etc.)
USE b948sop;
update MSETUP set MAINSETUP_TESTVERSION = 'b948sop', MAINSETUP_APPSERVERNAME = 'APT04-D6H88D3', MAINSETUP_USEDESIGNWAREHOUSE = 0, MAINSETUP_LOOKUPBUTTONIMAGE = 0, MAINSETUP_BUTTONIMAGE = '';
update ARSETUP set ARSETUP_MERCHANTLOGIN = '', ARSETUP_MERCHANTCERTIFICATE = '', ARSETUP_MERCHANTOPTION1 = 0x, ARSETUP_MERCHANTOPTION2 = 0x, ARSETUP_MERCHANTOPTION3 = 0x,
		ARSETUP_MERCHANTOPTION4 = 0x, ARSETUP_MERCHANTOPTION5 = 0x, ARSETUP_MERCHANTOPTION6 = 0x, ARSETUP_MERCHANTOPTION7 = 0x, ARSETUP_MERCHANTOPTION8 = 0x,
		ARSETUP_MERCHANTOPTION9 = 0x, ARSETUP_MERCHANTOPTION10 = 0x, ARSETUP_MERCHANTOPTION11 = 0x, ARSETUP_MERCHANTOPTION12 = 0x;
 -- update VENDOR set VENDOR_DISTRIBUTORINTERFACE = '', VENDOR_ACCOUNTNBR = 0x, VENDOR_PASSWORD = 0x
update EDIVAN set EDIVAN_FTPSERVER = '', EDIVAN_FTPLOGIN = 0x, EDIVAN_FTPPASSWORD = 0x
GO

-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE b948sop SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (Impress_Log, 1);
GO
ALTER DATABASE b948sop SET RECOVERY FULL;

-- Make the database multi-user again
ALTER DATABASE b948sop SET MULTI_USER;
GO




update VENDOR set VENDOR_TRANSMITPOBUILDER = 0


use b948sop;

--	Uncomment this line to start fresh since 2021-8-20.  Once the data is removed
--	we know that any data appearing after this date is now from our QA test and
--	did not already exist before our corrections and QA
declare @cutOffDate datetime = '2021-8-20';
delete INBOUNDASN where INBOUNDASN_CREATED>=@cutOffDate

--	This query tells us which vendors we found and were able to successfully import ASN data for.
declare @cutOffDate datetime = '2021-8-20';
select distinct INBOUNDASN_VENDOR_CODE, VENDOR_NAME from INBOUNDASN
	left join vendor on INBOUNDASN_VENDOR_CODE = VENDOR_CODE
where INBOUNDASN_CREATED>=@cutOffDate

--	This query shows us all the ASN data that we were able to import since the cutoff date

select * from INBOUNDASN where INBOUNDASN_CREATED>=@cutOffDate

select * from INBOUNDASN where INBOUNDASN_VENDOR_CODE = 00102 order by INBOUNDASN_CREATED desc


select * from INBOUNDASN where INBOUNDASN_VENDOR_CODE = 00101 order by INBOUNDASN_CREATED desc
