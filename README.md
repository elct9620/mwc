# Mwc

This is a small tool to help people play with mruby on WebAssembly, it let you directly setup a wasm project with mruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mwc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mwc

## Requirement

* Curl
* Tar
* Emscripten SDK
* Ruby 2.6+

> Please make sure you can execute `emcc` before use `mwc compile`

## Usage

### Create Project

Execute below command with your project name:

    $ mwc init my_mrb

This gem will create a directory `my_mrb` with anything you need to play with mruby on WebAssembly.

### Source code detect

* `src/**/*.c` the normal C code
* `src/js/**/*.lib.js` the JavaScript library can be called in C
* `src/js/**/*.pre.js` the JavaScript prepend to WebAssembly JS
* `src/js/**/*.post.js` the JavaScript append to WebAssembly JS

### Compile

To compile `*.c` to `.wasm` you have to execute `compile` command:

    $ mwc compile

You can specify compile environment to change with different options:

    $ mwc compile --env=dev

To see more usage with `help` command:

    $ mwc help compile

### Serve compiled files

The `mwc` has built-in static file server to help preview or debug:

    $ mwc server

And then, open the `http://localhost:8080` you will see the Emscripten web shell and `Hello World` is printed.

## Configure

We use DSL to define the compile preferences in `.mwcrc`

```ruby
project.name = 'mruby'
mruby.version = '2.1.3'

env :dev do
  project.source_map = true
end
```

### Project

|Name|Type|Description
|----|-----------
|name|string| The project name, will change the generated file name. ex. `mruby.wasm`
|shell|string| The shell file template, if you want to use your own html template
|source_map|boolean| Enable source map for debug
|options|array| Extra compile options. ex. `-s ALLOW_MEMORY_GROWTH=1`

### mruby

|Name|Type|Description
|----|-----------
|version|string| The prefer mruby version

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/mwc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mwc project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/mwc/blob/master/CODE_OF_CONDUCT.md).
