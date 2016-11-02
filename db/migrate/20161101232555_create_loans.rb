class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.float :amount
      t.float :property_value
      t.boolean :accepted, :default => false

      t.text :description
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :ssn

      t.timestamps null: false
    end
  end
end
