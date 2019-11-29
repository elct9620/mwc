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

### Configure

We use the DSL to specify compile behavior, edit `.mwcrc` to change it.

### Add some source code

```c
// src/main.c

#include<mruby.h>
#include<mruby/compile.h>
#include<mruby/string.h>

int main() {
  mrb_state* mrb = mrb_open();
  mrb_load_string(mrb, "puts 'Hello World'");
  mrb_close(mrb);

  return 0;
}
```

### Source code detect

* `src/**/*.c` the normal c code
* `src/js/**/*.lib.js` the JavaScript library can call it inside C
* `src/js/**/*.pre.js` the JavaScript prepend WebAssembly JS
* `src/js/**/*.post.js` the JavaScript append WebAssembly JS

### Compile

To compile `*.c` to `.wasm` you have to execute `compile` command:

    $ mwc compile

To see more usage with `help` command:

    $ mwc help compile

> Current only support minimal compile feature, the optimize and source map will be added soon.

### Serve compiled files

The `mwc` has built-in static file server to help preview or debug:

    $ mwc server

And then, open the `http://localhost:8080` you will see the Emscripten web shell and `Hello World` is printed.

## Roadmap

* [ ] Refactor compile function
* [ ] Environment-based compile

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/mwc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mwc project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/mwc/blob/master/CODE_OF_CONDUCT.md).
