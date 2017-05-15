Spree::AppConfiguration.class_eval do
  preference :favorite_products_per_page, :integer, default: 20
  preference :favorite_users_per_page, :integer, default: 20
end
