with source as (
    select * from public.shippers
), final as (
    select shipper_id, company_name from source
)

select * from final