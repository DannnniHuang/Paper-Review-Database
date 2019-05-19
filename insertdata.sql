USE CONFERENCE_REVIEW;

#Insert data to AUTHOR Table
INSERT INTO AUTHOR (EmailAddr, FirstName, LastName) VALUES
('Scarlett@hotmail.com','Scarlett','Johansson'),
('Robert@hotmail.com','Robert','Downey Jr.'),
('ChrisE@hotmail.com','Chris','Evans');

#Insert data to Paper
INSERT INTO PAPER (Id, Title, Absrract, FileName) VALUES
(1,'Thinking in Systems','Thinking in Systems, is a concise offering insight for problem solving on scales ranging from the personal to the global.','FGB,txt');
INSERT INTO PAPER (Id, Title, Absrract, FileName) VALUES
(2,'How Calculus Reveals the Secrets of the Universe','Without calculus, we wouldn’t have cell phones, TV, GPS, or ultrasound. We wouldn’t have unraveled DNA or discovered Neptune or figured out how to put 5,000 songs in your pocket. ','BGF.txt');

#Author submits to paper
INSERT INTO AUTHOR_SUBMIT values("Scarlett@hotmail.com", 1);
INSERT INTO AUTHOR_SUBMIT values("ChrisE@hotmail.com", 2);

#Insert data to REVIEWER Table
INSERT INTO REVIEWER (EmailAddr, FirstName, LastName, AuthorFeedback, CommiteeFeedback, PhoneNum, Affiliation) VALUES
('ChrisH@hotmail.com','Chris','Hemsworth',"The Editor managed the paper very well.","Professional way of managing the submitted articles.", '(646)321-7489',' MCAK'),
('Mark@hotmail.com','Mark','Ruffalo',"Satisfied with overall review process.","Rapid speed of reviewing and good advices.",'(344)567-2341','LAC');

#Insert data to TOPIC Table
INSERT INTO TOPIC (TopicName) VALUES
('Science'),
('Business'),
('History');

#Insert data to HAS Table
INSERT INTO HAS (ReviewerId, TopicId) VALUES
((SELECT EmailAddr FROM Reviewer WHERE EmailAddr='ChrisH@hotmail.com'),(SELECT Id FROM TOPIC WHERE TopicName='Science')),
((SELECT EmailAddr FROM Reviewer WHERE EmailAddr='Mark@hotmail.com'),(SELECT Id FROM TOPIC WHERE TopicName='Business'));

#Insert data to ASSIGNED Table
INSERT INTO ASSIGNED (ReviewerId,PaperId) VALUES
((SELECT EmailAddr FROM Reviewer WHERE EmailAddr='ChrisH@hotmail.com'),(SELECT PaperId FROM AUTHOR_SUBMIT WHERE AuthorId='ChrisE@hotmail.com')),
((SELECT EmailAddr FROM Reviewer WHERE EmailAddr='Mark@hotmail.com'),(SELECT PaperId FROM AUTHOR_SUBMIT WHERE AuthorId='Scarlett@hotmail.com'));

#Inser data to REVIEWER_SUBMIT Table
INSERT INTO REVIEWER_SUBMIT (ReviewerId) SELECT EmailAddr FROM REVIEWER;

#Insert data REVIEW Table
INSERT INTO REVIEW (Id, Recommendation, MeritScore, ReadabilityScore, RelevanceScore, OriginalityScore, PaperId, ReviewerId) VALUES
((SELECT ReviewId FROM REVIEWER_SUBMIT WHERE ReviewerId='ChrisH@hotmail.com'),'A brilliant, appealing explanation of how calculus works and why it makes our lives so much better.',5,5,4,2,(SELECT PaperId FROM AUTHOR_SUBMIT WHERE AuthorId='ChrisE@hotmail.com'),(SELECT ReviewerId FROM REVIEWER_SUBMIT WHERE ReviewerId='ChrisH@hotmail.com')),
((SELECT ReviewId FROM REVIEWER_SUBMIT WHERE ReviewerId='Mark@hotmail.com'),'I learned a lot from this book, and even cited learnings from it to friends and colleagues.',3,5,4,5,(SELECT PaperId FROM AUTHOR_SUBMIT WHERE AuthorId='Scarlett@hotmail.com'),(SELECT ReviewerId FROM REVIEWER_SUBMIT WHERE ReviewerId='Mark@hotmail.com'));












