FactoryBot.define do
  factory :label, class: Label do
    name { "label_name1" }
  end

  factory :label2, class: Label do
    name{"label_name2"}
  end

  factory :label3, class: Label do
    name{"label_name3"}
  end

end
