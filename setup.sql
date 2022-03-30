drop table Uses_Pubsub_Platform;
drop table Uses_Message_Storage;
drop table Link_To;
drop table Streams_To;
drop table Participates_In;
drop table Member_Of;
drop table Contains_Posts;
drop table Owns_Static_Assets;
drop table Owns_Live_Assets;
drop table Contains_Messages;
drop table Owns_Subscriptions;
drop table Subscriber;
drop table Topic;
drop table Subscription;
drop table Chat;
drop table Forum;
drop table Account;



CREATE TABLE Account(
  accountID integer not null PRIMARY KEY, 
  email varchar2(50) UNIQUE, 
  username varchar2(50) UNIQUE, 
  password varchar2(20) not null, 
  dateCreated date not null, 
  birthday date
);

CREATE TABLE Forum(
  forumID integer not null PRIMARY KEY, 
  name varchar2(20) not null, 
  topic varchar2(20) not null
);

CREATE TABLE Chat(
  chatID integer not null PRIMARY KEY, 
  name varchar2(50), 
  color varchar2(7)
);

CREATE TABLE Subscription(
  subID integer not null PRIMARY KEY, 
  name varchar2(50)
);

CREATE TABLE Topic(
  topicID integer not null PRIMARY KEY
);

CREATE TABLE Subscriber(
  userID integer not null PRIMARY KEY, 
  location varchar2(200) not null, 
  deviceType varchar2(20)
);

CREATE TABLE Owns_Subscriptions(
  accountID integer not null, 
  subID integer not null, 
  membershipID integer not null, 
  PRIMARY KEY (accountID, subID, membershipID), 
  FOREIGN KEY (subID) REFERENCES Subscription ON DELETE CASCADE, 
  FOREIGN KEY (accountID) REFERENCES Account ON DELETE CASCADE
);

CREATE TABLE Contains_Messages(
  chatID integer not null, 
  messageID integer not null, 
  sender varchar2(50) not null, 
  body varchar2(200) not null, 
  timestamp date not null, 
  PRIMARY KEY (chatID, messageID), 
  FOREIGN KEY (chatID) REFERENCES Chat ON DELETE CASCADE
);

CREATE TABLE Owns_Live_Assets(
  accountID integer not null, 
  assetID integer not null, 
  metadata varchar2(200) not null, 
  startTime integer not null, 
  url varchar2(100) not null UNIQUE, 
  isVideo integer not null, 
  PRIMARY KEY (accountID, assetID), 
  FOREIGN KEY (accountID) REFERENCES Account ON DELETE CASCADE
);

CREATE TABLE Owns_Static_Assets(
  accountID integer not null, 
  assetID integer not null, 
  url varchar2(300) not null UNIQUE, 
  metadata varchar2(200) not null, 
  type varchar2(20) not null, 
  quality varchar2(20) not null, 
  PRIMARY KEY (accountID, assetID), 
  FOREIGN KEY (accountID) REFERENCES Account ON DELETE CASCADE
);

CREATE TABLE Contains_Posts(
  forumID integer not null, 
  postID integer not null, 
  publisherID integer not null, 
  body varchar2(200) not null, 
  timestamp date not null, 
  PRIMARY KEY (forumID, postID), 
  FOREIGN KEY (forumID) REFERENCES Forum ON DELETE CASCADE, 
  FOREIGN KEY (publisherID) REFERENCES Account(accountID) ON DELETE CASCADE
);

CREATE TABLE Member_Of(
  accountID integer not null, 
  joinDate date, 
  forumID integer not null, 
  isAdmin integer DEFAULT 0, 
  PRIMARY KEY (accountID, forumID), 
  FOREIGN KEY (accountID) REFERENCES Account(accountID) ON DELETE CASCADE, 
  FOREIGN KEY (forumID) REFERENCES Forum(forumID) ON DELETE CASCADE
);

CREATE TABLE Participates_In(
  accountID integer not null, 
  joinDate date not null, 
  chatID integer not null, 
  PRIMARY KEY (accountID, chatID), 
  FOREIGN KEY (accountID) REFERENCES Account ON DELETE CASCADE, 
  FOREIGN KEY (chatID) REFERENCES Chat ON DELETE CASCADE
);

CREATE TABLE Streams_To(
  sessionID integer not null, 
  userID integer not null, 
  topicID integer not null, 
  PRIMARY KEY(userID, topicID, sessionID), 
  FOREIGN KEY(userID) REFERENCES Subscriber ON DELETE CASCADE, 
  FOREIGN KEY(topicID) REFERENCES Topic ON DELETE CASCADE
);

CREATE TABLE Link_To(
  assetID integer not null, 
  topicID integer not null, 
  accountID integer not null, 
  PRIMARY KEY(accountID, assetID, topicID), 
  FOREIGN KEY(topicID) REFERENCES Topic ON DELETE CASCADE, 
  FOREIGN KEY(accountID) REFERENCES Account ON DELETE CASCADE
);

CREATE TABLE Uses_Message_Storage(
  msID integer not null PRIMARY KEY, 
  topicID integer UNIQUE, 
  messageLogID integer not null UNIQUE, 
  messageQueueID integer not null UNIQUE, 
  messageBrokerID integer not null, 
  FOREIGN KEY(topicID) REFERENCES Topic ON DELETE CASCADE
);

CREATE TABLE Uses_Pubsub_Platform(
  platformID integer not null PRIMARY KEY, 
  topicID integer UNIQUE, 
  subscribersCapacity integer not null, 
  publisherCapacity integer not null, 
  FOREIGN KEY(topicID) REFERENCES Topic ON DELETE CASCADE
);

INSERT INTO Branch 
VALUES 
  (
    1, "ABC", "123 Charming Ave", "Vancouver", 
    "6041234567"
  );
INSERT INTO Branch 
VALUES 
  (
    2, "DEF", "123 Coco Ave", "Vancouver", 
    "6044567890"
  );