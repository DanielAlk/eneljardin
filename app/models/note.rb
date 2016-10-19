class Note < ActiveRecord::Base
	has_attached_file :image, styles: { small: "300x196#", thumb: "190x124#" }
	validates_attachment :image, required: true, content_type: { content_type: /\Aimage\/.*\Z/ }

	has_attached_file :note
	validates_attachment :note, required: true, content_type: { content_type: /\Aapplication\/pdf\Z/ }

	validates_presence_of [:title, :description]

	belongs_to :workshop
	has_many :comments, as: :commentable, dependent: :destroy
end