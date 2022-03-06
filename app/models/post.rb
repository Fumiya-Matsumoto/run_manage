class Post < ApplicationRecord
    validates :user_id, {presence:true}
    belongs_to :user
    has_many :post_records
    accepts_nested_attributes_for :post_records
end
