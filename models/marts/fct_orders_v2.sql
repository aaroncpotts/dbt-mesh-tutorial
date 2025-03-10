with orders as (
    select * from {{ ref('int_orders') }}
),
/* This is BigQuery, so we have to use their super special EXTRACT function because they're special*/
final as (
    select 
        order_id,
        location_id,
        customer_id,
        order_total as order_amount,
        tax_paid,
        ordered_at,
        customer_name,
        location_name,
        tax_rate,
        cast(location_opened_at as date) as location_opened_at,
        EXTRACT(month FROM ordered_at) as ordered_month,
        EXTRACT(day FROM ordered_at) as ordered_day, 
        EXTRACT(year FROM ordered_at) as ordered_year
    from orders
)

select * 
from final