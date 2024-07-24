-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Find all tracks given an artist name
SELECT *
FROM "tracks"
WHERE "artist_id" = (
    SELECT "id" 
    FROM "artists"
    WHERE "name" = "The Killers"
);

-- Find all tracks given an album name
SELECT * 
FROM "tracks"
WHERE "album_id" = (
    SELECT "id" 
    FROM "albums"
    WHERE "title" = "Hot Fuss"
);

-- Find all tracks given a genre
SELECT * 
FROM "tracks" t
JOIN "track_genres" tg ON tg."genre_id" = t."id"
WHERE tg."genre_id" = (
    SELECT "id"
    FROM "genres"
    WHERE "name" = "Rock"
);

-- Find all artist that a user is following
SELECT 
    u."username" AS "user_name",
    a."name" AS "artist_name"
FROM "users" u
JOIN "favorites" f ON f."user_id" = u."id"
JOIN "artists" a ON f."artist_id" = f."artist_id"
ORDER BY "user_name";

-- Find a user by name and all the tracks they have liked
SELECT
    u."username" AS "user_name",
    t."title" AS "track_title"
FROM "users" u
JOIN "likes" l ON u."id" = l."user_id"
JOIN "tracks" t ON t."id" = l."track_id"
WHERE "user_name" = (
    SELECT "username" FROM "users" WHERE "username" = "rock_music_fan"
);


-- Find the top 5 followed artists
SELECT 
    a."name",
    COUNT(u."id") AS follower_count
FROM "artists" a
JOIN "favorites" f ON f."artist_id" = a."id"
JOIN "users" u ON u."id" = f."user_id"
GROUP BY a."id"
ORDER BY follower_count DESC
LIMIT 5;


-- Find the top 5 liked song
SELECT 
    t."title" AS "track_title",
    COUNT(u."id") AS like_count
FROM "tracks" t
JOIN "likes" l ON l."track_id" = t."id"
JOIN "users" u ON u."id" = l."user_id"
GROUP BY t."id"
ORDER BY like_count DESC
LIMIT 5;

-- Add a new artist
INSERT INTO "artists" ("name")
VALUES ("The Killers");

-- Add a new album
INSERT INTO "albums" ("title", "date")
VALUES ("Hot Fuss", "2004");

-- Add a new tracks
INSERT INTO "tracks" ("title", "duration", "artist_id")
VALUES ("Mr. Brightside", 223, 1);

-- Add a new genre
INSERT INTO "genres" ("name")
VALUES ("Rock");

-- Add a genre to a song
INSERT INTO "track_genres" ("track_id", "genre_id")
VALUES(3, 1);