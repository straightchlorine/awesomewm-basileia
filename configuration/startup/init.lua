--- init.lua
-- Initializes startup module, calls both startup functions along with error
-- handling
---

require(... .. '.autorun')
require(... .. '.error-handler')
