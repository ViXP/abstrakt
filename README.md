<p align="center">
  <img src="images/full_logo.svg" alt="Abstrakt" style="border: none"/>
</p>

This GEM adds support of standard OOP entities such as **Abstract Class**
(and **Interface** in *TODO*) on class declaration level. It means, that your
interpreter will raise exceptions in case if your class, which inherits from the
Abstract class, does not implement defined abstract methods. 

Described behaviour imitates Java compilation errors.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'abstrakt'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install abstrakt

## Usage
Don't forget to `require 'abstrakt'` in your source code!

### Abstract class declaration
To define your own abstract class, you need to extend `Abstract::Builder`
module in your abstract class declaration:
```ruby
class MyAbstraktClass
  extend Abstrakt::Builder
end
```
Now you can declare your **abstract methods**, by using the Abstrakt DSL words:
- `abstract :method_name` or `public_abstract :method_name` to define abstract
  **public** method;
- `protected_abstract :method_name` to define **protected** abstract method;
- `private_abstract :method_name` to define **private** abstract method;

As any other abstract class, your class can also define non-abstract methods
implementations, as well as class singleton methods as usual.

Example:
```ruby
class AbstractStringInstrument
  extend Abstrakt::Builder

  abstract :play
  public_abstract :tune

  protected_abstract :strings_number
  private_abstract :weight

  def present!
    puts "I am a #{self.class} instrument with #{strings_number} strings!"
  end
end
```

If you will try to create an instance of the abstract class, it will throw
`Abstrakt::Exceptions::InstantiationError` exception.

### Abstract class implementation declaration
While Java uses *extends* word for class inheritance, we will stick to the
regular Ruby inheritance operator instead. So, for creating the class, which implements your abstract class, you simply inherit from it and declare all
abstract methods in your implementation!

Implementation example:
```ruby
class Guitar < AbstractStringInstrument
  def initialize(brand:, model:, weight:)
    @brand, @model, @weight = brand, model, weight
  end

  def play # this implements public abstract method
    p 'I am playing!'
  end

  def tune # and this too
    p 'Getting in EBGDAE tuning...'
    sleep 2
    p 'Done!'
  end

  protected

    def strings_number  # this implements protected method
      6
    end

  private

    attr_reader :weight # and this is private one
end

# Instantiation:
lp = Guitar.new brand: :gibson, model: :les_paul, weight: 5
lp.present!
```

If you forgot to implement any of them, your intepreter will raise
`Abstrakt::Exceptions::InstanceMethodNotImplementedError` exception.

## Future development and TODO

Interfaces entities and interfaces inheritance functionality are also planned to
be implemented as a separate module of `Abstrakt` GEM in future.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ViXP/abstrakt. This project is intended to be a safe, welcoming space for
collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Abstrakt project’s codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/ViXP/abstrakt/blob/master/CODE_OF_CONDUCT.md).
