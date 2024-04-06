GRANT ALL PRIVILEGES ON DATABASE odin_db TO odin;

\connect odin_db;

CREATE TABLE IF NOT EXISTS user (
  id INT GENERATED ALWAYS AS IDENTITY,
  uuid VARCHAR(100) UNIQUE not null,
  email VARCHAR(100) UNIQUE not null,
)

CREATE TABLE IF NOT EXISTS user_site (
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE not null,
   site_name VARCHAR(100) UNIQUE NOT NULL,
   site_description TEXT NOT NULL,
   site_url TEXT NOT NULL
   user_uuid VARCHAR(100) not null,

   CONSTRAINT fk_user
        FOREIGN KEY(user_uuid)
        REFERENCES user(uuid)
        ON DELETE CASCADE
)

CREATE TABLE IF NOT EXISTS user_site_route (
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE not null,
   route_url TEXT NOT NULL,
   route_description TEXT NOT NULL,
   user_site_uuid VARCHAR(100) not null,

   CONSTRAINT fk_user_site
        FOREIGN KEY(user_site_uuid)
        REFERENCES user_site(uuid)
        ON DELETE CASCADE
)

CREATE TABLE IF NOT EXISTS chat (
  id INT GENERATED ALWAYS AS IDENTITY,
  uuid VARCHAR(100) UNIQUE not null,
  user_site_uuid VARCHAR(100) not null,

   CONSTRAINT fk_user_site
        FOREIGN KEY(user_site_uuid)
        REFERENCES user_site(uuid)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chat_message(
    id INT GENERATED ALWAYS AS IDENTITY,
    uuid VARCHAR(100) UNIQUE not null,
    chat_uuid VARCHAR(100) not null,
    tool_call TEXT,
    content TEXT,
    chat_role VARCHAR(100) not null,

    CONSTRAINT fk_chat
        FOREIGN KEY(chat_uuid)
        REFERENCES chat(uuid)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS run (
    id INT GENERATED ALWAYS AS IDENTITY,
    uuid VARCHAR(100) UNIQUE not null,
    running_status VARCHAR(100) not null,
    chat_uuid VARCHAR(100) not null,

    CONSTRAINT fk_chat
        FOREIGN KEY(chat_uuid)
        REFERENCES chat(uuid)
        ON DELETE CASCADE
);