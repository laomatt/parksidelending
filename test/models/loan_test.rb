require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  test "Should fail if amount of loan is greater than property value" do
    Loan.new(amount: 10000000, property_value: 120000, ssn: 222334444).save == false
  end

  test "Should fail if amount is missing" do
    Loan.new(amount: nil, property_value: 120000, ssn: 222334444).save == false
  end

  test "Should fail if ssn is invalid" do
    Loan.new(amount: 100000, property_value: 120000, ssn: 2233444).save == false
  end
end
