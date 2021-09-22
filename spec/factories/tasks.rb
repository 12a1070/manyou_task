FactoryBot.define do
  factory :task do
    name { 'name' }
    content { 'content1' }
    limit { DateTime.now + 15}
    status {'着手中'}
    priority {'高'}
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'name２' }
    content { 'content2' }
    limit { DateTime.now +20 }
    status {'未着手'}
    priority {'中'}
  end
end
