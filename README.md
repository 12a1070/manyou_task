## tasksテーブル

|カラム名||データ型|
| ------------- | ------------- |
| name  | string  |
| content  | string  |
| limit  | date  |
| status  | string  |
|  priority | integer  |
| status  | string  |


## usersテーブル

|カラム名||データ型|
| ------------- | ------------- |
| name  | string  |
| email | string  |
| password_digest | string |
| admin | boolean |


## labelsテーブル

|カラム名||データ型|
| ------------- | ------------- |
| task_id  | references |
| label_id |references |
