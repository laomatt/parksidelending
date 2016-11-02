require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  setup do
    @loan = loans(:one)
    request.env["HTTP_REFERER"] = "/"
  end

end
