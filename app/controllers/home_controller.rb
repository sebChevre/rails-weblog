class HomeController < ApplicationController
  def show
    @posts = Post.order(created_at: :desc).first(3)
  end
end
