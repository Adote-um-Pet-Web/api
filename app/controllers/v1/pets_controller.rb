# frozen_string_literal: true

require 'pry'
module V1
  class PetsController < ApplicationController
    before_action :set_pet, only: %i[show update destroy]

    # GET /pets
    def index
      # adicionar a autenticação para o admin
      @pets = Pet.all

      render json: @pets
    end

    # GET /pets/1
    def show
      # adicionar a autenticação para o admin
      render json: @pet
    end

    # GET /pets/my_pets
    def my_pets
      @pets = Pet.where(owner: current_user)

      render :my_pets, status: :ok, location: v1_pets_url(@pets)
    end

    # GET /pets/my_pets/:id
    def show_my_pet
      @pet = Pet.find_by!(id: params[:id], owner: current_user)

      render :show_my_pet, status: :ok, location: v1_pets_url(@pets)
    end

    # GET /pets/availables
    def availables
      @pets = Pet.where(adopted: false) # ajustar pelo status de adoção
      render :availables, status: :ok, location: v1_pets_url(@pets)
    end

    # GET /pets/availables/:id
    def show_available
      # precisa ser usuário autenticado
      @pet = Pet.find_by!(id: params[:id], adopted: false) # ajustar pelo status de adoção      
      render :show_available, status: :ok, location: v1_pets_url(@pets)
    end

    # POST /pets
    def create
      @pet = Pet.new(pet_params)

      if @pet.save
        render json: @pet, status: :created, location: @pet
      else
        render json: @pet.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /pets/1
    def update
      if @pet.update(pet_params)
        render json: @pet
      else
        render json: @pet.errors, status: :unprocessable_entity
      end
    end

    # DELETE /pets/1
    def destroy
      @pet.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:pet).permit(:name, :species, :breed, :age, :color, :sex, :size, :weight, :history,
                                  :observations, :adopted, :user_id)
    end
  end
end
