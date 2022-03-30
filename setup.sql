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
  birthday date,
  country varchar2(50),
  name varchar2(50),
  followers integer DEFAULT 0,
  following integer DEFAULT 0,
  color varchar2(20) DEFAULT "grey",
  posts integer DEFAULT 0,
  top_interest varchar2(20)
);

CREATE TABLE Forum(
  forumID integer not null PRIMARY KEY, 
  name varchar2(50) not null, 
  topic varchar2(20) not null,
  participants integer DEFAULT 0,
  isLive integer DEFAULT 1,
  posts integer DEFAULT 0
);

CREATE TABLE Chat(
  chatID integer not null PRIMARY KEY, 
  name varchar2(50), 
  messages integer DEFAULT 0,
  max_users integer DEFAULT 100,
  color varchar2(20) DEFAULT "grey"
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
);

INSERT INTO Chat VALUES (
  1,
  "LIBERATION FRONT",
  "grey"
);

INSERT INTO Chat VALUES (
  2,
  "Metallica Fans",
  "red"
);

INSERT INTO Chat VALUES (
  3,
  "FALLOUT 4",
  "blue"
);

INSERT INTO Chat VALUES (
  4,
  "Insider Traders",
  "chrome"
);

INSERT INTO Subscriptions VALUES (
  0,
  "CORN MAZE "
);

INSERT INTO Subscriptions VALUES (
  1,
  "BITCOIN WHALERS"
);

INSERT INTO Subscriptions VALUES (
  2,
  "SECURITIES FRAUD"
);

INSERT INTO Subscriptions VALUES (
  3,
  "Youtube Dislike"
);

INSERT INTO Subscriptions VALUES (
  4,
  "LOLOLOLOL"
);

INSERT INTO TOPIC VALUES (
  0
);

INSERT INTO TOPIC VALUES (
  1
);

INSERT INTO TOPIC VALUES (
  2
);

INSERT INTO TOPIC VALUES (
  3
);

INSERT INTO TOPIC VALUES (
  4
);

INSERT INTO TOPIC VALUES (
  5
);

INSERT INTO Subscriber VALUES (
  0,
  "RWANADA",
  "mobile"
);

INSERT INTO Subscriber VALUES (
  1,
  "ISRAEL",
  "laptop"
);

INSERT INTO Subscriber VALUES (
  2,
  "GREECE",
  "mobile"
);

INSERT INTO Subscriber VALUES (
  3,
  "CANADA",
  "PC"
);

INSERT INTO Subscriber VALUES (
  4,
  "ZIMBAWABE",
  "iphone"
);

INSERT INTO Owns_Subscriptions VALUES (
  2,0,1
);

INSERT INTO Owns_Subscriptions VALUES (
  1,0,2
);

INSERT INTO Owns_Subscriptions VALUES (
  4,1,3
);

INSERT INTO Owns_Subscriptions VALUES (
  4,4,4
);

INSERT INTO Owns_Subscriptions VALUES (
  4,3,5
);

INSERT INTO Contains_Messages VALUES (
  1,
  1,
  "Donald",
  "Trump",
  TIMESTAMP("2009-04-08",  "00:11:22")
);

INSERT INTO Contains_Messages VALUES (
  1,
  2,
  "Donald",
  "Duck",
  TIMESTAMP("2010-04-08",  "00:11:22")
);

INSERT INTO Contains_Messages VALUES (
  1,
  3,
  "Vladimir",
  "Putin",
  TIMESTAMP("2011-04-08",  "00:11:22")
);

INSERT INTO Contains_Messages VALUES (
  2,
  1,
  "Vladimir",
  "Poutine",
  TIMESTAMP("2022-04-08",  "00:11:22")
);

INSERT INTO Contains_Messages VALUES (
  2,
  2,
  "Zelensky",
  "Netanyahu",
  TIMESTAMP("2010-04-08",  "00:11:22")
);

INSERT INTO Owns_Live_Assets VALUES (
  1,
  1,
  "mp3",
  TIMESTAMP("2021-04-08",  "00:11:22"),
  "www.nwPlus.io",
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  3,
  4,
  "mp3",
  TIMESTAMP("2011-04-08",  "00:11:22"),
  "www.nwHacks.io",
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  3,
  5,
  "mp4",
  TIMESTAMP("2012-04-08",  "00:11:22"),
  "www.nwPlus.io",
  1
);

INSERT INTO Owns_Live_Assets VALUES (
  2,
  6,
  "mp3",
  TIMESTAMP("2019-04-08",  "00:11:22"),
  "www.nwPlus.io",
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  5,
  8,
  "mp3",
  TIMESTAMP("2031-04-08",  "00:11:22"),
  "www.nwPlus.io",
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  1,
  11,
  "mp3",
  TIMESTAMP("2044-04-08",  "00:11:22"),
  "www.google.com",
  1
);

INSERT INTO Owns_Static_Assets VALUES (
4,
2,
"https://see.news/wp-content/uploads/2020/12/UK_wildbirds-01-robin.jpg",
"jpeg",
"picture",
"1080p"
);

INSERT INTO Owns_Static_Assets VALUES (
3,
3,
"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMjwkX18cy574Qn82mrfaubhqhdVQylzSpJA&usqp=CAU",
"png",
"picture",
"720p"
);

INSERT INTO Owns_Static_Assets VALUES (
3,
7,
"https://www.youtube.com/watch?v=yWcGtLblBxs",
"mp4",
"video",
"4k"
);

INSERT INTO Owns_Static_Assets VALUES (
1,
9,
"https://media.giphy.com/media/IsCM8aCBUjpRwJ2IJN/giphy-downsized-large.gif",
"gif",
"Metaverse File",
"8k"
);

INSERT INTO Owns_Static_Assets VALUES (
5,
10,
"https://giphy.com/clips/ReadyGames-icon-nft-virtual-marketplace-PcNf8Gm4O3VdXnPaNw",
"jpeg",
"GoogleverseFile",
"16k"
);