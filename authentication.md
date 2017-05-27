# Rails Authentication from Scratch - Step by Step


## Prerequisites

- Clone the Cloud9 [thibaudgg/rails-weblog](https://c9.io/thibaudgg/rails-weblog) workspace.
- Seed the database, this will create some posts and comments (see `db/seeds.rb`):
``` sh
rails db:seed
```


## User

Uncomment the line 29 in the `Gemfile` file, the [bcrypt](https://github.com/codahale/bcrypt-ruby) gem will be used to
hash the user password.

``` ruby
# Gemfile
gem 'bcrypt', '~> 3.1.7'
```

Run `bundle` (shortcut for `bundle install`) to install the new gem dependencies.

Generate the user model:

``` sh
rails generate resource user name email:uniq password:digest
```

Run the migration:

``` sh
rails db:migrate
```

Update the users controller:

``` ruby
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to posts_url, notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user, :email, :password)
  end
end
```

Create a `app/views/users/new.html.erb` template:

``` erb
<h1>Sign Up</h1>
<%= form_with(model: @user, local: true) do |f| %>
  <% if @user.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@user.errors.count, 'error') %> prohibited this user from signing up:</h2>

      <ul>
      <% @user.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :name %><br />
    <%= f.text_field :name %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email %>
  </div>

  <div class="field">
    <%= f.label :password %><br />
    <%= f.password_field :password %>
  </div>

  <div class="actions">
    <%= f.submit 'Sign Up' %>
  </div>
<% end %>
```

Edit the `app/views/layouts/application.html.erb` application layout to add an header section:

``` erb
<!DOCTYPE html>
<html>
  <head>
    <title>Weblog</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'layouts/header' %>

    <% flash.each do |key, value| %>
      <%= content_tag :div, value, class: "flash #{key}" %>
    <% end %>

    <%= yield %>
  </body>
</html>
```

Create the `app/views/layouts/_header.html.erb` partial:

``` erb
<header>
  <%= link_to 'Sign Up', new_user_path %>
</header>
```

From here, you should be able to click on the 'Sign Up' link in the header and create a new user.

Once created, load the `rails console` and query for the last user with `User.last` and look at
the `password_digest` value. Yeah!


## Session

Generate the sessions controller, we don't need a model here:

``` sh
rails g controller sessions new
```

Edit the routes configuration, note the singular session resource (`rails routes | grep session`):

``` ruby
# config/routes.rb
Rails.application.routes.draw do
  root to: redirect('/posts')

  resources :users
  resource :session, only: %i[new create destroy]

  resources :posts do
    resources :comments
  end
end
```

Edit the `app/views/sessions/new.html.erb` template:

``` erb
<h1>Log In</h1>
<%= form_with url: session_path do |f| %>
  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email %>
  </div>

  <div class="field">
    <%= f.label :password %><br />
    <%= f.password_field :password %>
  </div>

  <div class="actions">
    <%= f.submit 'Log In' %>
  </div>
<% end %>
```

Add `create` and `destroy` actions to the sessions controller:

``` ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to posts_url, notice: 'Logged out!'
  end
end
```

Add `current_user` and `logged_in?` helpers to the application controller:

``` ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user
  end
end
```

Change the header links in the `app/views/layouts/_header.html.erb` partial:

``` erb
<header>
  <% if logged_in? %>
    <%= "Hello #{current_user.name}!" %>
    <%= link_to 'Logout', session_path, method: :delete %>
  <% else %>
    <%= link_to 'Sign Up', new_user_path %>
    <%= link_to 'Log In', new_session_path %>
  <% end %>
</header>
```

All set, you can now give it a try.

What could be improved here?


## Credits

This tutorial has been inspired by: https://www.rubyplus.com/articles/4171-Authentication-from-Scratch-in-Rails-5
