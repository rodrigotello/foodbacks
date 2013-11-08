class FoodbacksController < ApplicationController

	def create
		@foodback = current_user.foodbacks.build(params[:foodback])
		if @foodback.save
			#omniauth = request.env["omniauth.auth"]
			#facebook_user_token = omniauth['credentials']['token']

			me = FbGraph::User.me(current_user.authentications.first.token)
			me.link!(  :link => 'https://.foodbacks.com',  :message => 'I just posted a Foodback')
			#me.feed!(  :message => 'Foodback',  :description => 'Foodback test')
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
		#me = FbGraph::User.me(current_user.authentications.first.token)
		#@bffs = me.friends
		#@current_word = @words.detect{|w| w.id == params[:id2]}
		#@list.sort_by{|e| -e[:time_ago]}
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
