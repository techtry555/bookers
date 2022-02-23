Rails.application.routes.draw do

  # ルートパスの設定
  # root to: 'controller名+action名'
  # 例 以下のようなリンクを貼ると、topページに遷移できる。
  # <%= link_to 'TOPページ', root_path %>
  root to: 'homes#top'

  # resourcesメソッドの利用
  # resources :controller名
  resources :books

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
