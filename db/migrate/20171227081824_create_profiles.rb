class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.integer :age
      t.text :description
      t.boolean :is_smoker, default: false, null: false
      t.string :nationality
      t.string :occupation

      t.timestamps
    end
  end
end
