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
  name varchar2(50) not null, 
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

-- INSERT INTO Branch 
-- VALUES 
--   (
--     1, "ABC", "123 Charming Ave", "Vancouver", 
--     "6041234567"
--   );
-- INSERT INTO Branch 
-- VALUES 
--   (
--     2, "DEF", "123 Coco Ave", "Vancouver", 
--     "6044567890"
--   );

INSERT INTO Account VALUES (
  1, "mailtrapsupertesting+signup@gmail.com",
   mighty-dusk,
    "Agc%[A5Ag*", 
    TIMESTAMP("2017-07-23",  "13:10:11"), 
    TIMESTAMP("2002-03-29",  "12:43:01")
);

INSERT INTO Account VALUES (
  2, "mailtrapsupertesting+newsletter@gmail.com",
   happy-puppy,
    "}bGG93Y}Vh", 
    TIMESTAMP("2014-03-11",  "11:11:11"), 
    TIMESTAMP("2003-03-24",  "12:43:00")
);

INSERT INTO Account VALUES (
  3, "mailtrapsupertesting+premiumacc@gmail.com",
   wb_dreaming,
    ".WS9bzrVf}", 
    TIMESTAMP("2009-04-08",  "00:11:22"), 
    TIMESTAMP("2000-03-24",  "12:33:44")
);

INSERT INTO Account VALUES (
  4, "mailtrapsupertesting+saasupgrade@gmail.com",
   hackers_anon,
    "VP9.fQ$(V^", 
    TIMESTAMP("2022-04-08",  "00:11:22"), 
    TIMESTAMP("2004-12-12",  "07:07:07")
);

INSERT INTO Account VALUES (
  5, "LOLOLO@FREEUKRAINE.RU",
   Zelensky,
    "8Jy/.Mu&wj", 
    TIMESTAMP("2020-05-09",  "00:11:22"), 
    TIMESTAMP("2004-12-12",  "06:06:06")
);

INSERT INTO Forum VALUES (
  1, 
  "Spinning Jokes for Ray Tracing University Students", 
  "PEACE"
);

INSERT INTO Forum VALUES (
  2, 
  "Kremlin File", 
  "PUTIN"
);

INSERT INTO Forum VALUES (
  3, 
  "Wholesome Bird Pictures", 
  "FREEDOM"
);

INSERT INTO Forum VALUES (
  4, 
  "You Have the World's Support", 
  "UKRAINE"
);

INSERT INTO Forum VALUES (
  5, 
  "Sims 3 Genocide ", 
  "PIPELINES"
);

INSERT INTO Chat VALUES (
  0,
  "SOLIDER",
  "purple"
)

INSERT INTO Chat VALUES (
  1,
  "LIBERATION FRONT",
  "grey"
)

INSERT INTO Chat VALUES (
  2,
  "Metallica Fans",
  "red"
)

INSERT INTO Chat VALUES (
  3,
  "FALLOUT 4",
  "blue"
)

INSERT INTO Chat VALUES (
  4,
  "Insider Traders",
  "chrome"
)

