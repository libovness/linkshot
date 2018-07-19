class Link < ApplicationRecord

	belongs_to :shot, inverse_of: :links, optional: true
	belongs_to :user, optional: true
	validates :title, presence: true
	validates :url, presence: true
	validates_format_of :url, :with => /^(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix

end
