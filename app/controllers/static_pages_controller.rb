class StaticPagesController < ApplicationController
  def home
  	#if user_signed_in?	
     #@fbuser = FbGraph::User.fetch(current_user.uid)
     #@fbuser = FbGraph::User.fetch(current_user.uid, :access_token '=> ACCESS_TOKEN')
  	#end
  end

  def about
  end

  def help
  end

  def contact
  end
end
