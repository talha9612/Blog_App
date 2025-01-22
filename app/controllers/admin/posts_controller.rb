class Admin::PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
    before_action :authenticate_user!, only: %i[show ]
    before_action :authorize_admin!    # Ensure user is an admin
    def index
      @posts = Post.all
    end

    def show
    end

    def new
      @post = Post.new
    end

    def create
      # @post = Post.new(post_params)
      # if @post.save
      #   redirect_to @post, notice: "Post was successfully created."
      # else
      #   # Explicitly render the new view if there are errors
      #   render :new, status: :unprocessable_entity
      # end
      @post = Post.new(post_params)
      puts @post
    if @post.save
      redirect_to admin_post_path(@post), notice: "Blog post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to @post, notice: "Post was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      if @post.destroy
      redirect_to admin_posts_path, notice: "Post was successfully deleted."
      else
      redirect_to admin_posts_path, alert: @post.errors.full_messages.to_sentence
      end
    end
    private
    def authorize_admin!
      redirect_to root_path, alert: "You are not authorized to access this page." unless current_user&.admin?
    end
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.require(:post).permit(:title, :content, :published, tag_ids: [])
    end
end
