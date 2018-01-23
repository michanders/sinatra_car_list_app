class CreateCars < ActiveRecord::Migration

  def change
    create_table :cars do |t|
      t.string :make
      t.string :name
      t.integer :year
    end
  end
end
