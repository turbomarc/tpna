# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  allhousenum  :string(255)
#  status       :string(255)
#  join         :integer
#  updated      :date
#  last_payment :date
#  amount       :integer
#  paid_thru    :integer
#  email        :string(255)
#  phone        :string(255)
#  street_name  :string(255)
#  citystzip    :string(255)
#  notes        :string(255)
#  auto_status  :string(255)
#  street       :string(255)
#  aptno        :string(255)
#  moved        :string(255)
#  st           :string(255)
#  hsenum       :decimal(, )
#  blknum       :integer
#  pos          :string(255)
#  who          :string(255)
#  disc         :string(255)
#  transdate    :date
#  use          :string(255)
#  site_misc    :string(255)
#  sec          :integer
#  copy         :integer
#  blk          :integer
#  side         :string(255)
#  multi        :string(255)
#  evenodd      :decimal(, )
#  on           :string(255)
#  ref          :string(255)
#  plus         :string(255)
#  parcel_id    :integer
#  own_rent     :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  amt          :decimal(, )
#

class Member < ActiveRecord::Base
  attr_accessible :allhousenum, :amt, :aptno, :auto_status, :blk, :blknum, :citystzip, :copy, :disc, :email, :evenodd, :hsenum, :join, :last_payment, :moved, :multi, :name, :notes, :on, :own_rent, :paid_thru, :parcel_id, :phone, :plus, :pos, :ref, :sec, :side, :site_misc, :st, :status, :street, :street_name, :transdate, :updated, :use, :who

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |member|
        csv << member.attributes.values_at(*column_names)
      end
    end
  end
    
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      member = find_by_id(row["id"]) || new
      member.attributes = row.to_hash.slice(*accessible_attributes)
      member.save!
    end
  end
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
