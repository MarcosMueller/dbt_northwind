with
    orders as (
        select *
        from {{ ref("fct_orders")}}
    )

    , products as (
        select *
        from {{ ref("dim_products")}}
    )

    , order_details as (
        select *
        from {{ ref("stg_order_details")}}

    )

select
    products.sk_product
    , orders.sk_order
    , order_details.*
from order_details
left join orders on orders.order_id = order_details.order_id
left join products on products.product_id = order_details.product_id
