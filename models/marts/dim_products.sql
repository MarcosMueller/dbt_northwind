with
    products as (
        select
            {{ dbt_utils.generate_surrogate_key(["product_id", "product_name"]) }}
            as sk_product
            , *
        from {{ ref("stg_products") }}
    )
    , categories as (
        select * 
        from {{ ref("dim_categories") }})
    , suppliers as (
        select * 
        from {{ ref("dim_suppliers") }})

select categories.sk_category
    , suppliers.sk_supplier
    , products.*
from products
left join categories on products.category_id = categories.category_id
left join suppliers on products.supplier_id = suppliers.supplier_id
