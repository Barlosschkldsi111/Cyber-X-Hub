local Load = {}

Load.Renderer = nil

function Load:CreateWindow(opts)
    local Window = {}
    Window.Title = opts.Title
    Window.Footer = opts.Footer
    Window.Icon = opts.Icon
    Window.Size = opts.Size or UDim2.fromOffset(500, 400)
    Window.ToggleKeybind = opts.ToggleKeybind or Enum.KeyCode.LeftControl
    Window.NotifySide = opts.NotifySide or "Right"
    Window.SidebarWidth = 40
    Window.Tabs = {}
    function Window:IsSidebarCompacted()
        return Window.SidebarWidth < 50
    end
    function Window:SetSidebarWidth(w)
        Window.SidebarWidth = w
        if Load.Renderer and Load.Renderer.UpdateSidebar then
            Load.Renderer:UpdateSidebar(Window)
        end
    end
    function Window:AddTab(title, icon)
        local Tab = {}
        Tab.Title = title or ""
        Tab.Icon = icon or "user"
        Tab.LeftGroupboxes = {}
        Tab.RightGroupboxes = {}
        function Tab:AddLeftGroupbox(title, icon)
            local Groupbox = {
                Title = title or "",
                Icon = icon or "box"
            }
            table.insert(Tab.LeftGroupboxes, Groupbox)
            if Load.Renderer and Load.Renderer.CreateGroupbox then
                Load.Renderer:CreateGroupbox(Window, Tab, Groupbox)
            end
            return Groupbox
        end
        function Tab:AddRightGroupbox(title, icon)
            local Groupbox = {
                Title = title or "",
                Icon = icon or "box",
                Side = "Right",
                Elements = {},
            }
            table.insert(Tab.RightGroupboxes, Groupbox)

            if Load.Renderer and Load.Renderer.CreateGroupbox then
                Load.Renderer:CreateGroupbox(Window, Tab, Groupbox)
            end

            return Groupbox
        end
        table.insert(Window.Tabs, Tab)
        if Load.Renderer and Load.Renderer.CreateTab then
            Load.Renderer:CreateTab(Window, Tab)
        end
        return Tab
    end
    if Load.Renderer and Load.Renderer.CreateWindow then
        Load.Renderer:CreateWindow(Window)
    end

    return Window
end

return Load
