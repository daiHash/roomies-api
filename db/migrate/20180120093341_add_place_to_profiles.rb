class AddPlaceToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :place, :string
  end
end
