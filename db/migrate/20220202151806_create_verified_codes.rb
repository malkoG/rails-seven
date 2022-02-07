class CreateVerifiedCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :verified_codes do |t|
      t.string :phone
      t.string :code

      t.timestamps
    end
  end
end
