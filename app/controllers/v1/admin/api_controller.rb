# frozen_string_literal: true

module V1
  module Admin
    class ApiController < ApplicationController
      class ForbiddenAccess < StandardError; end
      include Authenticable

      before_action :restrict_access_from_admin!

      rescue_from ForbiddenAccess do
        render json: { errors: { message: 'Forbidden access' } }, status: :forbidden
      end

      private

      def restrict_access_from_admin!
        raise ForbiddenAccess unless current_user.has_role?(:admin)
      end
    end
  end
end
