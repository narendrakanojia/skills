LOCALE_REGEX = /#{I18n.available_locales.join('|')}/ unless defined?(LOCALE_REGEX)

Rails.application.routes.draw do
  # Devise
  devise_for :auth_users,
      skip: [:sessions],
      controllers:
        { omniauth_callbacks: 'omniauth_callbacks' }, defaults: { locale: nil }

  devise_scope :auth_user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_auth_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_auth_user_session
  end


  # Status
  scope 'status' do
    get 'health', to: 'status#health'
    get 'readiness', to: 'status#readiness'
  end

  get root to: redirect(path: "/en/people")
  get "/people", to: redirect("/en/people")
  get "/people_skills", to: redirect("/en/people_skills")


  scope "/:locale", locale: LOCALE_REGEX do
    get '/:locale' => redirect("%{locale}/people")

    resources :skills do
      collection do
        get 'export', to: 'skills#export'
      end
    end

    resources :people_skills do
      collection do
        get 'filter_form', to: "people_skills/filter_form#index"
      end
    end

    resources :cv_search

    resources :admin, only: :index
    namespace :admin do
      resources :departments
      resources :roles
      resources :companies
    end

    resources :people do
      resources :advanced_trainings
      resources :educations
      resources :activities
      resources :projects
      resources :people_skills, controller: 'people/people_skills_create'

      member do
        get 'export-cv', to: 'people/export_cv#show'
        put 'picture', to: 'people/picture#update'
        get 'picture', to: 'people/picture#show'
        get 'export', to: 'people#export'
        get 'competence-notes', to: 'people/competence_notes#edit'
        post 'competence-notes', to: 'people/competence_notes#update'

        get 'people-skills-edit', to: 'people/people_skills#edit'
        patch 'people-skills', to: 'people/people_skills#update'
      end
    end
  end
  match '*path', to: redirect("/#{I18n.locale}/%{path}"), :via => [:get, :post]


  # Outdated api routes
  namespace :api do
    resources :people do
      collection do
        get 'search', to: 'people/search#index'
      end
    end

    resources :people do
      member do
        put 'picture', to: 'people/picture#update'
        get 'picture', to: 'people/picture#show'
      end
    end

    resources :skills do
      collection do
        get 'unrated_by_person'
      end
    end

    resources :advanced_trainings
    resources :activities
    resources :branch_adresses
    resources :categories, only: [:index, :show]
    resources :companies
    resources :departments, only: :index
    resources :educations
    resources :expertise_categories
    resources :expertise_topics
    resources :expertise_topic_skill_values
    resources :languages, only: :index
    resources :language_skills
    resources :people_skills
    resources :person_roles
    resources :person_role_levels, only: :index
    resources :projects
    resources :project_technologies
    resources :roles, only: :index

    if Rails.env.test?
      resource 'test_api', controller: 'test_api', only: [:create, :destroy]
    end

    get 'env_settings', to: 'env_settings#index'
  end
end
