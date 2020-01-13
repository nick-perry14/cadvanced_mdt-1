local modules = {}

-- load a lua resource file as module (for a specific side)
-- path: lua file path without extension
-- Shamelessly borrowed from:
-- https://github.com/ImagicTheCat/vRP/blob/master/vrp/lib/utils.lua
function module(path)
  local module = modules[path]
  if module then -- cached module
    return module
  else
    local code = LoadResourceFile(path..".lua")
    if code then
      local f,err = load(code, "/"..path..".lua")
      if f then
        local ok, res = xpcall(f, debug.traceback)
        if ok then
          modules[path] = res
          return res
        else
          error("error loading module "..path..":"..res)
        end
      else
        error("error parsing module "..path..":"..debug.traceback(err))
      end
    else
      error("resource file "..path..".lua not found")
    end
  end
end