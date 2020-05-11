class AddCompletionToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :completion, :boolean
  end
end
