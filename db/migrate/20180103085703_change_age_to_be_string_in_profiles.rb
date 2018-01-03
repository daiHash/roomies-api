class ChangeAgeToBeStringInProfiles < ActiveRecord::Migration[5.1]
  def change
    change_column :profiles, :age, :string
  end
end
