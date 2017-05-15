Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_sub_menu',
  name: 'select_products_tab',
  insert_bottom: '[data-hook="admin_product_sub_tabs"]',
  text: %Q{ <%= tab :favorite_products if can?(:admin, Spree::Product) %> }
)
