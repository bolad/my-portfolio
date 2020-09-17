class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]

  # In the layout directory use blog.html.erb
  layout "blog"

  #petergate's access control
  access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit, :toggle_status]}, site_admin: :all

  # GET /blogs
  def index
    if logged_in?(:site_admin)
      @blogs = Blog.all.order("created_at DESC").page(params[:page]).per(5)
    else
      @blogs = Blog.published.order("created_at DESC").page(params[:page]).per(5)
    end
    @page_title = "My Portfolio Blog"
  end

  # GET /blogs/1
  def show
    if logged_in?(:site_admin) || @blog.published?
    views = @blog.views + 1
    @blog.update(views: views)
    @comments = @blog.comments.order("created_at DESC")

    @num_comments = @blog.comments.count
    @blog.comments.each do |comment|
      @num_comments += comment.comments.count
    end
    @page_title = @blog.title
    @seo_keywords = @blog.body
  else
    redirect_to blogs_path, notice: "You are not authorised to access this page"
  end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      flash[:success] = 'Blog was successfully created.'
      redirect_to @blog
    else
      render :new
    end
  end

  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      flash[:success] = 'Blog was successfully updated.'
      redirect_to @blog
    else
      render :edit
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }

    end
  end

  def toggle_status
    if @blog.draft?
      @blog.published!
    elsif @blog.published?
      @blog.draft!
    end
    redirect_to blogs_url, notice: 'Status has been updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :topic_id)
    end
end
