return function()
  local wilder = require('wilder')

  require('wilder').setup {
    modes = {
      ":",
      "/",
      "?"
    },
  }
end
