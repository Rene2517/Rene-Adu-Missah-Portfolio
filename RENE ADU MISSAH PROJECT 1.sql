--. Regions Table
--Each region contains multiple constituencies.

CREATE TABLE Region(
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(50) NOT NULL
);

--Constituencies are linked to regions, and each constituency is represented by one MP.

CREATE TABLE Constituency (
    ConstituencyID INT PRIMARY KEY,
    ConstituencyName VARCHAR(100) NOT NULL,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Regions_Constituencies Table
--A junction table to manage the relationship between regions and constituencies, allowing each constituency to link to one region.

CREATE TABLE RegionsConstituency (
    RegionID INT,
    ConstituencyID INT,
    PRIMARY KEY (RegionID, ConstituencyID),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID),
    FOREIGN KEY (ConstituencyID) REFERENCES Constituencies(ConstituencyID)
);

--PoliticalParties Table
--Stores data on political parties, with the option for MPs to belong to no party (independent).

CREATE TABLE PoliticalParty (
    PartyCode CHAR(10) PRIMARY KEY,
    PartyName VARCHAR(50) NOT NULL
);

--MPs Table
--Stores information about each MP, including their party affiliation, constituency, and date elected.

CREATE TABLE MP(
    MPCode INT PRIMARY KEY,
    MPName VARCHAR(100) NOT NULL,
    ConstituencyID INT,
    DateElected DATE NOT NULL,
    PartyCode CHAR(10),  -- Nullable for independent MPs
    FOREIGN KEY (ConstituencyID) REFERENCES Constituencies(ConstituencyID),
    FOREIGN KEY (PartyCode) REFERENCES PoliticalParties(PartyCode)
);

-- Agencies Table
--Stores information about agencies that sponsor bills.

CREATE TABLE Agenc(
    AgencyID INT PRIMARY KEY,
    AgencyName VARCHAR(100) NOT NULL
);

--Bills Table
--Stores information on bills, including status, date, and sponsor agency.

CREATE TABLE Bill (
    BillID INT PRIMARY KEY,
    BillName VARCHAR(100) NOT NULL,
    BillDate DATE NOT NULL,
    BillStatus VARCHAR(10) CHECK (Billstatus IN ('yes', 'no')),
   SponsorAgency VARCHAR(100));

   -- Table for Votes
CREATE TABLE Vote (
    VoteID INT PRIMARY KEY,
    BillID INT,
    Mpcode INT,
    VoteType VARCHAR(10) CHECK (VoteType IN ('yes', 'no', 'abstain', 'absent')),
    FOREIGN KEY (BillID) REFERENCES Bill(BillID),
    FOREIGN KEY (Mpcode) REFERENCES MPs(Mpcode)) 


--### Step 2: Populate the Tables
-- Insert sample regions

INSERT INTO Regions   (RegionID,RegionName)VALUES (1,'GreaterAccra');
INSERT INTO Regions  (RegionID,RegionName)VALUES (2,'Ashanti');

-- Insert sample constituencies
INSERT INTO Constituencies (ConstituencyID,ConstituencyName, RegionID) VALUES (123,'GreaterAccra', 1), (321,'Ashanti', 2);

-- Insert sample political parties
INSERT INTO PoliticalParties (Partycode, Partyname) VALUES ('NPP', 'New Patriotic Party'), ('NDC', 'National Democratic Congress');

-- Insert sample MPs
INSERT INTO MPs (MpCode,MpName, ConstituencyID, DateElected, Partycode) VALUES (001,'John Doe', 123, '2020-01-01', 'NPP'), (002,'Jane Smith', 321, '2020-01-01', 'NDC');

-- Insert sample bills
INSERT INTO Bill (BillID,BillName, BillDate, Billstatus, SponsorAgency) VALUES (1001,'Health Care Bill', '2023-05-01', 'no', 'Ministry of Health');

-- Insert sample votes
INSERT INTO Vote (VoteID,BillID, Mpcode, VoteType) VALUES (145,1001, 001, 'yes'), (541, 1001, 002,'no');


CREATE TABLE BillVotesSummary (
    BillID INT PRIMARY KEY,
    YesVotes INT DEFAULT 0,
    NoVotes INT DEFAULT 0,
    AbstainVotes INT DEFAULT 0,
    AbsentVotes INT DEFAULT 0,
    FOREIGN KEY (BillID) REFERENCES Bill(BillID)
);


--STEP 3# cREATING Procedures.and functions.
 CREATE PROCEDURE UpdateBillStatus (@BillID INT)
AS
BEGIN
    DECLARE @YesVotes INT;
    DECLARE @NoVotes INT;
    DECLARE @AbstainVotes INT;
    DECLARE @AbsentVotes INT;
END;
  

CREATE PROCEDURE GetBillVotingSummaryBillID 
AS
BEGIN
    SELECT BillID, YesVotes, NoVotes, AbstainVotes, AbsentVotes
    FROM BillVotesSummary
    WHERE BillID = BillID;
END;

