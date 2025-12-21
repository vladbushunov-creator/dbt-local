{{ config(materialized='incremental', incremental_strategy='merge', unique_key='HASH_KEY') }}


select *
from {{ source('btc', 'btc') }}

{% if is_incremental() %}

where BLOCK_TIMETSAMP >= (select max(BLOCK_TIMETSAMP) from {{ this }})

{% endif %}
