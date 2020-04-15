class TwitterList < ApplicationRecord
  belongs_to :user
  # TODO: 何故、この書き方で良いのか(何故scopeが出てくるか)わかっていないので、調べる
  validates :user_id, uniqueness: { scope: :list_id }
end