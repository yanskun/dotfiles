return function()
  require('flutter-tools').setup {
    flutter_lookup_cmd = 'asdf where flutter',
  }
end
