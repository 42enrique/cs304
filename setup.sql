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
  color varchar2(20) DEFAULT 'Gray',
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
  color varchar2(20) DEFAULT 'Gray'
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
  startTime date not null, 
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

INSERT INTO Account VALUES (
  1, 'mailtrapsupertesting+signup@gmail.com',
   'mighty-dusk',
    'Agc%[A5Ag*', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00', 
   TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'United States',
    'Ray',
    5467,
    23454,
    'Blue',
    456,
    'stocks'
);

INSERT INTO Account VALUES (
  2, 'mailtrapsupertesting+newsletter@gmail.com',
   'happy-puppy',
    '}bGG93Y}Vh', 
   TIMESTAMP '2017-08-09 07:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'Canada',
    'Ray',
    4567,
    4567,
    'Red',
    4567,
    'tech'
);

INSERT INTO Account VALUES (
  3, 'mailtrapsupertesting+premiumacc@gmail.com',
   'wb_dreaming',
    '.WS9bzrVf}', 
    TIMESTAMP '2001-08-09 07:00:00 -7:00', 
   TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'Canada',
    'Ray',
    648,
    468,
    'Gray',
    468,
    'sports'
);


INSERT INTO Account VALUES (
  4, 
  'mailtrapsupertesting+saasupgrade@gmail.com',
   'hackers_anon',
    'VP9.fQ$(V^', 
    TIMESTAMP '1997-08-09 00:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'France',
    'Ray',
    648846,
    4522,
    'Blue',
    7411,
    'crypto'
);

INSERT INTO Account VALUES (
  5, 'LOLOLO@FREEUKRAINE.RU',
   'Zelensky',
    '8Jy/.Muwj', 
    TIMESTAMP '1967-08-09 07:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'Ukraine',
    'Ray',
    9784,
    25534,
    'Blue',
    245634,
    'politics'
);

INSERT INTO Account VALUES (
  6, 'LOLOLO@FREEUsdfsdKRAINE.RU',
   'Zedsfdsflensky',
    '8Jy/.Msdfsdfuwj', 
    TIMESTAMP '1967-08-09 07:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'United States',
    'Rsdfay',
    7864,
    4683,
    'Blue',
    3488,
    'politics'
);

INSERT INTO Account VALUES (
  7, 'LOLOLO@FsdfsREEUKRAINE.RU',
   'Zsdfsdelensky',
    'Ukraine', 
    TIMESTAMP '1967-08-09 07:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'Uksdfsdraine',
    'Rawretay',
    48642,
    22222,
    'Blue',
    10000,
    'politics'
);

INSERT INTO Account VALUES (
  8, 'LOLOLO@FREhfjsEUKRAINE.RU',
   'Zelenssfjky',
    '8Jy/.syjrsMuwj', 
    TIMESTAMP '1967-08-09 07:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'France',
    'Rjbkljbhay',
    111,
    222,
    'Blue',
    333,
    'politics'
);

INSERT INTO Account VALUES (
  9, 'LOfjga;ghoahgap.RU',
   'Zefgaofgg;afdlensky',
    'Spain', 
    TIMESTAMP '1967-08-09 07:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'Ukrnjfnjjgfs;laine',
    'Rkjfjnfgnl;jay',
    654,
    456,
    'Blue',
    852,
    'politics'
);

INSERT INTO Account VALUES (
  10, 'LOLOLO@kdngslFREEUKRAINE.RU',
   'Zeadgnjllensky',
    'Phillipines', 
    TIMESTAMP '1967-08-09 07:00:00 -7:00', 
    TIMESTAMP '2017-08-09 07:00:00 -7:00',
    'Ukraine',
    'R634ay',
    25,
    85,
    'Blue',
    333,
    'politics'
);

INSERT INTO Forum VALUES (
  1, 
  'Spinning Jokes for Ray Tracing University Students', 
  'tech',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  8, 
  'Spinning Jokes for Ray Tracing University Students', 
  'tech',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  6, 
  'Spinning Jokes for Ray Tracing University Students', 
  'tech',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  7, 
  'Spinning Jokes for Ray Tracing University Students', 
  'tech',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  9, 
  'Spinning Jokes for Ray Tracing University Students', 
  'tech',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  10, 
  'Spinning Jokes for Ray Tracing University Students', 
  'tech',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  2, 
  'Kremlin File', 
  'politics',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  3, 
  'Wholesome Bird Pictures', 
  'nature',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  4, 
  'You Have the Worlds Support', 
  'politics',
  345,
  1,
  123
);

