--!strict

local class = {} :: class
class.__index = class

export type WidgetParams = {
  id: string?,
  title: string?,
  state: Enum.InitialDockState?,
  size: Vector2?,
  min_size: Vector2?,
  enabled: boolean?,
  restore: boolean?,
}

type class = {
  new: (plugin: Plugin, params:WidgetParams) -> Widget,
  destroy: (self: Widget) -> (),

  show: (self: Widget, value: boolean) -> (),
  hidden: (self: Widget) -> boolean,
  set_title: (self: Widget, title: string) -> (),

  get: (self: Widget) -> DockWidgetPluginGui,
  clear: (self: Widget) -> (),
  mount: (self: Widget, ...Instance) -> (),
  unmount: (self: Widget, ...Instance) -> (),

  __index: class,
}

export type Widget = typeof(setmetatable({} :: {
  widget: DockWidgetPluginGui,
  hidden: boolean,
}, class :: class))

function class.new(plugin: Plugin, params: WidgetParams): Widget
  local size = params.size or Vector2.new(250, 250)
  local min_size = params.size or Vector2.new(100, 100)
  local info: DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(
    params.state or Enum.InitialDockState.Float,
    params.enabled or true,
    params.restore or true,
    size.X,
    size.Y,
    min_size.X,
    min_size.Y
  )
  local widget: DockWidgetPluginGui = plugin:CreateDockWidgetPluginGui(
    params.id or plugin.Name,
    info
  )
  widget.Title = params.title or plugin.Name
  widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  return setmetatable({
    widget = widget,
    hidden = params.enabled or true,
  }, class :: class) :: Widget
end

function class:show(value: boolean)
  self.widget.Enabled = value
  self.hidden = not value
end

function class:destroy()
  self.widget:Destroy()
end

function class:hidden()
  return self.hidden
end

function class:set_title(title: string)
  self.widget.Title = title
end

function class:mount(...: Instance)
  for _, v: Instance in {...} do
    v.Parent = self.widget
  end
end

function class:unmount(...: Instance)
  for _, v: Instance in {...} do
    if v.Parent == self.widget then
      v:Destroy()
    end
  end
end

function class:clear()
  self.widget:ClearAllChildren()
end

function class:get()
  return self.widget
end

return class
