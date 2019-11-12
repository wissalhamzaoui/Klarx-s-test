class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.string :initialValue 
      t.string :from 
      t.string :to 
      t.string :finalValue 
    end
  end
end