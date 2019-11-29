#include<mruby.h>
#include<mruby/compile.h>
#include<mruby/string.h>

int main() {
  mrb_state* mrb = mrb_open();
  mrb_load_string(mrb, "puts 'Hello, mruby on WebAssembly'");
  mrb_close(mrb);

  return 0;
}
