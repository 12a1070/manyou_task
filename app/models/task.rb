class Task < ApplicationRecord

    belongs_to :user

    validates :name, presence: true
    validates :content, presence: true

    enum priority:{高:0,中:1,低:2}
    enum status:{未着手:0,着手中:1,完了:2}

    scope :search_name, -> (name) {where("name LIKE ?", "%#{name}%")}
    scope :search_status, -> (status) {where(status: status)}

end
