class Trip < ApplicationRecord
	belongs_to :driver
	belongs_to :passenger

	validates :date, :cost, presence: true
	validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 5 }
end
