# frozen_string_literal: true

module V1
  module Admin
    class ApiController < ApplicationController
      include Authenticable
    end
  end
end
