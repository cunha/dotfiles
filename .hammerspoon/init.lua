-- Configuration adapted from
-- https://github.com/raulchen/dotfiles/tree/master/hammerspoon

inspect = hs.inspect.inspect
prefix = require("prefix")
utils = require("utils")

require("window")
pcall(hs.fnutils.partial(require, "local"))

utils.tempNotify(3, hs.notify.new({
    title = "Config reloaded",
}))
