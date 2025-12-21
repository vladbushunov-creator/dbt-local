select
tx.hash_key
, tx.block_number
, tx.block_timestamp
, tx.is_coinbase
, f.value:address::STRING as output_address
, f.value:value::FLOAT as output_value

from {{ ref('stg_btc') }} as tx,

LATERAL FLATTEN(input => outputs) f

where f.value:value is not null
