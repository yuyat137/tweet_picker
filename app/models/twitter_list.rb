class TwitterList < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: { scope: :list_id }

  ACCESS_ID_MAX_LENGTH = 30
end
