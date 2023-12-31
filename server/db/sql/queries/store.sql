-- https://docs.sqlc.dev/en/stable/howto/query_count.html

-- name: GetStore :one
SELECT
  id, name, email, phone_number, created
FROM
  "floral"."store"
WHERE
  id = $1;

-- name: GetStores :many
SELECT
  id, name, email, phone_number, created
FROM
  "floral"."store";

-- name: GetStoreCreds :one
SELECT
  id, password
FROM
  "floral"."store"
WHERE
  email = $1;

-- name: AddStore :one
INSERT INTO
  "floral"."store" (name, email, password, phone_number)
VALUES
  ($1, $2, $3, $4)
RETURNING id, name, email, phone_number, created;

-- name: DeleteStore :one
DELETE FROM
  "floral"."store"
WHERE
  id = $1 AND password = $2
RETURNING *;
