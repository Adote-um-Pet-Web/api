module V1
  module Admin
    class UsersController < ApiController
      before_action :set_user, only: %i[show update destroy]

      def index
        @users = User.all
      end

      def create
        @user = User.new(user_params)
        if @user.save!
          render json: @user, status: :created, location: v1_admin_user_url(@user)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render :show, status: :ok, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
