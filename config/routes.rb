Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'welcome#index'

  get '/wizards', to: 'wizards#index'
  get 'wizards/new', to: 'wizards#new'
  post '/wizards', to: 'wizards#create'
  get '/wizards/:id', to: 'wizards#show'
  get '/wizards/:id/edit', to: 'wizards#edit'
  patch '/wizards/:id', to: 'wizards#update'
  delete '/wizards/:id', to: 'wizards#destroy'

  get '/spells', to: 'spells#index'
  get '/spells/:id', to: 'spells#show'
  get '/spells/:id/edit', to: 'spells#edit'
  patch '/spells/:id', to: 'spells#update'
  delete '/spells/:id', to: 'spells#destroy'

  get '/wizards/:id/wizard_spells', to: 'wizard_spells#index'
  get 'wizards/:id/wizard_spells/new', to: 'wizard_spells#new'
  post 'wizards/:id/wizard_spells', to: 'wizard_spells#create'
  
  # get '/wizards/:id/spells_alpha', to: 'wizard_spells#spells_apha'
   
end
