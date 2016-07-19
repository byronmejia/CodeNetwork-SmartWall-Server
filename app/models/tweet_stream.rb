class TweetStream
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :profile_picture, type: String
  field :content, type: String

  validates :username, :profile_picture, :content, presence: true

end
