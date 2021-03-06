DROP DATABASE SOAPBOX;

CREATE DATABASE `SOAPBOX`
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE UTF8_UNICODE_CI;
USE SOAPBOX;

CREATE TABLE SOAPBOX.BASKETDEFINITION (
  id            BIGINT NOT NULL AUTO_INCREMENT,
  ProductId     VARCHAR(50),
  OwnedCarTrans VARCHAR(21000),
  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.CUSTOMCAR (
  id                    BIGINT NOT NULL AUTO_INCREMENT,
  BaseCarId             BIGINT,
  CarClassHash          INT,
  IsPreset              BOOLEAN,
  Level                 INT,
  `Name`                VARCHAR(255),
  ApiId                 BIGINT,
  Paints                VARCHAR(1500),
  PerformanceParts      VARCHAR(1000),
  PhysicsProfileHash    BIGINT,
  Rating                INT,
  ResalePrice           INT,
  SkillModParts         VARCHAR(1000),
  SkillModSlotCount     SMALLINT,
  Vinyls                VARCHAR(15000),
  VisualParts           VARCHAR(1000),
  IdParentOwnedCarTrans BIGINT,
  PRIMARY KEY (id),
  INDEX FK1x37o50wbwj5o7wj99ouj91om (IdParentOwnedCarTrans)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.EVENTDEFINITION (
  eventId                          BIGINT NOT NULL,
  carClassHash                     INT,
  coins                            INT,
  engagePointX                     FLOAT,
  engagePointY                     DOUBLE,
  engagePointZ                     DOUBLE,
  eventLocalization                INT,
  eventModeDescriptionLocalization INT,
  eventModeIcon                    VARCHAR(255),
  eventModeId                      INT,
  eventModeLocalization            INT,
  isEnabled                        VARCHAR(255),
  isLocked                         VARCHAR(255),
  laps                             INT,
  length                           INT,
  maxClassRating                   INT,
  maxEntrants                      INT,
  maxLevel                         INT,
  minClassRating                   INT,
  minEntrants                      INT,
  minLevel                         INT,
  regionLocalization               INT,
  rewardMode1                      INT,
  rewardMode2                      INT,
  rewardMode3                      INT,
  timeLimit                        INT,
  trackLayoutMap                   VARCHAR(255),
  trackLocalization                INT,
  PRIMARY KEY (eventId)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.EVENTDATA (
  id                BIGINT NOT NULL AUTO_INCREMENT,
  carId             BIGINT,
  eventDurationInMS BIGINT,
  eventId           BIGINT,
  eventLaunched     BOOLEAN         DEFAULT FALSE,
  eventMode         INT,
  eventSessionId    BIGINT,
  finishReason      INT,
  isSinglePlayer    BOOLEAN,
  perfectStart      BOOLEAN,
  personaId         BIGINT,
  rank              SMALLINT,
  topSpeed          FLOAT,
  bestLapTimeInMS   BIGINT,
  bustedCount       INT,
  copsDeployed      INT,
  copsDisabled      INT,
  copsRammed        INT,
  costToState       INT,
  distanceToFinish  FLOAT,
  fractionCompleted FLOAT,
  infractions       INT,
  roadBlocksDodged  INT,
  spikeStripsDodged INT,
  PRIMARY KEY (id),
  INDEX FKj264c6h4qbwmdsnyrfk2g34hu (eventId)
)
  ENGINE = INNODB;


CREATE TABLE SOAPBOX.LOBBY (
  id                 BIGINT NOT NULL AUTO_INCREMENT,
  isInviteEnabled    BIT    NOT NULL,
  isWaiting          BIT    NOT NULL,
  lobbyDateTimeStart DATETIME,
  EVENTID            BIGINT,
  PRIMARY KEY (id),
  INDEX FKkp0v4ai7na2gt3wb07sgqptjk (EVENTID)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.LOBBYENTRANT (
  id        BIGINT NOT NULL AUTO_INCREMENT,
  LOBBYID   BIGINT,
  PERSONAID BIGINT,
  gridIndex INT             DEFAULT '0',
  PRIMARY KEY (id),
  INDEX FKb16m56d4hbm4dsnhrjkbg5ihu (LOBBYID),
  INDEX FK18nhfrj2phl91fsmt3t9oegcr (PERSONAID)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.OWNEDCAR (
  Durability     SMALLINT,
  ExpirationDate VARCHAR(255),
  HeatLevel      SMALLINT,
  UniqueCarId    BIGINT NOT NULL AUTO_INCREMENT,
  OwnershipType  VARCHAR(255),
  PersonaId      BIGINT,
  PRIMARY KEY (UniqueCarId),
  INDEX FKqgmirqm1js3v66oxvwungafsx (PersonaId)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.PERSONA (
  ID                BIGINT NOT NULL AUTO_INCREMENT,
  BADGES            TEXT,
  CASH              INT,
  CURCARINDEX       INT,
  ICONINDEX         INT,
  LEVEL             INT,
  MOTTO             VARCHAR(60),
  `NAME`            VARCHAR(50),
  PERCENTTOLEVEL    FLOAT,
  RATING            FLOAT,
  REP               FLOAT,
  REPATCURRENTLEVEL FLOAT,
  SCORE             FLOAT,
  USERID            BIGINT,
  PRIMARY KEY (ID),
  INDEX FKon9k3f1y35051t3y7x6ogd6k7 (USERID)
)
  ENGINE = INNODB;

ALTER TABLE SOAPBOX.PERSONA
  AUTO_INCREMENT = 100;

CREATE TABLE SOAPBOX.PRODUCT (
  id              BIGINT NOT NULL AUTO_INCREMENT,
  bundleItems     VARCHAR(255),
  categoryId      VARCHAR(255),
  categoryName    VARCHAR(255),
  currency        VARCHAR(255),
  description     VARCHAR(255),
  durationMinute  INT    NOT NULL,
  hash            BIGINT NOT NULL,
  icon            VARCHAR(255),
  level           INT    NOT NULL,
  longDescription VARCHAR(255),
  price           FLOAT  NOT NULL,
  priority        INT    NOT NULL,
  productId       VARCHAR(255),
  productTitle    VARCHAR(255),
  productType     VARCHAR(255),
  secondaryIcon   VARCHAR(255),
  useCount        INT    NOT NULL,
  visualStyle     VARCHAR(255),
  webIcon         VARCHAR(255),
  webLocation     VARCHAR(255),
  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.USER (
  ID       BIGINT NOT NULL AUTO_INCREMENT,
  EMAIL    VARCHAR(255),
  PASSWORD VARCHAR(41),
  PRIMARY KEY (ID)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.CATEGORY (
  idcategory           BIGINT       NOT NULL AUTO_INCREMENT,
  catalogVersion       VARCHAR(45)  NOT NULL,
  categories           VARCHAR(45)  NULL,
  displayName          VARCHAR(255) NULL,
  filterType           INT          NOT NULL,
  icon                 VARCHAR(45)  NULL,
  id                   BIGINT       NOT NULL,
  longDescription      VARCHAR(45)  NULL,
  `name`               VARCHAR(255) NOT NULL,
  priority             SMALLINT     NOT NULL,
  shortDescription     VARCHAR(45)  NULL,
  showInNavigationPane BOOLEAN      NOT NULL,
  showPromoPage        BOOLEAN      NOT NULL,
  webIcon              VARCHAR(45)  NULL,
  PRIMARY KEY (idcategory)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.VINYLPRODUCT (
  id               BIGINT NOT NULL AUTO_INCREMENT,
  bundleItems      VARCHAR(255),
  categoryId       VARCHAR(255),
  categoryName     VARCHAR(255),
  currency         VARCHAR(255),
  description      VARCHAR(255),
  durationMinute   INT    NOT NULL,
  hash             BIGINT NOT NULL,
  icon             VARCHAR(255),
  level            INT    NOT NULL,
  longDescription  VARCHAR(255),
  price            FLOAT  NOT NULL,
  priority         INT    NOT NULL,
  productId        VARCHAR(255),
  productTitle     VARCHAR(255),
  productType      VARCHAR(255),
  secondaryIcon    VARCHAR(255),
  useCount         INT    NOT NULL,
  visualStyle      VARCHAR(255),
  webIcon          VARCHAR(255),
  webLocation      VARCHAR(255),
  parentCategoryId BIGINT,
  PRIMARY KEY (id),
  INDEX FKz6mi4qm1jsgv66yxv3unga2sx (parentCategoryId)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.ACHIEVEMENTDEFINITION (
  id                 BIGINT       NOT NULL AUTO_INCREMENT,
  friendlyIdentifier VARCHAR(200) NOT NULL,
  isVisible          BOOLEAN,
  badgeDefinitionId  BIGINT       NOT NULL,
  progressText       TEXT,
  statConversion     VARCHAR(400),

  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.ACHIEVEMENTRANK (
  id                BIGINT NOT NULL AUTO_INCREMENT,
  achievementId     BIGINT NOT NULL,
  isRare            BOOLEAN,
  points            INT,
  rank              INT,
  rewardDescription TEXT,
  rewardType        VARCHAR(200),
  rewardVisualStyle VARCHAR(300),
  thresholdValue    INT,

  PRIMARY KEY (id),
  FOREIGN KEY (achievementId) REFERENCES ACHIEVEMENTDEFINITION (id)
    ON DELETE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.PERSONAACHIEVEMENT (
  id            BIGINT  NOT NULL AUTO_INCREMENT,
  personaId     BIGINT  NOT NULL,
  achievementId BIGINT  NOT NULL,
  currentValue  BIGINT  NOT NULL DEFAULT 0,
  canProgress   BOOLEAN NOT NULL DEFAULT TRUE,

  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.PERSONAACHIEVEMENTRANK (
  id            BIGINT NOT NULL AUTO_INCREMENT,
  personaId     BIGINT NOT NULL,
  achievementId BIGINT NOT NULL,
  rankId        BIGINT NOT NULL,
  state         VARCHAR(255),
  achievedOn    TEXT,

  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.BADGEDEFINITION (
  id          BIGINT NOT NULL AUTO_INCREMENT,
  background  TEXT,
  border      TEXT,
  description TEXT,
  icon        TEXT,
  `name`      TEXT,

  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.ACHIEVEMENTREWARD (
  id            BIGINT NOT NULL AUTO_INCREMENT,
  achievementId BIGINT NOT NULL,
  rewards       LONGTEXT,

  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE SOAPBOX.PERSONAINVENTORY (
  id                            BIGINT NOT NULL AUTO_INCREMENT,
  personaId                     BIGINT NOT NULL,
  performancePartsCapacity      INT             DEFAULT 150,
  performancePartsUsedSlotCount INT             DEFAULT 0,
  skillModPartsCapacity         INT             DEFAULT 200,
  skillModPartsUsedSlotCount    INT             DEFAULT 0,
  visualPartsCapacity           INT             DEFAULT 300,
  visualPartsUsedSlotCount      INT             DEFAULT 0,

  PRIMARY KEY (id)
)
  ENGINE = INNODB;
CREATE TABLE SOAPBOX.PERSONAINVENTORYITEM (
  id                BIGINT       NOT NULL AUTO_INCREMENT,
  inventoryId       BIGINT       NOT NULL,
  personaId         BIGINT       NOT NULL,

  entitlementTag    VARCHAR(400),
  expirationDate    VARCHAR(250) NULL,
  hash              BIGINT       NOT NULL,
  productId         VARCHAR(250),
  remainingUseCount INT,
  resalePrice       FLOAT,
  status            VARCHAR(250),
  stringHash        VARCHAR(250),
  virtualItemType   VARCHAR(250),

  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE `SOAPBOX`.TREASUREHUNTSESSION (
  id        BIGINT NOT NULL AUTO_INCREMENT,
  personaId BIGINT NOT NULL,
  coinsCollected BIGINT NOT NULL,
  seed BIGINT NOT NULL,
  isStreakBroken BIT NOT NULL,
  streak BIGINT NOT NULL,

  PRIMARY KEY (id)
)
  ENGINE = INNODB;

ALTER TABLE SOAPBOX.CUSTOMCAR
  ADD CONSTRAINT FK1x37o50wbwj5o7wj99ouj91om FOREIGN KEY (IdParentOwnedCarTrans) REFERENCES SOAPBOX.OWNEDCAR (UniqueCarId);
ALTER TABLE SOAPBOX.EVENTDATA
  ADD CONSTRAINT FKj264c6h4qbwmdsnyrfk2g34hu FOREIGN KEY (eventId) REFERENCES SOAPBOX.EVENTDEFINITION (eventId);
ALTER TABLE SOAPBOX.LOBBY
  ADD CONSTRAINT FKkp0v4ai7na2gt3wb07sgqptjk FOREIGN KEY (EVENTID) REFERENCES SOAPBOX.EVENTDEFINITION (eventId);
ALTER TABLE SOAPBOX.LOBBYENTRANT
  ADD CONSTRAINT FK18nhfrj2phl91fsmt3t9oegcr FOREIGN KEY (PERSONAID) REFERENCES SOAPBOX.PERSONA (ID);
ALTER TABLE SOAPBOX.LOBBYENTRANT
  ADD CONSTRAINT FKb16m56d4hbm4dsnhrjkbg5ihu FOREIGN KEY (LOBBYID) REFERENCES SOAPBOX.LOBBY (id);
ALTER TABLE SOAPBOX.OWNEDCAR
  ADD CONSTRAINT FKqgmirqm1js3v66oxvwungafsx FOREIGN KEY (PersonaId) REFERENCES SOAPBOX.PERSONA (ID);
ALTER TABLE SOAPBOX.PERSONA
  ADD CONSTRAINT FKon9k3f1y35051t3y7x6ogd6k7 FOREIGN KEY (USERID) REFERENCES SOAPBOX.USER (ID);
ALTER TABLE SOAPBOX.VINYLPRODUCT
  ADD CONSTRAINT FKz6mi4qm1jsgv66yxv3unga2sx FOREIGN KEY (parentCategoryId) REFERENCES SOAPBOX.CATEGORY (idcategory);

CREATE INDEX basketdefinition_index
  ON SOAPBOX.BASKETDEFINITION (productId) USING HASH;
CREATE INDEX eventdata_index
  ON SOAPBOX.EVENTDATA (eventId, eventMode, eventSessionId, isSinglePlayer, personaId, rank) USING HASH;
CREATE INDEX eventdefinition_index
  ON SOAPBOX.EVENTDEFINITION (eventId, carClassHash, isEnabled, isLocked, minClassRating, minLevel) USING HASH;
CREATE INDEX persona_index
  ON SOAPBOX.PERSONA (userid, name) USING HASH;
CREATE INDEX user_index
  ON SOAPBOX.USER (email, password) USING HASH;
CREATE INDEX ownedcar_index
  ON SOAPBOX.OWNEDCAR (uniqueCarId) USING HASH;
CREATE INDEX product_index
  ON SOAPBOX.PRODUCT (categoryId, categoryName, hash, productType) USING HASH;
CREATE INDEX vinylproduct_index
  ON SOAPBOX.VINYLPRODUCT (categoryName, hash) USING HASH;
