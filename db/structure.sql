GRANT ALL PRIVILEGES ON DATABASE odin_db TO odin;

\connect odin_db;

CREATE TABLE IF NOT EXISTS chat(
  id INT GENERATED ALWAYS AS IDENTITY,
  uuid VARCHAR(100) UNIQUE not null
);

CREATE TABLE IF NOT EXISTS chat_message(
    id INT GENERATED ALWAYS AS IDENTITY,
    uuid VARCHAR(100) UNIQUE not null,
    chat_uuid VARCHAR(100) not null,
    tool_call VARCHAR(25) not null,
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