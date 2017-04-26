class PostsController < ApplicationController

  swagger_controller :posts, "Posts"

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  swagger_api :index do
    summary "Lists all Posts"
    notes "This give the list of all posts in the app"
  end
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  swagger_api :show do
    summary "Retrieves an individual post"
    notes "Returns the contents of a single post model"
    param :path, :id, :integer, :optional, "Post ID"
    response :ok, "Success", :Post
    response :not_found
  end
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  swagger_api :create do
    summary "Creates a new Post entry"
    notes "Creates a new Post model record in the posts table"
    param :form, :title, :string, :required, "Title"
    param :form, :body, :string, :required, "Post content"
    response :created
    response :unprocessable_entity
  end
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  swagger_api :update do
    summary "Updates Post"
    notes "Updates the given post with the form data"
    param :form, :title, :string, :optional, "Title"
    param :form, :body, :string, :optional, "Post content"
    response :ok
    response :unprocessable_entity
  end
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  swagger_api :destroy do
    summary "Destory (delete) post"
    notes "Removes the post entry from the database"
    param :path, :id, :integer, :required, "Post ID"
    response :no_content
  end
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
