class User < ApplicationRecord

	has_many :shots
	has_many :links

end
