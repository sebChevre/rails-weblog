class PostsController < ApplicationController
  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end
end
