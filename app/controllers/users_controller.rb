class UsersController < ApplicationController

	def new
		
	end

	def show
		@user = User.find(params[:id])
		@foodbacks = Foodback.find(params[:id])

	end

	def edit
		@user = User.find(params[:id])
		if !( current_user.id == @user.id)
				redirect_to root_path
		end		
	end

	def update
		@user = User.find(params[:id])
    	if @user.update_attributes(params[:user])
      		# Handle a successful update.
				#flash[:success] = "¡Bien! Actualizaste tu perfil."
      			#sign_in @user
				redirect_to @user
    	else
      		render 'edit'
      	end
	end

	def delete
		
	end

	def index
		
	end

end
