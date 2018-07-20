class Link < ApplicationRecord

	require 'mechanize'
	before_save :check_for_metadata, if: :url_changed?, on: :update
	before_save :check_for_metadata, on: :create

	belongs_to :shot, inverse_of: :links, optional: true
	belongs_to :user, optional: true
	# validates :title, presence: true
	validates :url, presence: true

	def check_for_metadata
		agent = Mechanize.new
		page = agent.get(url)
		agent.keep_alive = false
		self.title = page.title
		self.description = page.at("head meta[name='description']").attributes["content"].value unless page.at("head meta[name='description']").nil?
		self.image = page.at("head meta[property='og:image']").attributes["content"].value unless page.at("head meta[property='og:image']").nil?
	end

end
