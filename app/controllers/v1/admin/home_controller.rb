module V1
  module Admin
    class HomeController < ApiController
      def index
        render json: { message: 'Hello World' }
      end
    end
  end
end
