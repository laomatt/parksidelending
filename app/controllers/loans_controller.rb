class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]
  layout 'boot'
  # GET /loans
  # GET /loans.json
  def index
    @loans = Loan.all
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    # byebug
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)

    if @loan.save
      # conduct first test for loan approval
      if @loan.ltv > 40
        @loan.update_attributes(:accepted => true)
      end
      redirect_to "/loans/#{@loan.id}"
    else
      flash[:error_hash] = @loan.errors.messages
      flash[:error] = @loan.errors.full_messages
      flash[:error_list] = @loan.errors.messages.keys
      redirect_to :back
    end
  end

  # Method to serve up an loan
  def inspect
    # byebug
    @loan = Loan.find_by_id(params[:search])
    if @loan
      render :partial => 'loan_present', :locals => { :loan => @loan }
    else
      render :html => "No loan application with id #{params[:search]}"
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def loan_params
      params.fetch(:loan, {}).permit(:amount, :ssn, :property_value, :first_name, :last_name, :email, :phone, :description)
    end
end
