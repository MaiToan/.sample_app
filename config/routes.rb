
Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
  get "static_pages/home"
  get "static_pages/help"
  root "static_pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
end
