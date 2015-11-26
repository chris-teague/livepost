class StorySerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :name, :body, :id
  has_many :comments
end
