# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "app/teachers#index"

  namespace :app do
    devise_for :admins, controllers: { sessions: "app/admin/sessions" }
    resources :dashboard, only: %i[index] do
      get :branch, on: :member
    end
    resource :institutions, only: %i[update] do
      resources :teachers, only: %i[index new create show update] do
        get :clock_ins, on: :member
        collection do
          get :new_spreadsheet
          post :upload_spreadsheet
        end
      end
      resources :branches, only: %i[new create show update] do
        resources :grades, only: %i[index new create show update] do
          member do
            get :course_filter
            get :teacher_filter
            get :unit_filter
          end
          resources :grade_units, only: %i[show destroy create]
        end
        resources :students, only: %i[index new create show update] do
          get :units, on: :member
        end
        resources :courses, only: %i[index new show create update] do
          get :units_codes, on: :member
          resources :units, only: %i[index new show create destroy update] do
            resources :teachers_groups, only: %i[index show new create] do
              collection do
                get :groups_codes
              end
              member do
                get :new_teachers
                post :add_teachers
                delete :remove_teacher
              end
            end
            resources :students_groups, only: %i[index show new create] do
              collection do
                get :groups_codes
              end
              member do
                get :new_students
                post :add_students
                delete :remove_student
              end
            end
          end
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: { sessions: "api/v1/devise/sessions" }

      resources :student, only: %i[index] do
        put :update, on: :collection
      end
      
      namespace :student do
        resources :home, only: %i[index]
        resources :grade_units, only: %i[index create] do
          get :timesheets, on: :collection
        end
      end
    end
  end
end
