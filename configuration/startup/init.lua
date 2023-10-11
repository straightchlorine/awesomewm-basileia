--- startup/init.lua
-- Initializes startup module, calls both startup functions along with error
-- handling
---

require(... .. '.autorun')
require(... .. '.error-handler')

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
