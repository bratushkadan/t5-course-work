-- name: GetProductReview :one
SELECT
  r.id,
  r.user_id,
  r.product_id,
  p.name AS "product_name",
  r.rating,
  r.review_text,
  r.created,
  r.modified,
  (u.first_name || u.last_name) AS "user_name"
FROM
  "floral"."review" r
JOIN "floral"."user" u ON r.user_id = u.id
JOIN "floral"."product" p ON r.product_id = p.id
JOIN "floral"."store" s ON p.store_id = s.id
WHERE
  r.id = $1;

-- name: GetProductReviews :many
SELECT
  r.id,
  r.user_id,
  r.product_id,
  p.name AS "product_name",
  r.rating,
  r.review_text,
  r.created,
  r.modified,
  (u.first_name || u.last_name) AS "user_name"
FROM
  "floral"."review" r
JOIN "floral"."user" u ON r.user_id = u.id
JOIN "floral"."product" p ON r.product_id = p.id
JOIN "floral"."store" s ON p.store_id = s.id
WHERE
  (@is_user_id::bool = false OR r.user_id = @user_id)
  AND (@is_product_id::bool = false OR r.product_id = @product_id)
  AND (@is_store_id::bool = false OR s.id = @store_id);

-- name: AddProductReview :one
INSERT INTO
  "floral"."review" (user_id, product_id, rating, review_text)
VALUES
  ($1, $2, $3, $4)
RETURNING id;

-- name: UpdateProductReview :one
UPDATE
  "floral"."review"
SET
  rating = $1,
  review_text = $2,
  modified = NOW()
WHERE
  user_id = $3
  AND product_id = $4
RETURNING id;

-- name: DeleteProductReview :one
DELETE FROM
  "floral"."review"
WHERE
  user_id = $1 AND
  product_id = $2
RETURNING id;

