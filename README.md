# Singl

Have you ever tried to use instance methods on `case` expressions,
and got bored by all the repetition?

```ruby
tmp_var = my_method.that_gets_an_integer(foo)
case
when tmp_var.odd? then foo_bar(baz)
when tmp_var.zero? then frob(nicate)
else raise Error
end
```
Say no more to this, using `Singl.ify!`

```ruby
Singl.ify! Integer

case my_method.that_gets_an_integer(foo)
when Integer.odd? then foo_bar(baz)
when Integer.zero? then frob(nicate)
else raise Error
end
```

You can also use it in your own classes:

```ruby
class Foobar
  ....
  def f
    self.logic
  end

  include Singl
end

baz = Foobar.new
Foobar.f baz
```

Or, for bonus points, completely ad-hoc:

```ruby
case my_method.that_gets_an_integer(foo)
when Singl.odd? then foo_bar(baz)
when Singl.zero? then frob(nicate)
else raise Error
end

Singl.f baz
```

For more info, see the [associated blog post][]

[associated blog post]: https://web.ist.utl.pt/ist186503/posts/008_Ruby-turning-instance-methods-into-class-methods.html


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'singl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install singl

## Usage

(See above)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RafaelPAndrade/singl.
