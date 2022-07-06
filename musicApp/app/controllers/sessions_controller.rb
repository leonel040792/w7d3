class SessionsController < ApplicationController

    def create 
        session[:session_token]= current_user.reset_session_token
        
    end

    def destroy 
        current_user.reset_session_token!
        session[:session_token]=nil 
        redirect_to new_user_url
    end


end