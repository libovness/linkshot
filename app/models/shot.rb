class Shot < ApplicationRecord

	belongs_to :user
	has_many :links, inverse_of: :shot, dependent: :destroy

	accepts_nested_attributes_for :links, reject_if: proc { |attributes| attributes[:name,:url].blank? }, allow_destroy: true

end
