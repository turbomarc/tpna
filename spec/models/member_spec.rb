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

require 'spec_helper'

describe Member do
  pending "add some examples to (or delete) #{__FILE__}"
end
