-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represents artists that has a song in spotify
CREATE TABLE IF NOT EXISTS "artists" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "started" NUMERIC NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY("id")
);

-- Represents tracks in the platform
CREATE TABLE IF NOT EXISTS "tracks" (
    "id" INTEGER,
    "artist_id" INTEGER,
    "album_id" INTEGER,
    "title" TEXT NOT NULL,
    "date" NUMERIC NOT NULL DEFAULT CURRENT_DATE,
    "duration" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("artist_id") REFERENCES "artists"("id"),
    FOREIGN KEY("album_id") REFERENCES "albums"("id")
);

-- Represents genres of a track
CREATE TABLE IF NOT EXISTS "track_genres" (
    "id" INTEGER,
    "track_id" INTEGER,
    "genre_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("track_id") REFERENCES "tracks"("id"),
    FOREIGN KEY("genre_id") REFERENCES "genres"("id")
);

-- Represents genres available in the platform
CREATE TABLE IF NOT EXISTS "genres" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);


-- Represents albums made by an artists
CREATE TABLE IF NOT EXISTS "albums" (
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "date" NUMERIC NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY("id")
);

-- Represents users
CREATE TABLE IF NOT EXISTS "users" (
    "id" INTEGER,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NO NULL,
    "sign_up" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Represents playlists created by a user
CREATE TABLE IF NOT EXISTS "playlists" (
    "id" INTEGER,
    "user_id" INTEGER,
    "name" TEXT,
    "created" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Represents the relationship between users and playlists
CREATE TABLE IF NOT EXISTS "playlist_tracks" (
    "id" INTEGER,
    "playlist_id" INTEGER,
    "track_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("playlist_id") REFERENCES "playlists"("id"),
    FOREIGN KEY("track_id") REFERENCES "tracks"("id")
);

-- Represents favorite artists by a user
CREATE TABLE IF NOT EXISTS "favorites" (
    "id" INTEGER,
    "artist_id" INTEGER,
    "user_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("artist_id") REFERENCES "artists"("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);


-- Represents liked songs by a user
CREATE TABLE IF NOT EXISTS "likes" (
    "id" INTEGER,
    "user_id" INTEGER,
    "track_id" INTEGER,
    "created" NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("track_id") REFERENCES "tracks"("id")
);


-- Create indexes to speed up common queries
CREATE INDEX "artist_name" ON "artists"("name");
CREATE INDEX "track_title" ON "tracks"("name");
CREATE INDEX "album_title" ON "albums"("title");
