class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :comment, :commentable_id, :commentable_type, :user_id, :role, :user_avatar, :user_name

  belongs_to :commentable
  belongs_to :user

  has_many :comments
end
