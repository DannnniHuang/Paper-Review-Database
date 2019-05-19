CREATE DATABASE CONFERENCE_REVIEW;
#Creating a table inside a database
USE CONFERENCE_REVIEW;
#Creating an AUTHOR table with EmailAddr as primary key
CREATE TABLE AUTHOR
(
	EmailAddr VARCHAR(250) NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PRIMARY KEY (EmailAddr)
);
#Creating a PAPER table with Id as primary key
CREATE TABLE PAPER
(
	Id INT PRIMARY KEY,
    Title VARCHAR(250) NOT NULL,
    Absrract TEXT,
    FileName VARCHAR(150) NOT NULL
    
);
#Create SUBMIT Relation between Author and Paper
CREATE TABLE AUTHOR_SUBMIT
(
    AuthorId VARCHAR(250) NOT NULL,    
    PaperId INT NOT NULL,
    FOREIGN KEY (AuthorId) REFERENCES Author (EmailAddr),
    FOREIGN KEY (PaperId) REFERENCES Paper(Id)
  
);
#Creating an REVIEWER table with EmailAddr as primary key
CREATE TABLE REVIEWER
(
	EmailAddr VARCHAR(250) NOT NULL,
    FirstName VARCHAR(250) NOT NULL,
    LastName VARCHAR(250) NOT NULL,
    AuthorFeedback VARCHAR(150) NOT NULL,
    CommiteeFeedback VARCHAR(150) NOT NULL,
    PhoneNum VARCHAR(20) NOT NULL,
    Affiliation VARCHAR(150) NOT NULL default ' ',
    PRIMARY KEY (EmailAddr)
);
#Creating a Topic table with Id as primary key
CREATE TABLE TOPIC
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    TopicName VARCHAR(150) NOT NULL
);
#Create HAS Relation between Reviewer and Topic
CREATE TABLE HAS
(
	ReviewerId VARCHAR(150) NOT NULL,
    TopicId INT NOT NULL,
    FOREIGN KEY(ReviewerId) REFERENCES Reviewer(EmailAddr),
    FOREIGN KEY(TopicId) REFERENCES Topic(Id),
    UNIQUE (TopicId)
);

#Create ASSIGNED Relation between Reviewer and Paper
 CREATE TABLE ASSIGNED
 (
	Id SERIAL, 
    ReviewerId VARCHAR(150) NOT NULL,
    PaperId INT NOT NULL,
    FOREIGN KEY (ReviewerId) REFERENCES Reviewer (EmailAddr),
    FOREIGN KEY (PaperId) REFERENCES AUTHOR_SUBMIT(PaperId)
 );
 #Create SUBMIT Relation between Reviewer and Review
CREATE TABLE REVIEWER_SUBMIT
(
	ReviewerId VARCHAR(150) PRIMARY KEY NOT NULL,
    ReviewId INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY(ReviewerId) REFERENCES Reviewer (EmailAddr),    
    UNIQUE (ReviewId)
);
#Creating an Review table with Id as primary key
CREATE TABLE REVIEW
(
	Id INT PRIMARY KEY,
    Recommendation TEXT,
    MeritScore INT NOT NULL CHECK(MeritScore BETWEEN 1 AND 10),
    PaperId INT NOT NULL,
    ReadabilityScore INT NOT NULL CHECK(ReadabilityScore BETWEEN 1 AND 10),
    ReviewerId VARCHAR(150) NOT NULL,
    OriginalityScore INT NOT NULL CHECK(OriginalityScore BETWEEN 1 AND 10),
    RelevanceScore INT NOT NULL CHECK( RelevanceScore BETWEEN 1 AND 10),
    FOREIGN KEY (Id) REFERENCES REVIEWER_SUBMIT(ReviewId),
    FOREIGN KEY (PaperId) REFERENCES AUTHOR_SUBMIT(PaperId),
    FOREIGN KEY (ReviewerId) REFERENCES REVIEWER_SUBMIT(ReviewerId)
    
);




	
    



    

