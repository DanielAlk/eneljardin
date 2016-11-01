class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  enum role: [:comment]

  def next
  	Comment.where('(created_at < ?) AND (commentable_id = ?) AND (commentable_type = ?)', self.created_at, self.commentable_id, self.commentable_type).order(created_at: :desc).first
  end

  def prev
  	Comment.where('(created_at > ?) AND (commentable_id = ?) AND (commentable_type = ?)', self.created_at, self.commentable_id, self.commentable_type).order(created_at: :desc).first
  end

  def is_root?
    commentable_type != 'Comment'
  end

  def root_commentable
    if is_root?
      commentable
    else
      commentable.try(:commentable)
    end
  end

  def new_response(user)
    if is_root?
      self.comments.new(user: user)
    else
      self.commentable.comments.new(user: user)
    end
  end
end
