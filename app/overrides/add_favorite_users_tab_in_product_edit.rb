# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_favorite_users_tab_in_product_edit',
  insert_bottom: '[data-hook="admin_product_tabs"]',
  text: %{
    <%= content_tag :li, class: ('active' if current == 'Favorite Products') do %>
      <%= link_to I18n.t('spree.favorites'), spree.favorite_users_admin_product_path(@product) %>
    <% end if can?(:admin, Spree::Product) %>
  }
)
