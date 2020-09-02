class PortfoliosController < ApplicationController
	before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
	layout "portfolio"

	#petergate's access control
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all

	def index
		@portfolio_items = Portfolio.by_position
	end

	def sort
		params[:order].each do |key, value|
			Portfolio.find(value[:id]).update(position: value[:position])
		end

		# don't look for a view to render
		render nothing: true
	end

	def new
		@portfolio_item = Portfolio.new
	end

	def create
		@portfolio_item = Portfolio.new(portfolio_params)

		respond_to do |format|
			if @portfolio_item.save
				 format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
			 else
				 format.html { render :new }
			 end
		 end
	end

	def show
	end

	def edit
	end

	def update
		respond_to do |format|
			if @portfolio_item.update(portfolio_params)
				format.html { redirect_to portfolios_path, notice: 'Item was successfully updated.' }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@portfolio_item.destroy
		respond_to do |format|
			format.html { redirect_to portfolios_path, notice: 'Item was successfully deleted.' }
		end
	end

	def delete_photo
		photo = ActiveStorage::Attachment.find(params[:photo_id])
		if current_user.site_admin?
			photo.purge
			redirect_back(fallback_location: request.referer)
		end
	end

	private
	def portfolio_params
		params.require(:portfolio).permit(:title, :subtitle, :body, :photo,
			technologies_attributes: [:name])
	end

	def set_portfolio_item
		@portfolio_item = Portfolio.find(params[:id])
	end

end
