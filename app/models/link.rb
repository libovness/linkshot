class Link < ApplicationRecord

	require 'mechanize'

	belongs_to :shot, inverse_of: :links, optional: true
	belongs_to :user, optional: true
	# validates :title, presence: true
	validates :url, presence: true

	# answer = self.changed?
	# puts answer

	def save_metadata 
		if url_changed?
			agent = Mechanize.new
			page = agent.get(url)
			title = page.title
			puts title
			description = page.at("head meta[name='description']").attributes["content"].value unless page.at("head meta[name='description']").nil?
			puts description
			image = page.at("head meta[property='og:image']").attributes["content"].value unless page.at("head meta[property='og:image']").nil?
			puts image
			self.update_attributes(title: title, description: description, image: image)
		end
	end

end
