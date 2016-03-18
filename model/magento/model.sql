create or replace view {{env.schema}}.magento_order_items as (

  select *
  FROM
    magento.sales_flat_order_item

);


create or replace view {{env.schema}}.magento_products as (

    select *
    FROM
      magento.catalog_product_flat_1

);
