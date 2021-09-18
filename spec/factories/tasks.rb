FactoryBot.define do
  factory :task do
    name { 'タイトル１' }
    content { 'コンテント１' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'タイトル２' }
    content { 'コンテント２' }
  end
end
