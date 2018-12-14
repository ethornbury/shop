class UserController < ApplicationController
    def login
        session[:login] = 1
        flash[:notice] = "You Logged In... Well Done!"
        redirect_to :controller => :items
    end
    
    def admin_login
        session[:login] = 1
        session[:cart] = nil
        flash[:notice] = "Admin Login sucessfull!!"
        redirect_to :controller => :items
    end 
    
    def logout
        session[:login] = nil
        # session[:cart] = nil
        flash[:notice] = "You have been successfully logged out!!"
        redirect_to :controller => :items
    end    

end
