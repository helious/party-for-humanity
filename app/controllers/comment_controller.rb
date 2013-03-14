class CommentController < ApplicationController

	def post
		if (current_user.nil? ? session[:guest].party_id.to_s == params[:id] : current_user.parties.exists?(:id => params[:id]))
			name = current_user.blank? ? (session[:guest].name.blank? ? session[:guest].email : session[:guest].name) : (current_user.profile.name.blank? ? current_user.email : current_user.profile.name)
			@comment = Comment.new(:body => params[:body], :date => Time.new, :name => name, :party_id => params[:id])
			@comment.save
		end

		render :layout => false
	end

	def delete
		Comment.find_by_id(params[:id]).destroy if current_user.parties.exists?(:id => params[:party_id])

		@success = true

		render :layout => false
	end

end