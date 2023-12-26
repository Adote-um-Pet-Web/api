# frozen_string_literal: true

json.array! @users, partial: 'v1/admin/users/user', as: :user
