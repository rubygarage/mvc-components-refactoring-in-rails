class UsersController < ApplicationController
  def create
    @form = UserForm.new(user_params)


    if @form.persist
      render json: @form.record
    else
      render json: @form.errors, status: :unpocessably_entity
    end
  end


  private


  def user_params
    params
      .require(:user)
      .permit(:email, :full_name, :password, :password_confirmation)
  end
end