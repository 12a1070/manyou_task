## task

|カラム名            |データ型      |
| ----|-----       |
| name              | string     |
| user_id           | references |
| content           | string     |
| limit             | date       |
|  status           | integer     |
| priority          | integer    |

## user

|カラム名            |データ型      |
| ------------------|-----       |
| name              | string     |
| email             | string     |
| password_digest   | string     |


## label

|カラム名            |データ型  |
|------------------ |-----   |
| name              | string |

## labeling

|カラム名   |データ型         |
| ---------|-----          |
| task_id  | references    |
| label_id |references     |

<br>
<br>

## Herokuへのデプロイ方法

1. Heroku CLIのインストールする
```
brew tap heroku/brew && brew install heroku
```

2. Herokuにログイン
```
heroku login
```

3. ~/workspace/○○_appに位置していることを確認する

4. Herokuに新しいアプリケーションを作成する
(heroku-20では、Ruby2.6.5がサポートの対象外なのでheroku-18で行う)
```
$ heroku create --remote heroku-18 --stack heroku-18
```

5. アセットプリコンパイルのコード
```
$ rails assets:precompile RAILS_ENV=production
```

6. コミットする
```
$ git add -A
あるいは
$ git add .
$ git commit -m "コミット内容"
```

7. Heroku buildpackを追加する
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

8. Herokuにデプロイする
```
$ git push heroku-18 master
（ブランチをheroku masterにデプロイする場合）
$ git push heroku-18 ブランチ名:master
```

9. データベースの移行をする
```
$ heroku run rails db:migrate
```
