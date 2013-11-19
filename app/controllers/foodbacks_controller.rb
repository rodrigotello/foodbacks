class FoodbacksController < ApplicationController

	def index
		@allfoodback = Foodback.all
	end
	
	def show
		@foodback=Foodback.find(params[:id])
	end

	def create
		@foodback = current_user.foodbacks.build(params[:foodback])
		if @foodback.save
			#omniauth = request.env["omniauth.auth"]
			#facebook_user_token = omniauth['credentials']['token']

			me = FbGraph::User.me(current_user.authentications.first.token)
			me.link!(  :link => 'https://foodbacks.com',  :message => 'Acabo de publicar un foodback.')
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
		me = FbGraph::User.me(current_user.authentications.first.token)
		@bffs = me.friends

		friends = []
		if params[:term]
			@bffs.each do |f| 
				if f.name.include? params[:term]
					friends << f
				end
			end
			#@people = @bffs.detect{|f| f.name == "%#{params[:term]}%"}
		    #@people = Person.find(:all,:conditions => ['given_name LIKE ?', "#{params[:term]}%"])
		else
		    #@people = @bffs
		    @bffs.each do |f| 
				if f.name.include? "Ja"
					friends << f
				end
			end
		end

		@people = friends
		
		#@people = User.all
		  respond_to do |format|  
		    format.html # index.html.erb  
		# Here is where you can specify how to handle the request for "/people.json"
		#:json => @people.map{|u| {:id => u.id, :name => u.name}}.to_json }
		    format.json { render :json => @people.map{|u| {:id => u.identifier, :name => u.name}}.to_json }
		end


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


end
