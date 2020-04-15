class TwitterList < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: { scope: :list_id }
end
