# Widget-Wrapper
A **simple**, **type safe** and **minimalistic** wrapper of Roblox Studio [DockWidgetPluginGui](https://create.roblox.com/docs/reference/engine/classes/DockWidgetPluginGui)
Its fully O(1) complexity.
# Example
for all the methods head to [Methods](https://github.com/daolgierd/Widget-Wrapper/tree/main?tab=readme-ov-file#methods)
```luau
local Widget = require(script.Parent.widget)

local widget = Widget.new(plugin, {
  id = "Widget",
  title = "Widget",
  state = Enum.InitialDockState.Float,
  size = Vector2.new(250, 250),
  min_size = Vector2.new(100, 100),
  enabled = true,
  restore = true,
})

local frame = Instance.new("Frame")
local text_label = Instance.new("TextLabel")

widget:mount(frame, text_label) -- add ui elements to the widget
widget:unmount(frame, text_label) -- remove ui elements from the widget
```
# Methods
- `new(plugin, props)` -> class constructor
- `destroy()` -> destroy the widget
- `show(value)` -> hide/show the widget based on the given value
- `hidden()` -> returns boolean based on the widget visibility
- `set_title(title)` -> updates the current widget title
- `get()` -> returns the `DockWidgetPluginGui` itself
- `clear()` -> removes every `Instance` parented to the `DockWidgetPluginGui`
- `mount(...)` -> parents every `Instance` given to the `DockWidgetPluginGui`
- `unmount(...)` -> destroy every `Instance` given thats parented to the `DockWidgetPluginGui`
# Props
this are the props you can pass to the constructor
- `id: string?` -> unique plugin id
- `title: string?` -> widget title
- `state: Enum.InitialDockState?` -> default dock state
- `size: Vector2?` -> default widget size in pixels
- `min_size: Vector2?` -> minimal size for the widget in pixels
- `enabled: boolean?` -> default visibility
- `restore: boolean?` -> if true, will override any saved enabled state with the `state` value.
