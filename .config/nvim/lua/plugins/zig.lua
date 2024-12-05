local utils = require('libraries._set_config')

local conf = utils.conf

return {
  {
    'ziglang/zig.vim',
    ft = { 'zig', 'zir' },
  },
}
