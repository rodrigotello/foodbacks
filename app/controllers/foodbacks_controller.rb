# encoding: utf-8
require 'debugger'

class FoodbacksController < ApplicationController
	rescue_from FbGraph::InvalidRequest, with: :skip
	#FbGraph::InvalidRequest
	#OAuthException :: (#100) Required extended permission: share_item
	#debugger
	def index
		@allfoodback = Foodback.all
	end
	
	def show
		@foodback=Foodback.find(params[:id])
	end

	def create
		@foodback = current_user.foodbacks.build(params[:foodback])
		Category.all.each do |category|
			if params[category.name.to_sym] == "1"
				puts params[category.name.to_sym]
				@foodback.categories << category
			end
		end
		@categories = Category.all

		if @foodback.save
			#omniauth = request.env["omniauth.auth"]
			#facebook_user_token = omniauth['credentials']['token']
			#crea invitacion temporal si hay FB Id (si se elecciono amigo de la lista de facebook)
			if params[:u_id] != ''
				invited = User.find_by_uid(params[:u_id].to_i)
				if invited.nil?
					#crear invitacion temporal
					TemporalInvitation.create(uid: params[:u_id].to_i, foodback_id: @foodback.id)
				else
					#crear invitacion formal
					Invitation.create(foodback_id: @foodback.id, invited_id: invited.id)
				end
				
			end

			me = FbGraph::User.me(current_user.authentications.first.token)
			me.link!(  :link => 'https://foodbacks.com',  :message => 'Acabo de publicar un Foodback.')

			#me.feed!(  :message => 'Foodback',  :description => 'Foodback test')
			flash[:success] = "Creaste un Foodback exitosamente!"	
			redirect_to @foodback
		else
			render 'new'
		end
		
	end

	def destroy
		@foodback = Foodback.find(params[:id])
		if (current_user.id == @foodback.user.id)
		@foodback.destroy
		flash[:success] = "Foodback borrado."
		end
		redirect_to root_path

	end

	def new
		if !user_signed_in?
			flash[:error] = "Woops! Necesitas iniciar sesión."
			redirect_to root_path
		end
		@foodback = current_user.foodbacks.new

		#Populates @people 4 friends list
		me = FbGraph::User.me(current_user.authentications.first.token)
		@bffs = me.friends
		friends = []
		if params[:term]
			@bffs.each do |f| 
				if f.name.include? params[:term]
					friends << f
				end
			end
		else
			friends = @bffs
		end
		@people = friends
		#Ends populate

		  respond_to do |format|  
		    format.html # index.html.erb  
		    format.json { render :json => @people.map{|u| {:id => u.identifier, :name => u.name}}.to_json }
		end

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

	def skip
			flash[:success] = "Creaste un Foodback exitosamente!"
			redirect_to @foodback	
		end


end
