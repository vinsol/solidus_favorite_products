Solidus Favorite Products
================

[![Circle CI](https://circleci.com/gh/jtapia/solidus_favorite_products/tree/master.svg?style=shield)](https://circleci.com/gh/jtapia/solidus_favorite_products/tree/master)

* Solidus Favorite Products is an extension that allows the user to mark/unkmark a product as favorite from the product page.

* Admin can view which products have been marked as favorite, and by which users, on the Admin end.

* It gives user the ability to see all products marked as favorite by him/her.

Installation
------------

Add solidus_favorite_products to your Gemfile:

```ruby
gem 'solidus_favorite_products'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g solidus_favorite_products:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'solidus_favorite_products/factories'
```

Contributing
------------

1. Fork the repo.
2. Clone your repo.
3. Run `bundle install`.
4. Run `bundle exec rake test_app` to create the test application in `spec/test_app`.
5. Make your changes.
6. Ensure specs pass by running `bundle exec rspec spec`.
7. Submit your pull request.

Credits
-------

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2017 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License
