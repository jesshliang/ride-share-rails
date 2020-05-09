class Driver < ApplicationRecord
	has_many :trips

	validates :name, presence: true
	validates :vin, presence: true

	def average_rating
		sum_rating = 0

		self.trips.each do |trip|
			sum_rating += trip.rating
		end

		return (sum_rating / self.trips.length)
	end

	def total_earnings
		total = 0

		self.trips.each do |trip|
			total += trip.cost
		end

		return total
	end
end
