class RemoveExtraneousPostalFieldsFromMembers < ActiveRecord::Migration[4.2]
  def up
    remove_column :members, :updated
    remove_column :members, :citystzip
    rename_column :members, :allhousenum, :street_address
    rename_column :members, :join, :member_since
    rename_column :members, :last_payment, :last_payment_date

  end

  def down
    rename_column :members, :last_payment_date, :last_payment
    rename_column :members, :member_since, :join
    rename_column :members, :street_address, :allhousenum
    add_column :members, :citystzip, :string
    add_column :members, :updated, :date
    
  end
end
