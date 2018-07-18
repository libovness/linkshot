class Link < ApplicationRecord

	belongs_to :shot, inverse_of: :links
	belongs_to :user

end
