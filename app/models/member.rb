# == Schema Information
#
# Table name: members
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  street_address    :string(255)
#  member_since      :date
#  last_payment_date :date
#  amt               :integer
#  paid_thru         :date
#  email             :string(255)
#  phone             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Member < ActiveRecord::Base
  paginates_per 50
  # attr_accessible :name, :street_address, :member_since, :last_payment_date, :amt, :paid_thru, :email, :phone, :notes

  validates :name, presence: true
  validates :street_address, presence: true, uniqueness: { case_sensitive: false }

  scope :matching, lambda {|query| where('name ILIKE ? OR street_address ILIKE ?', "%#{query}%", "%#{query}%")}
  scope :renewal_matching, lambda {|renewal_query_start, renewal_query_end| where('paid_thru BETWEEN ? and ?', "%#{renewal_query_start}%", "%#{renewal_query_end}%")}

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
      member.attributes = rehash_keys(row)

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
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


  def self.search(query)
    if query.present?
      matching(query)
    else
      where(nil)
    end
  end

  def self.renewal_between(start_date, end_date)
    if [start_date, end_date].all?(&:present?)
      renewal_matching(start_date, end_date)
    elsif start_date.present?
      where("paid_thru >= ?", start_date)
    elsif end_date.present?
      where("paid_thru <= ?", end_date)
    else
      where(nil)
    end
  end

end
