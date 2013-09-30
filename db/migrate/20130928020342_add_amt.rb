class AddAmt < ActiveRecord::Migration
  def change
      add_column :members, :amt, :decimal
    end
end
