## task

|カラム名||データ型|
| ------------- | ------------- |
| name  | string |
| user_id  | references  |
| content  | string |
| limit  | date |
|  status | string |
| priority  | integer  |

## user

|カラム名||データ型|
| ------------- | ------------- |
| name  | string  |
| email | string  |
| password_digest | string |


## label

|カラム名||データ型|
| ------------- | ------------- |
| name  | string |

## labeling

|カラム名||データ型|
| ------------- | ------------- |
| task_id  | references |
| label_id |references |
