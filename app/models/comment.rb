class Comment < ApplicationRecord
  belongs_to :article

  validates :content, presence: true, length: {minimum: 5, maximum: 100}
  validates :article_id, presence: true
  validates :user_id, presence: true
end
