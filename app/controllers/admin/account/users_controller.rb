class Admin::Account::UsersController < ApplicationController

  def index
    @users = User.all
  end

end
