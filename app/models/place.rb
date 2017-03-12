class Place < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :phone
	validates_presence_of :website
	validates_presence_of :user_id
	validates_presence_of :address

	belongs_to :user
	geocoded_by :address
	after_validation :geocode

	has_many :reviews, dependent: :destroy

	def average_rating
		self.reviews.sum(:score) / reviews.size
	rescue ZeroDivisionError
		0
	end

	def self.search(search)
		if search 
			where('name LIKE ? OR address LIKE ?', "#{search}", "#{search}")
		else
			all
		end
	end

	#only allowed name,address,description,phone,website,latitude,longitude,total_average_rating
	def as_json(options={})
		super(only: [:name, :address, :description, :phone, :website, :latitude, :longitude, :total_average_rating])
	end

end
