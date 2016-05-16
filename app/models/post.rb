class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :content, presence: true, length: {minimum: 20}
end
