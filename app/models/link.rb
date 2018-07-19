class Link < ApplicationRecord

	belongs_to :shot, inverse_of: :links, optional: true
	belongs_to :user, optional: true
	validates :title, presence: true
	validates :url, presence: true

end
