class Loan < ActiveRecord::Base
  validates :amount, :ssn, :property_value, presence: true
  validate :loan_amount, :correct_ssn_format

  def loan_amount
    if amount.to_f > property_value.to_f
      errors.add(:amount,'Loan amount may not be greater than the property value')
    end
  end

  def correct_ssn_format
    if (ssn =~ /(\d{3})[^\d]?(\d{2})[^\d]?(\d{4})/).nil?
      errors.add(:ssn, 'Please enter a valid SSN')
    end
  end

  def ltv
    (amount.to_f / property_value.to_f) * 100
  end

  def status_string
    if accepted?
      'Loan Accepted'
    else
      'Loan Rejected'
    end
  end
end
