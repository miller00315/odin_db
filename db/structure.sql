GRANT ALL PRIVILEGES ON DATABASE odin_db TO odin;

\connect odin_db;

 CREATE TABLE user_ (
  id INT GENERATED ALWAYS AS IDENTITY,
  uuid VARCHAR(100) UNIQUE NOT NULL,
  user_email VARCHAR(100) UNIQUE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE api_key ( 
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE NOT NULL,
   user_uuid VARCHAR(100) NOT NULL,
   created_at TIMESTAMP WITH TIME ZONE NOT NULL,

   CONSTRAINT fk_user_table
        FOREIGN KEY(user_uuid)
        REFERENCES user_(uuid)
        ON DELETE CASCADE     
);

CREATE TABLE user_site (
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE NOT NULL,
   site_name VARCHAR(100) UNIQUE NOT NULL,
   site_description TEXT NOT NULL,
   site_url TEXT NOT NULL,
   user_uuid VARCHAR(100) NOT NULL,
   created_at TIMESTAMP WITH TIME ZONE NOT NULL,

   CONSTRAINT fk_user_table
        FOREIGN KEY(user_uuid)
        REFERENCES user_(uuid)
        ON DELETE CASCADE 
);

CREATE TABLE user_site_route (
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE NOT NULL,
   route_url TEXT NOT NULL,
   route_description TEXT NOT NULL,
   user_site_uuid VARCHAR(100) NOT NULL,
   created_at TIMESTAMP WITH TIME ZONE NOT NULL,

   CONSTRAINT fk_user_site
        FOREIGN KEY(user_site_uuid)
        REFERENCES user_site(uuid)
        ON DELETE CASCADE
);

CREATE TABLE api_access(
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE NOT NULL,
   api_access_description TEXT,
   api_access_method VARCHAR(100) UNIQUE NOT NULL,
   api_access_path VARCHAR(100) UNIQUE NOT NULL,
   user_site_route_uuid VARCHAR(100) NOT NULL,
   created_at TIMESTAMP WITH TIME ZONE NOT NULL,

   CONSTRAINT fk_user_site_route
        FOREIGN KEY(user_site_route_uuid)
        REFERENCES user_site_route(uuid)
        ON DELETE CASCADE
);

CREATE TABLE api_access_parameter(
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE NOT NULL,
   parameter_type VARCHAR(100) UNIQUE NOT NULL,
   parameter_name VARCHAR(100) UNIQUE NOT NULL,
   api_access_uuid VARCHAR(100) UNIQUE NOT NULL,
   created_at TIMESTAMP WITH TIME ZONE NOT NULL,

   CONSTRAINT fk_api_access
        FOREIGN KEY(api_access_uuid)
        REFERENCES api_access(uuid)
        ON DELETE CASCADE
);


CREATE TABLE user_site_route_scrap(
   id INT GENERATED ALWAYS AS IDENTITY,
   uuid VARCHAR(100) UNIQUE NOT NULL,
   item_id VARCHAR(100),
   css_class VARCHAR(100),
   function_on_the_page VARCHAR(100),
   parent_uuid VARCHAR(100),
   title TEXT,
   content TEXT,
   scrap_description TEXT NOT NULL,
   user_site_route_uuid VARCHAR(100) NOT NULL,
   created_at TIMESTAMP WITH TIME ZONE NOT NULL,

   CONSTRAINT fk_user_site
        FOREIGN KEY(user_site_route_uuid)
        REFERENCES user_site_route(uuid)
        ON DELETE CASCADE,

   CONSTRAINT fk_user_site_route_scrap
        FOREIGN KEY(parent_uuid)
        REFERENCES user_site_route_scrap(uuid)
        ON DELETE SET NULL
);

CREATE TABLE chat (
  id INT GENERATED ALWAYS AS IDENTITY,
  uuid VARCHAR(100) UNIQUE NOT NULL,
  user_site_uuid VARCHAR(100) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL,

   CONSTRAINT fk_user_site
        FOREIGN KEY(user_site_uuid)
        REFERENCES user_site(uuid)
        ON DELETE CASCADE
);

CREATE TABLE chat_message(
    id INT GENERATED ALWAYS AS IDENTITY,
    uuid VARCHAR(100) UNIQUE NOT NULL,
    chat_uuid VARCHAR(100) NOT NULL,
    tool_call TEXT,
    content TEXT,
    chat_role VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,

    CONSTRAINT fk_chat
        FOREIGN KEY(chat_uuid)
        REFERENCES chat(uuid)
        ON DELETE CASCADE
);

CREATE TABLE run (
    id INT GENERATED ALWAYS AS IDENTITY,
    uuid VARCHAR(100) UNIQUE NOT NULL,
    running_status VARCHAR(100) NOT NULL,
    chat_uuid VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,

    CONSTRAINT fk_chat
        FOREIGN KEY(chat_uuid)
        REFERENCES chat(uuid)
        ON DELETE CASCADE
);