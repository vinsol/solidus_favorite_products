Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_favorite_products_after_login',
  insert_after: '[data-hook="product_show"]',
  text: %Q{
    <%= javascript_tag do %>
      var getQueryParams = function(qs) {
        qs = qs.split('+').join(' ');

        var params = {},
          tokens,
          re = /[?&]?([^=]+)=([^&]*)/g;

        while (tokens = re.exec(qs)) {
          params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
        }

        return params;
      }

      $(document).ready(
        function(){
          var params = getQueryParams(document.location.search);
          if(params['favorite_product_id'] != null){
            $('#mark-as-favorite').attr('data-remote', true);
            $('#mark-as-favorite').trigger('click');
          }
        }
      );
    <% end %>
  }
)


