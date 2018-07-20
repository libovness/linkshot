class Link < ApplicationRecord

	require 'mechanize'
	require 'uri/http'

	before_save :check_for_metadata, if: :url_changed?, on: :update
	before_save :check_for_metadata, on: :create

	belongs_to :shot, inverse_of: :links, optional: true
	belongs_to :user, optional: true
	# validates :title, presence: true
	validates :url, presence: true

	def check_for_metadata
		agent = Mechanize.new
		page = agent.get(url)
		uri = URI.parse(url)
		domain = PublicSuffix.parse(uri.host)
		real_domain = domain.domain
		agent.keep_alive = false
		if real_domain == 'amazon.com'
			self.title = page.at('#productTitle').children.text
		else
			self.title = page.title 
		end
		self.description = page.at("head meta[name='description']").attributes["content"].value
		if real_domain == 'amazon.com'
			leftCol = page.search('#leftCol')
			images = leftCol.search("img")
			puts images.inspect
			self.image = images[1].attributes["src"].value
		elsif page.at("head meta[property='og:image']").nil?
			self.image = nil
		else 
			self.image = page.at("head meta[property='og:image']").attributes["content"].value
		end
	end

end