INSERT INTO Forum VALUES (
  5, 
  'Sims 3 Genocide ', 
  'politics',
  345,
  1,
  123
);

INSERT INTO Chat VALUES (
  0,
  'SOLIDER',
  345,
  1,
  'purple'
);

INSERT INTO Chat VALUES (
  1,
  'LIBERATION FRONT',
  345,
  1,
  'grey'
);

INSERT INTO Chat VALUES (
  2,
  'Metallica Fans',
  345,
  1,
  'red'
);

INSERT INTO Chat VALUES (
  3,
  'FALLOUT 4',
  345,
  1,
  'blue'
);

INSERT INTO Chat VALUES (
  4,
  'Insider Traders',
  345,
  1,
  'gray'
);

INSERT INTO Subscription VALUES (
  0,
  'CORN MAZE'
);

INSERT INTO Subscription VALUES (
  1,
  'BITCOIN WHALERS'
);

INSERT INTO Subscription VALUES (
  2,
  'SECURITIES FRAUD'
);

INSERT INTO Subscription VALUES (
  3,
  'Youtube Dislike'
);

INSERT INTO Subscription VALUES (
  4,
  'LOLOLOLOL'
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
  'RWANADA',
  'mobile'
);

INSERT INTO Subscriber VALUES (
  1,
  'ISRAEL',
  'laptop'
);

INSERT INTO Subscriber VALUES (
  2,
  'GREECE',
  'mobile'
);

INSERT INTO Subscriber VALUES (
  3,
  'CANADA',
  'PC'
);

INSERT INTO Subscriber VALUES (
  4,
  'ZIMBAWABE',
  'iphone'
);

INSERT INTO Owns_Subscriptions VALUES (
  2, 0, 1
);

INSERT INTO Owns_Subscriptions VALUES (
  1, 0, 2
);

INSERT INTO Owns_Subscriptions VALUES (
  4, 1, 3
);

INSERT INTO Owns_Subscriptions VALUES (
  4, 4, 4
);

INSERT INTO Owns_Subscriptions VALUES (
  4, 3, 5
);

INSERT INTO Owns_Subscriptions VALUES (
  2, 1, 6
);

INSERT INTO Owns_Subscriptions VALUES (
  2, 2, 7
);

INSERT INTO Owns_Subscriptions VALUES (
  2, 3, 8
);

INSERT INTO Owns_Subscriptions VALUES (
  2, 4, 9
);

