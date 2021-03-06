class Driver < ApplicationRecord
	has_many :trips, dependent: :destroy

	validates :name, presence: true
	validates :vin, presence: true

	def average_rating
		sum_rating = 0.0
		rated_rides = 0

		self.trips.each do |trip|
			if trip.rating != nil
				sum_rating += trip.rating
				rated_rides += 1
			end
		end

		self.trips.length > 0 ? (sum_rating / rated_rides).round(2) : sum_rating
	end

	def total_earnings
		total = 0

		self.trips.each do |trip|
			if trip.cost > 1.65
				total += ((trip.cost - 1.65) * 0.80)
			else
				total += (trip.cost * 0.80)
			end
		end

		return total
	end

	def total_rides
		total = 0

		self.trips.each do |trip|
			total += 1
		end

		return total
	end

	def available?
		self.available = !self.available
		self.save
	end

	paginates_per 10
end
