Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :tasks
resources :users #do
#  resources :tasks
#end

root "tasks#index"
get "login" => "users#login_form"
post "login" => "users#login"
post "logout" => "users#logout"

namespace :admin do
  resources :users
end


end
