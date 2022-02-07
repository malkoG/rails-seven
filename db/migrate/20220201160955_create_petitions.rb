class CreatePetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :petitions do |t|
      t.string :name
      t.string :birthday
      t.string :email
      t.string :phone
      t.string :code

      t.timestamps
    end
  end
end
