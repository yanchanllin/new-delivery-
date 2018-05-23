class CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find_by(id: params[:id])
    @cutomer = @customer.orders.build(user_id:current_user.id)
  end

  def new
    @customer = Customer.new
  end

  
  def create
    if (customer = Customer.create customer_params)
      session[:customer_id] = customer.id
      redirect_to customer_path(customer)
    else
      render 'new'
    end
  end

  def edit
    @customer = Customer.find_by(id: params[:id])
    @customer = @customer.orders.build(user_id:current_user.id)
  end

  def update
    customer = Customer.find_by(id: params[:id])
    customer.update(customer_params)
    redirect_to customer_path(customer)
  end
  
  

  private
  def customer_params
    params.require(:customer).permit(
      :user_id,
      )
  end
end
