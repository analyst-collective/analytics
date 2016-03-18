/*

This analysis produces a list of products that includes their:
 - sku
 - The Product's Name
 - Quantity Ordered
 - Total Revenue (Price times quantity)
 - Total Cost (cost times quantity)
 - The Product's cost to the store
 - The Product's price to the customer
 - The Profit Margin
 - The Total Profit

*/

with products as (

  select * from {{env.schema}}.magento_products

)

with order_items as (

  select * from {{env.schema}}.magento_order_items

)

SELECT
  products.sku,
  products.name,
  count(order_items.item_id) as "Quantity",
  SUM(order_items.base_price) as "Total Revenue",
  products.cost * count(order_items.item_id) as "Total Cost",
  products.cost as "Item cost",
  base_price as "price",
  1 - (products.cost / base_price) as "profit margin",
  SUM(order_items.base_price) - (products.cost * count(order_items.item_id)) as "profit"
FROM {{env.schema}}.magento_order_items
RIGHT JOIN {{env.schema}}.magento_catalog_product_flat_1 as products
ON products.entity_id = order_items.product_id
GROUP BY products.name, order_items.base_price
ORDER BY count(order_items.item_id) desc;
