Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_favorite_users_tab_in_product_edit',
  insert_bottom: '[data-hook="admin_product_tabs"]',
  text: %Q{
    <%= content_tag :li, class: ('active' if current == 'Favorite Products') do %>
      <%= link_to Spree.t(:favorites), spree.favorite_users_admin_product_path(@product) %>
    <% end if can?(:admin, Spree::Product) %>
  }
)
