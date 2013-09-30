class ChangeOwnRentName < ActiveRecord::Migration
  def change
       rename_column :members, :own_ren, :own_rent
     end
end
