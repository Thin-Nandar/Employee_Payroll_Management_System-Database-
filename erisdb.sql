-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 30, 2025 at 09:06 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `erisdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCompanies` ()   BEGIN
    SELECT * FROM tblcompany ORDER BY COMPANYID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCompanyWithJobs` (IN `company_id` INT)   BEGIN
    SELECT c.COMPANYNAME, c.COMPANYADDRESS, j.OCCUPATIONTITLE, j.SALARIES
    FROM tblcompany c
    INNER JOIN tbljob j ON c.COMPANYID = j.COMPANYID
    WHERE c.COMPANYID = company_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJobsByCompany` (IN `company_id` INT)   BEGIN
    SELECT * FROM tbljob WHERE COMPANYID = company_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblapplicants`
--

CREATE TABLE `tblapplicants` (
  `APPLICANTID` int(11) NOT NULL,
  `FNAME` varchar(90) NOT NULL,
  `LNAME` varchar(90) NOT NULL,
  `MNAME` varchar(90) NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `SEX` varchar(11) NOT NULL,
  `CIVILSTATUS` varchar(30) NOT NULL,
  `BIRTHDATE` date NOT NULL,
  `BIRTHPLACE` varchar(255) NOT NULL,
  `AGE` int(2) NOT NULL,
  `USERNAME` varchar(90) NOT NULL,
  `PASS` varchar(90) NOT NULL,
  `EMAILADDRESS` varchar(90) NOT NULL,
  `CONTACTNO` varchar(90) NOT NULL,
  `DEGREE` text NOT NULL,
  `APPLICANTPHOTO` varchar(255) NOT NULL,
  `NATIONALID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblapplicants`
--

INSERT INTO `tblapplicants` (`APPLICANTID`, `FNAME`, `LNAME`, `MNAME`, `ADDRESS`, `SEX`, `CIVILSTATUS`, `BIRTHDATE`, `BIRTHPLACE`, `AGE`, `USERNAME`, `PASS`, `EMAILADDRESS`, `CONTACTNO`, `DEGREE`, `APPLICANTPHOTO`, `NATIONALID`) VALUES
(2018013, 'Kim', 'Domingo', 'Enoe', 'Kab City', 'Female', 'none', '1991-01-01', 'Kab Citys', 27, 'kim', 'a6312121e15caec74845b7ba5af23330d52d4ac0', 'kim@y.com', '5415456', 'BSAC', 'photos/RobloxScreenShot20180406_203758793.png', ''),
(2018014, 'Jake', 'Zyrus', 'Ilmba', 'Kab City', 'Female', 'none', '1993-01-16', 'Kab City', 25, 'jake', 'c8d99c2f7cd5f432c163abcd422672b9f77550bb', 'jake@y.com', '14655623123123', 'BSIT', '', ''),
(2018015, 'Janry', 'Tan', 'Lim', 'brgy 1 Kab City', 'Female', 'Single', '1992-01-30', 'Kab City', 26, 'janry', '1dd4efc811372cd1efe855981a8863d10ddde1ca', 'jan@gmail.com', '0234234', 'BSIT', '', ''),
(2025016, 'blue', 'sky', 'company', 'yangon', 'Male', 'Single', '2000-10-31', 'mh', 24, 'Sky ', '0585ca05446a3a9e379ce7662cdaef0280cb8fcc', 'sky@gmail.com', '0987654567', 'undergraduate', '', ''),
(2025017, 'susu', 'san', 'myint', 'yangon', 'Female', 'Single', '2000-08-25', 'yangon', 24, '', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '', '09447588999', '', '', ''),
(2025018, 'susu', 'san', 'myint', 'yangon', 'Female', 'Single', '2000-08-25', 'yangon', 24, 'susu', 'b7b1ff20a8e1c018139d64cf5c4dc85a81c95d31', 'su@gmail.com', '09447588999', '', 'photos/Screenshot 2025-08-06 011700.png', ''),
(2025019, 'YAMIN', 'NWE', 'NWE', 'MDY', 'Female', 'Married', '2000-09-14', 'MDY', 24, 'yamin', '991882ba8114ea16e8ee6fd519d101ea2cfeb700', 'yamin@gmail.com', '0987654D321', 'BCsc', 'photos/Screenshot 2025-08-06 000601.png', ''),
(2025020, 'Updated', 'User', '', '', '', '', '0000-00-00', '', 0, '', '', 'test@example.com', '09123456789', '', '', '');

--
-- Triggers `tblapplicants`
--
DELIMITER $$
CREATE TRIGGER `after_applicant_delete` AFTER DELETE ON `tblapplicants` FOR EACH ROW BEGIN
    INSERT INTO tbl_audit_log (TABLE_NAME, ACTION_TYPE, RECORD_ID, OLD_DATA, USER_NAME)
    VALUES ('tblapplicants', 'DELETE', OLD.APPLICANTID,
            CONCAT('Deleted: ', OLD.FNAME, ' ', OLD.LNAME, ', Email: ', OLD.EMAILADDRESS), 
            CURRENT_USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_applicant_insert` AFTER INSERT ON `tblapplicants` FOR EACH ROW BEGIN
    INSERT INTO tbl_audit_log (TABLE_NAME, ACTION_TYPE, RECORD_ID, NEW_DATA, USER_NAME)
    VALUES ('tblapplicants', 'INSERT', NEW.APPLICANTID, 
            CONCAT('Name: ', NEW.FNAME, ' ', NEW.LNAME, ', Email: ', NEW.EMAILADDRESS), 
            CURRENT_USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_applicant_update` AFTER UPDATE ON `tblapplicants` FOR EACH ROW BEGIN
    INSERT INTO tbl_audit_log (TABLE_NAME, ACTION_TYPE, RECORD_ID, OLD_DATA, NEW_DATA, USER_NAME)
    VALUES ('tblapplicants', 'UPDATE', NEW.APPLICANTID,
            CONCAT('Old: ', OLD.FNAME, ' ', OLD.LNAME, ', Email: ', OLD.EMAILADDRESS),
            CONCAT('New: ', NEW.FNAME, ' ', NEW.LNAME, ', Email: ', NEW.EMAILADDRESS), 
            CURRENT_USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_applicant_delete` BEFORE DELETE ON `tblapplicants` FOR EACH ROW BEGIN
    DELETE FROM tbljobregistration WHERE APPLICANTID = OLD.APPLICANTID;
    DELETE FROM tblattachmentfile WHERE USERATTACHMENTID = OLD.APPLICANTID;
    DELETE FROM tblfeedback WHERE APPLICANTID = OLD.APPLICANTID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblattachmentfile`
--

CREATE TABLE `tblattachmentfile` (
  `ID` int(11) NOT NULL,
  `FILEID` varchar(30) DEFAULT NULL,
  `JOBID` int(11) NOT NULL,
  `FILE_NAME` varchar(90) NOT NULL,
  `FILE_LOCATION` varchar(255) NOT NULL,
  `USERATTACHMENTID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblattachmentfile`
--

INSERT INTO `tblattachmentfile` (`ID`, `FILEID`, `JOBID`, `FILE_NAME`, `FILE_LOCATION`, `USERATTACHMENTID`) VALUES
(2, '2147483647', 2, 'Resume', 'photos/27052018124027PLATENO FE95483.docx', 2018013),
(3, '20256912529', 2, 'Resume', 'photos/06082025025627Screenshot 2025-08-06 011700.png', 2025018),
(4, '20256912531', 2, 'Resume', 'photos/07082025111056Screenshot 2025-08-06 000601.png', 2025019),
(5, '20256912532', 15, 'Resume', 'photos/29082025045604img.png', 2025020);

-- --------------------------------------------------------

--
-- Table structure for table `tblautonumbers`
--

CREATE TABLE `tblautonumbers` (
  `AUTOID` int(11) NOT NULL,
  `AUTOSTART` varchar(30) NOT NULL,
  `AUTOEND` int(11) NOT NULL,
  `AUTOINC` int(11) NOT NULL,
  `AUTOKEY` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblautonumbers`
--

INSERT INTO `tblautonumbers` (`AUTOID`, `AUTOSTART`, `AUTOEND`, `AUTOINC`, `AUTOKEY`) VALUES
(1, '02983', 8, 1, 'userid'),
(2, '000', 80, 1, 'employeeid'),
(3, '0', 20, 1, 'APPLICANT'),
(4, '69125', 35, 1, 'FILEID');

-- --------------------------------------------------------

--
-- Table structure for table `tblcategory`
--

CREATE TABLE `tblcategory` (
  `CATEGORYID` int(11) NOT NULL,
  `CATEGORY` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblcategory`
--

INSERT INTO `tblcategory` (`CATEGORYID`, `CATEGORY`) VALUES
(10, 'Technology'),
(14, 'Civil Engineer'),
(15, 'HR'),
(23, 'Sales'),
(25, 'Finance'),
(27, 'Degital Marketing'),
(30, 'Healthcare');

-- --------------------------------------------------------

--
-- Table structure for table `tblcompany`
--

CREATE TABLE `tblcompany` (
  `COMPANYID` int(11) NOT NULL,
  `COMPANYNAME` varchar(90) NOT NULL,
  `COMPANYADDRESS` varchar(90) NOT NULL,
  `COMPANYCONTACTNO` varchar(30) NOT NULL,
  `COMPANYSTATUS` varchar(90) NOT NULL,
  `COMPANYMISSION` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblcompany`
--

INSERT INTO `tblcompany` (`COMPANYID`, `COMPANYNAME`, `COMPANYADDRESS`, `COMPANYCONTACTNO`, `COMPANYSTATUS`, `COMPANYMISSION`) VALUES
(1, 'Mandalay Builders Co.', '88 Road,Chanayethazan,Mandalay', '09-123 456 701', '', 'weqwe'),
(2, 'Snowy', 'Yangon', '09-42345678', 'yes', 'yes'),
(4, 'Shwe Sin Medical Center', '34 Health Avenue, Taunggyi, Shan State', '09-123 456 703', '', ''),
(5, 'Ayeyarwady Transport Services', '56 River View Road, Pathein, Ayeyarwady Region', '09-123 456 704', '', ''),
(6, 'Yangon Digital Solutions', 'No. 45, Tech Lane, Hlaing Township, Yangon', '09-123 456 700', '', ''),
(7, 'M Mart', '101 Shop Road, Mawlamyine, Mon State', '09-123 456 705', '', '');

--
-- Triggers `tblcompany`
--
DELIMITER $$
CREATE TRIGGER `before_company_delete` BEFORE DELETE ON `tblcompany` FOR EACH ROW BEGIN
    DELETE FROM tbljob WHERE COMPANYID = OLD.COMPANYID;
    DELETE FROM tblemployees WHERE COMPANYID = OLD.COMPANYID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblemployees`
--

CREATE TABLE `tblemployees` (
  `INCID` int(11) NOT NULL,
  `EMPLOYEEID` varchar(30) NOT NULL,
  `FNAME` varchar(50) NOT NULL,
  `LNAME` varchar(50) NOT NULL,
  `MNAME` varchar(50) NOT NULL,
  `ADDRESS` varchar(90) NOT NULL,
  `BIRTHDATE` date NOT NULL,
  `BIRTHPLACE` varchar(90) NOT NULL,
  `AGE` int(11) NOT NULL,
  `SEX` varchar(30) NOT NULL,
  `CIVILSTATUS` varchar(30) NOT NULL,
  `TELNO` varchar(40) NOT NULL,
  `EMP_EMAILADDRESS` varchar(90) NOT NULL,
  `CELLNO` varchar(30) NOT NULL,
  `POSITION` varchar(50) NOT NULL,
  `WORKSTATS` varchar(90) NOT NULL,
  `EMPPHOTO` varchar(255) NOT NULL,
  `EMPUSERNAME` varchar(90) NOT NULL,
  `EMPPASSWORD` varchar(125) NOT NULL,
  `DATEHIRED` date NOT NULL,
  `COMPANYID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblemployees`
--

INSERT INTO `tblemployees` (`INCID`, `EMPLOYEEID`, `FNAME`, `LNAME`, `MNAME`, `ADDRESS`, `BIRTHDATE`, `BIRTHPLACE`, `AGE`, `SEX`, `CIVILSTATUS`, `TELNO`, `EMP_EMAILADDRESS`, `CELLNO`, `POSITION`, `WORKSTATS`, `EMPPHOTO`, `EMPUSERNAME`, `EMPPASSWORD`, `DATEHIRED`, `COMPANYID`) VALUES
(76, '2018001', 'Chambe', 'Narciso', 'Captain', 'mabinay', '1992-01-23', 'Mabinay', 26, 'Male', 'Married', '032656', 'chambe@yahoo.com', '', 'Fuel Tender', '', '', '2018001', 'f3593fd40c55c33d1788309d4137e82f5eab0dea', '2018-05-23', 2),
(78, '222', 'YAMIN', 'NWE', 'NWE', 'MDY', '2000-08-21', 'mdy', 24, 'Female', 'Married', '098766543322', 'yamin@gmail.com', '', 'Accounting', '', '', '222', '1c6637a8f2e1f75e06ff9984894d6bd16a3a36a9', '2025-08-07', 2);

-- --------------------------------------------------------

--
-- Table structure for table `tblfeedback`
--

CREATE TABLE `tblfeedback` (
  `FEEDBACKID` int(11) NOT NULL,
  `APPLICANTID` int(11) NOT NULL,
  `REGISTRATIONID` int(11) NOT NULL,
  `FEEDBACK` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblfeedback`
--

INSERT INTO `tblfeedback` (`FEEDBACKID`, `APPLICANTID`, `REGISTRATIONID`, `FEEDBACK`) VALUES
(2, 2025018, 3, 'Pending'),
(3, 2025019, 4, 'Accept');

-- --------------------------------------------------------

--
-- Table structure for table `tbljob`
--

CREATE TABLE `tbljob` (
  `JOBID` int(11) NOT NULL,
  `COMPANYID` int(11) NOT NULL,
  `CATEGORY` varchar(250) NOT NULL,
  `OCCUPATIONTITLE` varchar(90) NOT NULL,
  `REQ_NO_EMPLOYEES` int(11) NOT NULL,
  `SALARIES` double NOT NULL,
  `DURATION_EMPLOYEMENT` varchar(90) NOT NULL,
  `QUALIFICATION_WORKEXPERIENCE` text NOT NULL,
  `JOBDESCRIPTION` text NOT NULL,
  `PREFEREDSEX` varchar(30) NOT NULL,
  `SECTOR_VACANCY` text NOT NULL,
  `JOBSTATUS` varchar(90) NOT NULL,
  `DATEPOSTED` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbljob`
--

INSERT INTO `tbljob` (`JOBID`, `COMPANYID`, `CATEGORY`, `OCCUPATIONTITLE`, `REQ_NO_EMPLOYEES`, `SALARIES`, `DURATION_EMPLOYEMENT`, `QUALIFICATION_WORKEXPERIENCE`, `JOBDESCRIPTION`, `PREFEREDSEX`, `SECTOR_VACANCY`, `JOBSTATUS`, `DATEPOSTED`) VALUES
(1, 6, 'Technology', 'Web Developer', 2, 500000, 'September 25', '2+ years in PHP/JavaScript\r\nDiploma in Computer Science\r\n', 'Develop and maintain company websites. Must know WordPress and React.', 'Male/Female', 'yes', 'yes', '2025-08-10 00:00:00'),
(2, 6, 'Technology', 'IT Support Specialist', 1, 400000, 'October 4', '1 year IT helpdesk experience and\r\nMicrosoft Certified preferred\r\n', 'Provide technical support to staff. Troubleshoot hardware/software issues.', 'Male', 'yes', 'yes', '2025-08-10 02:33:00'),
(3, 1, 'Civil Engineer', 'Junior Civil Engineer', 2, 600000, 'September 30', 'Bachelor\'s in Civil Engineering\r\n1+ year site experience', 'Assist in construction site supervision, material testing, and CAD drafting.', 'Male', 'yes', 'yes', '2025-08-08 10:43:42'),
(4, 1, 'Civil Engineer', 'MEP Engineer (Mechanical/Electrical/Plumbing)', 1, 400000, 'Septemer 10', '2+ years in building systems\r\nAutoCAD MEP skills', 'Coordinate utility installations in high-rise buildings.', 'Male', 'yes', 'yes', '2025-08-08 10:55:43'),
(6, 4, 'Healthcare', 'Registered Nurse (RN)', 4, 500000, 'December 10', 'Diploma in Nursing\r\n1+ year hospital experience\r\nValid Myanmar Nursing Council license', 'Provide patient care, administer medications, and assist doctors at Shwe Sin Medical Center.', 'Female', 'Yes', 'Yes', '2025-08-10 13:25:25'),
(7, 6, 'Digital Marketing Job', 'Social Media Manager', 1, 400000, 'December 3', '2+ years managing FB/Instagram/TikTok\r\nContent creation skills (Canva/Photoshop)', 'Develop engaging content and grow company social media presence.', 'Female', 'Yes', 'Yes', '2025-08-10 17:01:50'),
(10, 5, 'HR', 'Payroll Administrator', 2, 600000, 'September 2', 'Knowledge of Myanmar labor laws\\r\\n1+ year payroll processing', 'Calculate salaries, taxes, and benefits for 100+ employees.', 'Female', 'Yes', '', '2025-08-10 17:12:00'),
(11, 1, 'Civil Engineer', 'Structural Engineer', 1, 700000, 'September 4', '3+ years in building design\\r\\nETABS/STAAD Pro proficiency', 'Design and analyze building structures. Prepare technical reports.', 'Female', 'Yes', '', '2025-08-10 17:15:00'),
(12, 4, 'HR', 'Training Coordinator', 2, 300000, 'October 19', 'Experience in L&D programs\\r\\nPowerPoint/Excel proficiency', 'Organize staff training sessions and track skill development.', 'Female', 'yes', '', '2025-08-10 17:20:00'),
(13, 7, 'Sales', 'Retail Sales Associate', 2, 300000, 'September10', 'High school diploma\\r\\n6+ months retail experience', 'Assist customers, manage inventory, and achieve store sales targets.', 'Female', 'yes', '', '2025-08-10 17:26:00'),
(14, 2, 'Degital Marketing', 'Audit Assistant', 4, 600000, '', 'CPA Part II passed\\r\\n6+ months audit experience', 'Assist in financial audits for SME clients across Yangon.', 'Female', 'Yes\\r\\n', '', '2025-08-10 17:32:00'),
(15, 4, 'Sales', 'E-commerce Assistant', 2, 300000, 'September 30', 'Shopee/Lazada platform knowledge\\r\\nFresh graduates welcome\\r\\n\\r\\n', '', 'None', '', '', '2025-08-10 17:36:00');

--
-- Triggers `tbljob`
--
DELIMITER $$
CREATE TRIGGER `before_job_delete` BEFORE DELETE ON `tbljob` FOR EACH ROW BEGIN
    DELETE FROM tbljobregistration WHERE JOBID = OLD.JOBID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbljobregistration`
--

CREATE TABLE `tbljobregistration` (
  `REGISTRATIONID` int(11) NOT NULL,
  `COMPANYID` int(11) NOT NULL,
  `JOBID` int(11) NOT NULL,
  `APPLICANTID` int(11) NOT NULL,
  `APPLICANT` varchar(90) NOT NULL,
  `REGISTRATIONDATE` date NOT NULL,
  `REMARKS` varchar(255) NOT NULL DEFAULT 'Pending',
  `FILEID` varchar(30) DEFAULT NULL,
  `PENDINGAPPLICATION` tinyint(1) NOT NULL DEFAULT 1,
  `HVIEW` tinyint(1) NOT NULL DEFAULT 1,
  `DATETIMEAPPROVED` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbljobregistration`
--

INSERT INTO `tbljobregistration` (`REGISTRATIONID`, `COMPANYID`, `JOBID`, `APPLICANTID`, `APPLICANT`, `REGISTRATIONDATE`, `REMARKS`, `FILEID`, `PENDINGAPPLICATION`, `HVIEW`, `DATETIMEAPPROVED`) VALUES
(1, 2, 2, 2018013, 'Kim Domingo', '2018-05-27', 'Ive seen your work and its really interesting', '2147483647', 0, 1, '2018-05-26 16:13:01'),
(2, 2, 2, 2018015, 'Janry Tan', '2018-05-26', 'aasd', '2147483647', 0, 0, '2018-05-28 14:14:45'),
(3, 2, 2, 2025018, 'susu san', '2025-08-06', 'Pending', '20256912529', 0, 1, '2025-08-06 19:27:20'),
(4, 2, 2, 2025019, 'YAMIN NWE', '2025-08-07', 'Accept', '20256912531', 0, 1, '2025-08-07 15:43:56');

-- --------------------------------------------------------

--
-- Table structure for table `tblusers`
--

CREATE TABLE `tblusers` (
  `USERID` varchar(30) NOT NULL,
  `FULLNAME` varchar(40) NOT NULL,
  `USERNAME` varchar(90) NOT NULL,
  `PASS` varchar(90) NOT NULL,
  `ROLE` varchar(30) NOT NULL,
  `PICLOCATION` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`USERID`, `FULLNAME`, `USERNAME`, `PASS`, `ROLE`, `PICLOCATION`) VALUES
('00018', 'ChawChaw', 'chaw', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'Administrator', 'photos/OIP.webp'),
('0999', 'zin san', 'san', '7a20ac5aeb7c70acdeac71c9d4ebe7ac17f7ce7e', 'Employee', ''),
('2018001', 'Chambe Narciso', 'Narciso', 'f3593fd40c55c33d1788309d4137e82f5eab0dea', 'Employee', ''),
('222', 'YAMIN NWE', 'NWE', '1c6637a8f2e1f75e06ff9984894d6bd16a3a36a9', 'Employee', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_audit_log`
--

CREATE TABLE `tbl_audit_log` (
  `AUDIT_ID` int(11) NOT NULL,
  `TABLE_NAME` varchar(100) DEFAULT NULL,
  `ACTION_TYPE` varchar(10) DEFAULT NULL,
  `RECORD_ID` int(11) DEFAULT NULL,
  `OLD_DATA` text DEFAULT NULL,
  `NEW_DATA` text DEFAULT NULL,
  `USER_NAME` varchar(100) DEFAULT NULL,
  `ACTION_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_audit_log`
--

INSERT INTO `tbl_audit_log` (`AUDIT_ID`, `TABLE_NAME`, `ACTION_TYPE`, `RECORD_ID`, `OLD_DATA`, `NEW_DATA`, `USER_NAME`, `ACTION_DATE`) VALUES
(1, 'tblapplicants', 'INSERT', 2025020, NULL, 'Name: Test User, Email: test@example.com', 'root@localhost', '2025-08-19 15:05:51'),
(2, 'tblapplicants', 'UPDATE', 2025020, 'Old: Test User, Email: test@example.com', 'New: Updated User, Email: test@example.com', 'root@localhost', '2025-08-19 15:07:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblapplicants`
--
ALTER TABLE `tblapplicants`
  ADD PRIMARY KEY (`APPLICANTID`);

--
-- Indexes for table `tblattachmentfile`
--
ALTER TABLE `tblattachmentfile`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tblautonumbers`
--
ALTER TABLE `tblautonumbers`
  ADD PRIMARY KEY (`AUTOID`);

--
-- Indexes for table `tblcategory`
--
ALTER TABLE `tblcategory`
  ADD PRIMARY KEY (`CATEGORYID`);

--
-- Indexes for table `tblcompany`
--
ALTER TABLE `tblcompany`
  ADD PRIMARY KEY (`COMPANYID`);

--
-- Indexes for table `tblemployees`
--
ALTER TABLE `tblemployees`
  ADD PRIMARY KEY (`INCID`),
  ADD UNIQUE KEY `EMPLOYEEID` (`EMPLOYEEID`),
  ADD KEY `fk_employee_company` (`COMPANYID`);

--
-- Indexes for table `tblfeedback`
--
ALTER TABLE `tblfeedback`
  ADD PRIMARY KEY (`FEEDBACKID`);

--
-- Indexes for table `tbljob`
--
ALTER TABLE `tbljob`
  ADD PRIMARY KEY (`JOBID`),
  ADD KEY `fk_job_company` (`COMPANYID`);

--
-- Indexes for table `tbljobregistration`
--
ALTER TABLE `tbljobregistration`
  ADD PRIMARY KEY (`REGISTRATIONID`),
  ADD KEY `fk_registration_company` (`COMPANYID`),
  ADD KEY `fk_registration_job` (`JOBID`),
  ADD KEY `fk_registration_applicant` (`APPLICANTID`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`USERID`);

--
-- Indexes for table `tbl_audit_log`
--
ALTER TABLE `tbl_audit_log`
  ADD PRIMARY KEY (`AUDIT_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblapplicants`
--
ALTER TABLE `tblapplicants`
  MODIFY `APPLICANTID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2025021;

--
-- AUTO_INCREMENT for table `tblattachmentfile`
--
ALTER TABLE `tblattachmentfile`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblautonumbers`
--
ALTER TABLE `tblautonumbers`
  MODIFY `AUTOID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblcategory`
--
ALTER TABLE `tblcategory`
  MODIFY `CATEGORYID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tblcompany`
--
ALTER TABLE `tblcompany`
  MODIFY `COMPANYID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tblemployees`
--
ALTER TABLE `tblemployees`
  MODIFY `INCID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `tblfeedback`
--
ALTER TABLE `tblfeedback`
  MODIFY `FEEDBACKID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbljob`
--
ALTER TABLE `tbljob`
  MODIFY `JOBID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbljobregistration`
--
ALTER TABLE `tbljobregistration`
  MODIFY `REGISTRATIONID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_audit_log`
--
ALTER TABLE `tbl_audit_log`
  MODIFY `AUDIT_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblemployees`
--
ALTER TABLE `tblemployees`
  ADD CONSTRAINT `fk_employee_company` FOREIGN KEY (`COMPANYID`) REFERENCES `tblcompany` (`COMPANYID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbljob`
--
ALTER TABLE `tbljob`
  ADD CONSTRAINT `fk_job_company` FOREIGN KEY (`COMPANYID`) REFERENCES `tblcompany` (`COMPANYID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbljobregistration`
--
ALTER TABLE `tbljobregistration`
  ADD CONSTRAINT `fk_registration_applicant` FOREIGN KEY (`APPLICANTID`) REFERENCES `tblapplicants` (`APPLICANTID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_registration_company` FOREIGN KEY (`COMPANYID`) REFERENCES `tblcompany` (`COMPANYID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_registration_job` FOREIGN KEY (`JOBID`) REFERENCES `tbljob` (`JOBID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
