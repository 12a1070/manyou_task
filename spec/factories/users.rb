FactoryBot.define do

# 管理者作成
  factory :admin_user,class: User do
    name { "admin_name" }
    email { "admin@mail.com" }
    password { "password1" }
    password_confirmation{"password1"}
    admin{true}
  end

# 一般ユーザ作成
  factory :normal_user,class: User do
    name {'normal_name'}
    email{'normal@mail.com'}
    password{'password2'}
    password_confirmation{'password2'}
    admin{false}
  end
end
