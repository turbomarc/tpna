# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  allhousenum  :string(255)
#  join         :date
#  updated      :date
#  last_payment :date
#  amt          :integer
#  paid_thru    :date
#  email        :string(255)
#  phone        :string(255)
#  citystzip    :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Member < ActiveRecord::Base
  attr_accessible :allhousenum, :amt, :citystzip, :email, :join, :last_payment, :name, :paid_thru, :phone, :updated

  scope :matching, lambda {|query| where('name ILIKE ? OR allhousenum ILIKE ?', "%#{query}%", "%#{query}%")}

  acts_as_xlsx

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |member|
        csv << member.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      member = find_by_id(row["id"]) || find_by_id(row["Id"]) || new
      member.attributes = rehash_keys(row).slice(*accessible_attributes)

      member.save!
    end
  end

  def self.rehash_keys(row)
    row_hash = row.to_hash
    new_keys_hash = {}
    row_hash.each do |old_key,old_value|
      new_keys_hash[old_key.downcase.gsub(/[^a-z]/, '_')] = old_value
    end
    new_keys_hash
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


  def self.search(query)
    if query.present?
      matching(query)
    else
      scoped
    end
  end

end
