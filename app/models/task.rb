class Task < ApplicationRecord

    has_many :labelings, dependent: :destroy
    has_many :labels, through: :labelings


    belongs_to :user

    validates :name, presence: true
    validates :content, presence: true

    enum priority:{高:0,中:1,低:2}
    enum status:{未着手:0,着手中:1,完了:2}

    scope :search_name, -> (name) {where("name LIKE ?", "%#{name}%")}
    scope :search_status, -> (status) {where(status: status)}

    scope :search_labels, -> (label_id) {
    task_ids = Labeling.where(label_id: label_id).pluck(:task_id)
    where(id: task_ids)
    }

end
