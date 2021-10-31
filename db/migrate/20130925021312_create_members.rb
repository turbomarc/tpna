class CreateMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :members do |t|
      t.string :name
      t.string :allhousenum
      t.date :join
      t.date :updated
      t.date :last_payment
      t.integer :amt
      t.date :paid_thru
      t.string :email
      t.string :phone
      t.string :citystzip

      t.timestamps
    end
  end
end
