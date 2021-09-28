FactoryBot.define do
  factory :task do
    name { 'name1' }
    content { 'content1' }
    limit { DateTime.now + 15}
    status {'着手中'}
    priority {'高'}
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'name2' }
    content { 'content2' }
    limit { DateTime.now +20 }
    status {'未着手'}
    priority {'中'}
  end

  factory :third_task, class: Task do
    name { 'name3' }
    content { 'content3' }
    limit { DateTime.now +20 }
    status {'完了'}
    priority {'低'}
  end
end
