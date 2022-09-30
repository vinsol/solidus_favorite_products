# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/users/_tabs',
  name: 'add_favorite_products_tab_user_edit',
  insert_bottom: '[data-hook="admin_user_tab_options"]',
  text: %{
    <%= content_tag :li, class: ('active' if current == :favorite_products) do %>
      <%= link_to I18n.t('spree.admin.tab.favorite_products'), spree.favorite_products_admin_user_path(@user) %>
    <% end if can?(:admin, Spree::Product) %>
  }
)
