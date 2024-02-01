with source as (
    select * from public.suppliers
), split_contact_name as(
    select supplier_id, company_name, split_part(contact_name, ' ', 1) as contact_first_name,
    split_part(contact_name, ' ', 2) as contact_last_name, contact_title, address, city, region,
    postal_code, country, phone, fax, homepage from source
), clean_phone_number as(
    select translate(phone, '(,),-,., ', '') as phone, supplier_id, company_name, contact_first_name,
    contact_last_name, contact_title, address, city, region,
    postal_code, country, fax, homepage from split_contact_name
), final as(
    select supplier_id, 
    CASE
        WHEN length(phone) = 10 THEN   '(' || SUBSTRING(phone FROM 1 FOR 3) || ') ' ||
                                        SUBSTRING(phone FROM 4 FOR 3) || '-' ||
                                        SUBSTRING(phone FROM 7 FOR 3) 
        ELSE NULL
    END as phone,
    company_name, contact_first_name,
    contact_last_name, contact_title, address, city, region,
    postal_code, country, fax, homepage  from clean_phone_number
)
select * from final