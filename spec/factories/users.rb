FactoryBot.define do

# 管理者作成
  factory :admin_user,class: User do
    name { "テスト1" }
    email { "admin1@example.com" }
    password { "admin1@example.com" }
    password_confirmation{"admin1@example.com"}
    admin{true}
  end

# 一般ユーザ作成
  factory :normal_user,class: User do
    name {'test2@mail.com'}
    email{'test2@mail.com'}
    password{'test2@mail.com'}
    password_confirmation{'test2@mail.com'}
    admin{false}
  end
end
