with source as (
    select * from public.customers
),

renamed as (
    select customer_id, country,
    split_part(contact_name, ' ', 1) as first_name,
    split_part(contact_name, ' ', 2) as last_name
    from source
)

select * from renamed