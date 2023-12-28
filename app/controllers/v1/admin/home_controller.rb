module V1
  module Admin
    class HomeController < ApplicationController
      def index
        render json: { message: 'Hello World' }
      end
    end
  end
end
