# Autostyle

This is a simple gem to make it easier to handle styles for HTML elements.

It treats the styles as a hash, allowing styles to be merged easily.

It responds to to_s, producing CSS output

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'autostyle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install autostyle

## Usage

```ruby
style = Autostyle[background: { color: :red }]

# Both of these are equal
style.merge!(background: { color: :blue })
style[:background].merge!(color: :blue)

# Don't need to worry about nil errors
style[:text][:size] = '14px'

puts "style=\"#{style}\"" # implicitly converted to a string when needed
# style="background-color: blue; text-size: 14px"

# Merging a value for a style with "children" works as so:
style.merge!(background: 'no-repeat')
puts style.to_s # background-color: blue; background: no-repeat; text-size: 14px

# Or you can overwrite it:
style[:background] = '#ffffff'
puts style.to_s # text-size: 14px; background: #ffffff

# And with a hash:
style[:background] = { color: :red }
puts style.to_s # text-size: 14px; background-color: red
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/automeow/autostyle.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

