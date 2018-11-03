# Revoke
Adding revoke to your application provides you with an ability to prevent create, update and delete of an entity based on some event.

#### Usecase
Your blog application has comments on articles which you want to be updated only within 10 minutes of creation. Here, `Revoke` gem comes handy to handle this scenario with ease.

# Requirements
Revoke currently supports **Rails 5.2.0** and **Ruby >= 2.4.1**.


# Installation
Add following line to `Gemfile` and `bundle`

```ruby
 gem 'revoke'
 ```
OR
```ruby
gem install revoke
```
# How to Use ?

Revoke gem provides two forms of `revoke` class method which can be called in model to prevent create, update or delete based on condition.
You can revoke 3 actions:
## Event Revoke
##### Update
---
```ruby
# Revoke update of object after 10 minutes of its creation.
 revoke :update, :after, 10.minutes, :creation

 # Revoke destroy of object after 10.minutes of its updation.
 revoke :destroy, :after, 10.minutes, :updation
```
#### Destroy
---
```ruby
# Revoke destroy of object after 10 minutes of its creation.
 revoke :destroy, :after, 10.minutes, :creation
```
`Default error message: '{class_name} can only be {destroyed|updated} for {time_duration} after #{creation|updation}.`

## Conditional Revoke
```ruby
revoke :update, if: :some_method?
```

```ruby
revoke :create, if: :some_method?
```

```ruby
revoke :destroy, if: :some_method?
```
`Default error message: "Operation not allowed."`
## Customizing Error Messages

These error message can be overridden with `message` option passed alongwith `revoke` method.

```ruby
 revoke :destroy, :after, 10.minutes, :creation, message: 'Cannot destroy.'
 revoke :update, if: :some_condition?, message: 'Update not allowed.'
 revoke :destroy, if: :some_condition?, message: 'Destroy not allowed.'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, update the rspec and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/revoke.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
