FactoryBot.define do
  factory :task do
    name { 'タイトル１' }
    content { 'コンテント１' }
    limit {'2021-11-16'}
    status {'着手中'}
    priority {'高'}
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'タイトル２' }
    content { 'コンテント２' }
    limit {'2021-10-16'}
    status {'未着手'}
    priority {'中'}
  end
end
