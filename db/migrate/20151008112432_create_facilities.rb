class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
