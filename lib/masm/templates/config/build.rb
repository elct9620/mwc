# frozen_string_literal: true

MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  conf.gembox 'default'
end

MRuby::CrossBuild.new('wasm') do |conf|
  toolchain :clang

  # C compiler settings
  conf.cc do |cc|
    cc.command = 'emcc'
    cc.compile_options = '%<flags>s -s WASM=1 -o %<outfile>s ' \
                         '-c %<infile>s -Oz --llvm-opts 3'
  end

  # Linker settings
  conf.linker do |linker|
    linker.command = 'emcc'
    linker.link_options = '%<flags>s -o %<outfile>s %<objs>s %<libs>s'
  end

  # Archiver settings
  conf.archiver do |archiver|
    archiver.command = 'emcc'
    archiver.archive_options = '%<objs>s -s WASM=1 -o %<outfile>s'
  end

  # file extensions
  conf.exts do |exts|
    exts.object = '.bc'
    exts.executable = '' # '.exe' if Windows
    exts.library = '.bc'
  end

  # TODO: Allow specify customize gembox
  config.gembox 'default'
end
