Eileenwold::Application.routes.draw do

  get "/galleries" => "galleries#index", as: 'galleries', format: false
  get "/galleries/:name" => "galleries#show", as: 'gallery', format: false

  get "/resume.php" => "pages#resume", format: false
  get "/resume" => "pages#resume", as: 'resume', format: false

  get "/artiststatement.php" => "pages#artist_statement", format: false
  get "/artist-statement" => "pages#artist_statement", as: 'artist_statement', format: false

  get "/contact.php" => "pages#contact"
  get "/contact" => "pages#contact", as: 'contact', format: false

  get "/northshoresun.php" => "pages#northshoresun", format: false
  get "/northshoresun" => "pages#northshoresun", as: 'northshoresun', format: false

  root :to => "pages#home"

end
