module CommentsHelper
	def commentable(object)
		{
			commentable_id: object.id,
			commentable_type: object.class.to_s
		}
	end
end
