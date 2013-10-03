class FoodbacksController < ApplicationController

	def create
		@foodback = current_user.foodbacks.build(params[:foodback])
		if @foodback.save
			flash[:success] = "Foodback created!"
			redirect_to @foodback
		else
			render 'new'
		end
	end

	def destroy
		@foodback = Foodback.find(params[:id])
		if (current_user.id == @foodback.user.id)
		@foodback.destroy
		flash[:success] = "Foodback erased."
		end
		redirect_to root_path

	end

	def show
		@foodback=Foodback.find(params[:id])
	end

	def new
		if !user_signed_in?
			flash[:error] = "Woops! You're not signed in"
			redirect_to root_path
		end
		@foodback = current_user.foodbacks.new
	end

	def edit
		@foodback = Foodback.find(params[:id])
		if !(current_user.id == @foodback.user.id)
			redirect_to root_path
		end

	end

	def update
		@foodback = Foodback.find(params[:id])
		if !(current_user.id == @foodback.user.id)
			redirect_to root_path
		end
		if @foodback.update_attributes(params[:foodback])
			redirect_to @foodback
		else 
			render 'edit'
		end
	end

	def index
		@allfoodback = Foodback.all
	end
end
