local javaDriverManager     = luajava.bindClass("java.sql.DriverManager");
local javaPreparedStatement = luajava.bindClass("java.sql.PreparedStatement");
local javaResultSet         = luajava.bindClass("java.sql.ResultSet");
local serverDB;

-- Init Gettysburg Database
function gbInitDb()

  if serverConfig['database_type'] ~= "mysql" then
    error("Must be MySQL database");
  end

  local mysqlHost = serverConfig['database_mysql_server_ip'];

  if ( mysqlHost == nil or mysqlHost == "" ) then
    mysqlHost = "localhost"
  end

  local mysqlPort = serverConfig['database_mysql_server_port'];

  if ( mysqlPort == nil or mysqlPort == "" ) then
    mysqlPort = 3306
  end

  local mysqlDB = serverConfig['database_mysql_database'];
  local mysqlUser = serverConfig['database_mysql_user'];

  if mysqlUser == nil then
    mysqlUser = ""
  end

  local mysqlPass = serverConfig['database_mysql_password'];

  if mysqlPass == nil then
    mysqlPass = ""
  end

  local dsn = "jdbc:mysql://" .. mysqlHost .. ":" .. mysqlPort .. "/" .. mysqlDB;

  serverLog("Connecting to " .. dsn);

  serverDB = assert(
    javaDriverManager:getConnection(dsn, mysqlUser, mysqlPass),
    "CANT CONNECT TO MYSQL DATABASE"
  );

  serverLog("Init database, if necessary...");

--[[

DROP TABLE FoodHistory;
DROP TABLE ItemHistory;
DROP TABLE BlockHistory;
DROP TABLE RealmChunks;
DROP TABLE RealmCitizens;
DROP TABLE Realms;

]]--

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `Markers` (
      id              INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      x               INT,
      y               INT,
      z               INT
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `Streets` (
      id              INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      name            VARCHAR(40),
      created         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `StreetBlocks` (
      id              INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      streets_id      INT UNSIGNED NOT NULL,
      name            VARCHAR(40),
      start_chunk_x   INT NOT NULL,
      start_chunk_y   INT NOT NULL,
      start_chunk_z   INT NOT NULL,
      start_block_x   INT NOT NULL,
      start_block_y   INT NOT NULL,
      start_block_z   INT NOT NULL,
      end_chunk_x     INT NOT NULL,
      end_chunk_y     INT NOT NULL,
      end_chunk_z     INT NOT NULL,
      end_block_x     INT NOT NULL,
      end_block_y     INT NOT NULL,
      end_block_z     INT NOT NULL,
      created         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (streets_id) REFERENCES Streets(id) ON DELETE CASCADE ON UPDATE CASCADE,
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `Realms` (
      id              INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      name            VARCHAR(40),
      description     VARCHAR(200),
      founder_id      INT,
      mayor_id        INT,
      creator_id      INT,
      created         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (creator_id) REFERENCES Player(id) ON DELETE SET NULL,
      FOREIGN KEY (founder_id) REFERENCES Player(id) ON DELETE SET NULL,
      FOREIGN KEY (mayor_id) REFERENCES Player(id) ON DELETE SET NULL
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `RealmChunks` (
      id              INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      realms_id       INT UNSIGNED NOT NULL,
      x               INT,
      z               INT,
      creator_id      INT,
      created         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (creator_id) REFERENCES Player(id) ON DELETE SET NULL,
      FOREIGN KEY (realms_id) REFERENCES Realms(id) ON DELETE CASCADE ON UPDATE CASCADE,
      CONSTRAINT coordinates UNIQUE (x,z)
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `RealmCitizens` (
      id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      realms_id       INT UNSIGNED NOT NULL,
      citizen_id      INT,
      joined          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (citizen_id) REFERENCES Player(id) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (realms_id) REFERENCES Realms(id) ON DELETE CASCADE ON UPDATE CASCADE,
      CONSTRAINT population UNIQUE (realms_id,citizen_id)
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `FoodHistory` (
      id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      realms_id       INT UNSIGNED,
      food_type       INT NOT NULL,
      food_value      INT NOT NULL,
      player_id       INT NOT NULL,
      consumed        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (player_id) REFERENCES Player(id) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (realms_id) REFERENCES Realms(id) ON DELETE SET NULL
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `ItemHistory` (
      id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      realms_id       INT UNSIGNED,
      item_type_id    SMALLINT NOT NULL,
      texture_id      INT,
      destroyed       TINYINT UNSIGNED DEFAULT 0,
      player_id       INT NOT NULL,
      produced        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (player_id) REFERENCES Player(id) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (realms_id) REFERENCES Realms(id) ON DELETE SET NULL
    );
  ]]);

  gbRawUpdateQuery([[
    CREATE TABLE IF NOT EXISTS `BlockHistory` (
      id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      realms_id       INT UNSIGNED,
      blockid         INT UNSIGNED,
      destroyed       TINYINT UNSIGNED DEFAULT 0,
      player_id       INT NOT NULL,
      produced        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (player_id) REFERENCES Player(id) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (realms_id) REFERENCES Realms(id) ON DELETE SET NULL
    );
  ]]);

end

function gbRawUpdateQuery(sql)
  local stmt = serverDB:prepareStatement(sql);
  return stmt:executeUpdate();
end

  -- local stmt = serverDB:prepareStatement("SELECT `key`, `value` FROM WorldInfos");
  -- local rs = stmt:executeQuery();

  -- serverLog("Loading WorldInfos...");

  -- while rs:next() do

  --   local key   = rs:getString("key");
  --   local value = rs:getString("value");

  --   serverLog(key .. " = " .. value);

  -- end
