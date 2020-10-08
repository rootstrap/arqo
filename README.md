# ARQO ![ARQO](docs/images/logo.png)

ARQO (Active Record Query Objects) is a minimal gem that let you use Query Objects in an easy and Rails friendly way. It leverages `ActiveRecord` features and tries to make query objects as intuitive as possible for developers. In combination with the documentation we hope `ARQO` helps people keep their projects well structured and healthy.

![CI](https://github.com/rootstrap/arqo/workflows/ci/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/5ed2b32bfdf09746bd82/maintainability)](https://codeclimate.com/github/rootstrap/arqo/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/5ed2b32bfdf09746bd82/test_coverage)](https://codeclimate.com/github/rootstrap/arqo/test_coverage)

## Table of Contents

- [Motivation](#motivation)
  - [Why ARQO?](#why-arqo)
- [Installation](#installation)
- [Usage](#usage)
  - [Setting up a query object](#setting-up-a-query-object)
  - [Deriving the model](#deriving-the-model)
  - [Chaining scopes](#chaining-scopes)
  - [Generators](#generators)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)
- [Credits](#credits)

## Motivation

`ActiveRecord` provides us with an amazing abstraction of the database structure, allowing us to write queries in a simple way. Unfortunately, models can grow large for several reasons, one of them being adding a lot of scopes or placing querying logic in methods.

For this reason is that we created `ARQO`, so that the query logic is placed into specific objects responsible for building queries while not losing any of the benefits that Rails gives us.

### Why ARQO?

- It is really simple, but still enough to have the best of Rails & query objects.

- It will dynamically add scopes to your `ActiveRecord::Relation` instances, clearly making a separation of concerns by not making them accessible through the model.

- It supports chaining methods defined in the query object just like when using Rails `scope`s.

- It centralizes the querying logic of your models in a single source of truth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arqo'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install arqo

## Usage

In the following sections we explain some basic usage and the API provided by the gem.

### Setting up a query object

In order to use an `ARQO` query object, you need to inherit from `ARQO::Query` and define the `Scope` module inside it. Methods should be defined within the `Scope` module like this:
```ruby
# app/queries/user_query.rb

class UserQuery < ARQO::Query
  module Scope
    def active_last_week
      where('last_active_at > ?', 1.week.ago)
    end
  end
end
```

And then you can use it from anywhere in your code.
```ruby
UserQuery.new.active_last_week
```

## Deriving the model
In this previous example, the model was derived from the query object name. In case it's not derivable you should provide the `ActiveRecord::Relation` when initializing the query object, for example if you have:
```ruby
# app/queries/custom_named_query.rb

class CustomNamedQuery < ARQO::Query
  module Scope
    def active_last_week
      where('last_active_at > ?', 1.week.ago)
    end
  end
end
```

you can use it like this:
```ruby
CustomNamedQuery.new(User.all).active_last_week
```

you can also set the model class or relation to query from by overriding a simple method, like:

```ruby
class CustomNamedQuery < ARQO::Query
  module Scope
    # ...
  end

  private

  def associated_relation
    User # you can also do something like User.some_scope
  end
end
```

## Chaining scopes
Of course you can chain everything together, methods defined in the query object and scopes defined in the model or by Rails.
```ruby
# app/queries/user_query.rb

class UserQuery < ARQO::Query
  module Scope
    def active_last_week
      where('last_active_at > ?', 1.week.ago)
    end

    def not_deleted
      where(deleted_at: nil)
    end
  end
end
```

And then you chain everything together and it will just work :)
```ruby
UserQuery.new.where.not(name: nil).active_last_week.not_deleted.order(:id)
```

## Generators

To create the query object we can use the rails generator tool. For that, we just run:

    $ rails generate query User

And it will create your UserQuery object at `app/queries` folder. If you have set Rspec as your test framework, the corresponding spec file will be also created at `spec/queries`.

:warning: Rspec is the only test framework supported for now.

If your query object is based on another class, you can set the `associated_relation` attribute to automatically override the `associated_relation` method.

    $ rails generate query CustomUser associated_relation:User

### Model Generator

To generate the query object when you create your rails models, enable the query generators at your application config file adding the following line:

```ruby
# config/application.rb

module App
  class Application < Rails::Application
    ...

    config.generators do |g|
      ...
      g.query true # Added line
    end
  end
end
```

Now, if you run the model generator:

    $ rails generate model User

The query object and spec will be created as well as the model, migrations, test files, etc.

Another alternative, it is to add the `--query` option at the end of the command:

    $ rails generate model User --query

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rootstrap/arqo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rootstrap/arqo/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ARQO project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rootstrap/arqo/blob/master/CODE_OF_CONDUCT.md).

## Logo attribution
Logo made by [iconixar](https://www.flaticon.com/free-icon/archery_3080892) from [www.flaticon.com](https://www.flaticon.com/)

## Credits

ARQO is maintained by [Rootstrap](http://www.rootstrap.com) with the help of our [contributors](https://github.com/rootstrap/arqo/contributors).

[<img src="https://s3-us-west-1.amazonaws.com/rootstrap.com/img/rs.png" width="100"/>](http://www.rootstrap.com)
