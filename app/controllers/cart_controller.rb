class CartController < ApplicationController
 # before_action :authenticate_user!
  def index
    # passes a cart to display
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end  
  end
  
  def add
    # get the Id of the product
    id = params[:id] #item.id is passed via the url
    
   # if the cart is already been created, use existing cart else create a blank cart
    if session[:cart] then
      cart = session[:cart]
    else
      session[:cart] = {} #cart items will be inserted here
      cart = session[:cart] #set cart = session
    end
    
    #If the product is already added it increments by 1 else product set to 1
    if cart[id] then
      cart[id] = cart[id] + 1
    else
      cart[id]= 1
    end  
    redirect_to :action => :index
  end

  def clearCart
    #sets session variable to nil and bring back to index
    session[:cart] = nil
    redirect_to :action => :index
  end 
  # type from here in class
  
  #def remove
    #id = params[:id]
    #cart = session[:cart]
            #cart.delete id
    #if cart[id] == 1 then
    #   cart.delete id
    #else
    # cart[id] = cart[id] - 1
    #end
    #redirect_to :action => :index
  #end
  
  def remove
    id = params[:id]
    cart = session[:cart]
    cart.delete id
    redirect_to :root
  end

  
  
  def createOrder
    # Step 1 : Get id of current user
    @user = User.find(current_user.id)
    @user.save
    # Step 2: Build order based on current user and their order stats
    @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
    @order.save
    # Step 3:  Move cart items to now be orderitems
    @cart = session[:cart] || {} #Get content of current cart
    @cart.each do | id, quantity |
      item = Item.find_by_id(id)
      @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price => item.price)

      @orderitem.save
    end
   @orders = Order.all
   @orderitems = Orderitem.where(order_id: Order.last)
  end  
end
