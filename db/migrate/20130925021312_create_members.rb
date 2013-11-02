class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :street_address
      t.date :member_since
      t.date :last_payment_date
      t.integer :amt
      t.date :paid_thru
      t.string :email
      t.string :phone
      t.string :citystzip
 
      t.timestamps
    end
  end
end
