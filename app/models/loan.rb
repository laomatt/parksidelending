class Loan < ActiveRecord::Base
  validates :amount, :ssn, :property_value, presence: true
  validate :loan_amount, :correct_ssn_format

  # validates that the loan amount is no more than the property value
  def loan_amount
    if amount.to_f > property_value.to_f
      errors.add(:amount,'loan amount may not be greater than the property value')
    end
  end

  # checks for false or non valid social security numbers
  def correct_ssn_format
    if (ssn =~ /(\d{3})[^\d]?(\d{2})[^\d]?(\d{4})/).nil?
      errors.add(:ssn, 'please enter a valid SSN')
    end
  end

  # calculates this loans loan to value
  def ltv
    (amount.to_f / property_value.to_f) * 100
  end

  # outputs based on if this loan has been rejected or accepted
  def status_string
    if accepted?
      'Loan Accepted'
    else
      'Loan Rejected'
    end
  end
end
