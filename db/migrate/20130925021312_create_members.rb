class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :allhousenum
      t.string :status
      t.integer :join
      t.date :updated
      t.date :last_payment
      t.integer :amt
      t.integer :paid_thru
      t.string :email
      t.string :phone
      t.string :street_name
      t.string :citystzip
      t.string :notes
      t.string :auto_status
      t.string :street
      t.string :aptno
      t.string :moved
      t.string :st
      t.decimal :hsenum
      t.integer :blknum
      t.string :pos
      t.string :who
      t.string :disc
      t.date :transdate
      t.string :use
      t.string :site_misc
      t.integer :sec
      t.integer :copy
      t.integer :blk
      t.string :side
      t.string :multi
      t.decimal :evenodd
      t.string :on
      t.string :ref
      t.string :plus
      t.integer :parcel_id
      t.string :own_rent

      t.timestamps
    end
  end
end
