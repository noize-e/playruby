### SinatraApp Table Schema

SingleTable Model Design

|             | Partion Key    | Sort Key       | GSI (HASH)  | GSI (RANGE)       |
|:------------|:---------------|:---------------|:------------|:------------------|
| primary_key | __id__: string | __sk__: string |             |                   |
| sk_index    |                |                | __sk__      |                   |
| email_index |                |                | __sk__      | __email__: string |
