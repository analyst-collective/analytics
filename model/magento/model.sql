create or replace view {{env.schema}}.magento_order_items as (

  select *
  FROM
    sample_magento_database.sales_flat_order_item

);


create or replace view {{env.schema}}.magento_products as (

    select *
    FROM
      sample_magento_database.catalog_product_flat_1

);
