class UsersController < ApplicationController 


    def new 
        @user=User.new
        render :new
    end


    def show
        @user= User.find_by(id: params[:id])
        render :show
    end


    def create
        @user = User.new(user_params)
        if @user.save 
            log_in_user!(@user)
            flash[:success]="You're in, enjoy!"
            redirect_to user_url(@user) #I'll probably have to redirect to the albums. We'll keep show for now
        else
            render :new
        end
    end




    def user_params
        params.require(:user).permit(:email, :password)
    end


end