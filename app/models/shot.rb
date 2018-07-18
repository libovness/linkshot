class Shot < ApplicationRecord

	belongs_to :user, optional: true
	has_many :links, inverse_of: :shot, dependent: :destroy

	accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

	extend FriendlyId
  	friendly_id :name, use: :slugged

  	scope :published, -> (published) { where published: published }

end
