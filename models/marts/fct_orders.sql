with
    customers as (
        select *
        from {{ ref("dim_customers")}}
    )

    , orders as (
        select
            {{dbt_utils.generate_surrogate_key(['order_id', 'customer_id'])}} as sk_order
            , *
        from {{ ref("stg_orders")}}
    )

    select
        customers.sk_customer
        , orders.*
    from orders
    left join customers on orders.customer_id = customers.customer_id
