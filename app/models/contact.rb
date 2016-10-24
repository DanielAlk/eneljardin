class Contact < ActiveRecord::Base
	validates_presence_of :email
	validates_presence_of [:name, :message], unless: :newsletter?

	enum kind: [:contact, :newsletter]
end