INSERT INTO Contains_Messages VALUES (
  1,
  1,
  'Donald',
  'Trump',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Contains_Messages VALUES (
  1,
  2,
  'Donald',
  'Duck',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Contains_Messages VALUES (
  1,
  3,
  'Vladimir',
  'Putin',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Contains_Messages VALUES (
  2,
  1,
  'Vladimir',
  'Poutine',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Contains_Messages VALUES (
  2,
  2,
  'Zelensky',
  'Netanyahu',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Owns_Live_Assets VALUES (
  1,
  1,
  'mp3',
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  'www.nwPlus.ioddddddd',
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  3,
  4,
  'mp3',
 TIMESTAMP '2017-08-09 07:00:00 -7:00',
  'www.nwHacks.io',
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  3,
  5,
  'mp4',
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  'www.nwPlus.iooo',
  1
);

INSERT INTO Owns_Live_Assets VALUES (
  2,
  6,
  'mp3',
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  'www.nwPlus.io',
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  5,
  8,
  'mp3',
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  'www.nwPlus.iod',
  0
);

INSERT INTO Owns_Live_Assets VALUES (
  1,
  11,
  'mp3',
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  'www.google.com',
  1
);

INSERT INTO Owns_Static_Assets VALUES (
4,
2,
'https://see.news/wp-content/uploads/2020/12/UK_wildbirds-01-robin.jpg',
'jpeg',
'picture',
'1080p'
);

INSERT INTO Owns_Static_Assets VALUES (
3,
3,
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMjwkX18cy574Qn82mrfaubhqhdVQylzSpJA&usqp=CAU',
'png',
'picture',
'720p'
);

INSERT INTO Owns_Static_Assets VALUES (
3,
7,
'https://www.youtube.com/watch?v=yWcGtLblBxs',
'mp4',
'video',
'4k'
);

INSERT INTO Owns_Static_Assets VALUES (
1,
9,
'https://media.giphy.com/media/IsCM8aCBUjpRwJ2IJN/giphy-downsized-large.gif',
'gif',
'Metaverse File',
'8k'
);

INSERT INTO Owns_Static_Assets VALUES (
5,
10,
'https://giphy.com/clips/ReadyGames-icon-nft-virtual-marketplace-PcNf8Gm4O3VdXnPaNw',
'jpeg',
'GoogleverseFile',
'16k'
);

INSERT INTO Contains_Posts VALUES (
  5,
  1,
  2,
  'FREE',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);


INSERT INTO Contains_Posts VALUES (
  1,
  1,
  2,
  'WORLD',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Contains_Posts VALUES (
  2,
  1,
  5,
  'PEACE',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Contains_Posts VALUES (
  3,
  1,
  4,
  'LEBRONE',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Contains_Posts VALUES (
  4,
  1,
  1,
  'JAMES',
  TIMESTAMP '2017-08-09 07:00:00 -7:00'
);

INSERT INTO Member_Of VALUES (
  1,
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  5,
  0
);

INSERT INTO Member_Of VALUES (
  1,
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  1,
  1
);

INSERT INTO Member_Of VALUES (
  3,
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  2,
  1
);

INSERT INTO Member_Of VALUES (
  4,
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  3,
  0
);

INSERT INTO Member_Of VALUES (
  5,
  TIMESTAMP '2017-08-09 07:00:00 -7:00',
  2,
  1
);

INSERT INTO Participates_In VALUES (
1,
TIMESTAMP '2017-08-09 07:00:00 -7:00',
1
);

INSERT INTO Participates_In VALUES (
3,
TIMESTAMP '2017-08-09 07:00:00 -7:00',
2
);

INSERT INTO Participates_In VALUES (
3,
TIMESTAMP '2017-08-09 07:00:00 -7:00',
3
);

INSERT INTO Participates_In VALUES (
5,
TIMESTAMP '2017-08-09 07:00:00 -7:00',
4
);

INSERT INTO Participates_In VALUES (
5,
TIMESTAMP '2017-08-09 07:00:00 -7:00',
2
);

INSERT INTO Link_To VALUES (
  4,1,1
);

INSERT INTO Link_To VALUES (
  3,2,1
);

INSERT INTO Link_To VALUES (
  1,3,4
);

INSERT INTO Link_To VALUES (
  2,4,4
);

INSERT INTO Link_To VALUES (
  5,5,5
);

INSERT INTO Uses_Message_Storage VALUES (
  1,
  3,
  1231,
  12,
  513
);

INSERT INTO Uses_Message_Storage VALUES(
  2,
  2,
  23443,
  14,
  553
);

INSERT INTO Uses_Message_Storage VALUES(
  3,
  1,
  12131,
  21,
  463
);

INSERT INTO Uses_Message_Storage VALUES (
  4,
  5,
  9232,
  30,
  345
);

INSERT INTO Uses_Message_Storage VALUES (
  5,
  4,
  2345789,
  18,
  234
);

INSERT INTO Uses_Pubsub_Platform VALUES (
  1,
  1,
  200,
  1000
);

INSERT INTO Uses_Pubsub_Platform VALUES (
  2,
  4,
  100,
  1000
);

INSERT INTO Uses_Pubsub_Platform VALUES (
  3,
  2,
  1000,
  2000
);

INSERT INTO Uses_Pubsub_Platform VALUES (
  4,
  5,
  500,
  3000
);

INSERT INTO Uses_Pubsub_Platform VALUES (
  5,
  3,
  50,
  3000
);

INSERT INTO Streams_To VALUES(
  2, 
  2, 
  0
); 

INSERT INTO Streams_To VALUES(
  2, 
  0, 
  0
); 

INSERT INTO Streams_To VALUES(
  2, 
  3, 
  0
); 

INSERT INTO Streams_To VALUES(
  2, 
  4, 
  0
); 

INSERT INTO Streams_To VALUES(
  1, 
  4, 
  1
); 