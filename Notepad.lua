-- Servicios
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Script Viewer"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Frame principal
local main = Instance.new("Frame", screenGui)
main.Name = "Main"
main.Size = UDim2.new(0, 500, 0, 400)
main.Position = UDim2.new(0, 306, 0, 270)
main.BackgroundTransparency = 0
main.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Name = "Title"
title.Size = UDim2.new(1, -10, 0, 20)
title.Position = UDim2.new(0, 5, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Dex Notepad"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 14
title.Font = Enum.Font.SourceSans
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center

local close = Instance.new("TextButton", main)
close.Name = "Close"
close.Size = UDim2.new(0,16,0,16)
close.Position = UDim2.new(1,-18,0,2)
close.BackgroundTransparency = 1
close.Text = ""
local closeImg = Instance.new("ImageLabel", close)
closeImg.Size = UDim2.new(0,10,0,10)
closeImg.Position = UDim2.new(0,3,0,3)
closeImg.BackgroundTransparency = 1
closeImg.Image = "rbxassetid://5054663650"
close.MouseButton1Click:Connect(function() screenGui:Destroy() end)

local minimize = Instance.new("TextButton", main)
minimize.Name = "Minimize"
minimize.Size = UDim2.new(0,16,0,16)
minimize.Position = UDim2.new(1,-36,0,2)
minimize.BackgroundTransparency = 1
minimize.Text = ""
local minimizeImg = Instance.new("ImageLabel", minimize)
minimizeImg.Size = UDim2.new(0,10,0,10)
minimizeImg.Position = UDim2.new(0,3,0,3)
minimizeImg.BackgroundTransparency = 1
minimizeImg.Image = "rbxassetid://5034768003"

local minimized = false

minimize.MouseButton1Click:Connect(function()
    if not minimized then
        -- Minimizar: ocultar todos los hijos excepto los botones y el título
        for _, child in ipairs(main:GetChildren()) do
            if child ~= close and child ~= minimize and child ~= title then
                child.Visible = false
            end
        end
        
        -- Animar a un tamaño pequeño (solo barra con botones)
        local barHeight = math.max(close.AbsoluteSize.Y, minimize.AbsoluteSize.Y, title.AbsoluteSize.Y)
        main:TweenSize(
            UDim2.new(main.Size.X.Scale, main.Size.X.Offset, 0, barHeight + 10),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )

        minimized = true
    else
        -- Restaurar: mostrar todo de nuevo
        for _, child in ipairs(main:GetChildren()) do
            child.Visible = true
        end

        -- Volver al tamaño original (ajusta si tu GUI usa otro tamaño base)
        main:TweenSize(
            UDim2.new(0, 500, 0, 400),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )

        minimized = false
    end
end)

-- Content
local content = Instance.new("Frame", main)
content.Name = "Content"
content.Size = UDim2.new(1,0,1,-20)
content.Position = UDim2.new(0,0,0,20)
content.BackgroundColor3 = Color3.fromRGB(45,45,45)
content.BorderSizePixel = 0

-- Botones (conexiones en tu parte si quieres)
local copyButton = Instance.new("TextButton", content)
copyButton.Name = "CopyToClipboard"
copyButton.Size = UDim2.new(0.4,0,0,20)
copyButton.Position = UDim2.new(0,0,0,0)
copyButton.BackgroundTransparency = 1
copyButton.Text = "Copy to Clipboard"
copyButton.TextColor3 = Color3.fromRGB(255,255,255)
copyButton.TextSize = 8
copyButton.Font = Enum.Font.Legacy

local saveButton = Instance.new("TextButton", content)
saveButton.Name = "SaveToFile"
saveButton.Size = UDim2.new(0.3,0,0,20)
saveButton.Position = UDim2.new(0,180,0,0)
saveButton.BackgroundTransparency = 1
saveButton.Text = "Save to File"
saveButton.TextColor3 = Color3.fromRGB(255,255,255)
saveButton.TextSize = 8
saveButton.Font = Enum.Font.Legacy

local dumpButton = Instance.new("TextButton", content)
dumpButton.Name = "DumpFunctions"
dumpButton.Size = UDim2.new(0.3,0,0,20)
dumpButton.Position = UDim2.new(0.7,0,0,0)
dumpButton.BackgroundTransparency = 1
dumpButton.Text = "Dump Functions"
dumpButton.TextColor3 = Color3.fromRGB(255,255,255)
dumpButton.TextSize = 8
dumpButton.Font = Enum.Font.Legacy

local line = Instance.new("Frame", content)
line.Name = "Line"
line.Size = UDim2.new(1,0,0,1)
line.Position = UDim2.new(0,0,0,20)
line.BackgroundColor3 = Color3.fromRGB(33,33,33)

-- EditorContainer
local editorContainer = Instance.new("Frame", content)
editorContainer.Name = "EditorContainer"
editorContainer.Position = UDim2.new(0,0,0,20)
editorContainer.Size = UDim2.new(1,0,1,-20)
editorContainer.BackgroundColor3 = Color3.fromRGB(36,36,36)
editorContainer.BorderSizePixel = 0

-- ScrollingFrame (ocultamos scrollbar nativa)
local scrollFrame = Instance.new("ScrollingFrame", editorContainer)
scrollFrame.Size = UDim2.new(1,0,1,0)
scrollFrame.Position = UDim2.new(0,0,0,0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 0
scrollFrame.ClipsDescendants = true
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.XY
-- We'll manage CanvasSize manually (both X and Y)

-- Scrollbar (BACKGROUND) and HANDLE sizes/colors según pediste
local SCROLLBAR_BG = Color3.fromRGB(40,40,40)   -- background
local HANDLE_COLOR = Color3.fromRGB(33,33, 33)  -- handle
local SCROLLBAR_THICK = 16                      -- {0,16}, {1,0} -> 16px

-- Vertical scrollbar (right)
local vScrollBar = Instance.new("Frame", editorContainer)
vScrollBar.Name = "VScroll"
vScrollBar.Size = UDim2.new(0, SCROLLBAR_THICK, 1, 0)
vScrollBar.Position = UDim2.new(1, -SCROLLBAR_THICK, 0, 0)
vScrollBar.BackgroundColor3 = SCROLLBAR_BG
vScrollBar.BorderSizePixel = 0

local vHandle = Instance.new("Frame", vScrollBar)
vHandle.Name = "VHandle"
vHandle.Size = UDim2.new(1, 0, 0, 60) -- init, will update
vHandle.Position = UDim2.new(0,0,0,0)
vHandle.BackgroundColor3 = HANDLE_COLOR
vHandle.BorderSizePixel = 0
local vCorner = Instance.new("UICorner", vHandle)
vCorner.CornerRadius = UDim.new(0,4)

-- Horizontal scrollbar (bottom)
local hScrollBar = Instance.new("Frame", editorContainer)
hScrollBar.Name = "HScroll"
hScrollBar.Size = UDim2.new(1, -SCROLLBAR_THICK, 0, SCROLLBAR_THICK) -- leave space for vertical
hScrollBar.Position = UDim2.new(0, 0, 1, -SCROLLBAR_THICK - 20)
hScrollBar.BackgroundColor3 = SCROLLBAR_BG
hScrollBar.BorderSizePixel = 0

local hHandle = Instance.new("Frame", hScrollBar)
hHandle.Name = "HHandle"
hHandle.Size = UDim2.new(0, 80, 1, 0) -- init, will update
hHandle.Position = UDim2.new(0,0,0,0)
hHandle.BackgroundColor3 = HANDLE_COLOR
hHandle.BorderSizePixel = 0
local hCorner = Instance.new("UICorner", hHandle)
hCorner.CornerRadius = UDim.new(0,4)

-- Lines column
local linesFrame = Instance.new("Frame", scrollFrame)
linesFrame.Name = "Lines"
linesFrame.Position = UDim2.new(0,0,0,0)
linesFrame.Size = UDim2.new(0,40,1,0)
linesFrame.BackgroundTransparency = 1

local lineNumbers = Instance.new("TextLabel", linesFrame)
lineNumbers.Name = "LineNumbers"
lineNumbers.Size = UDim2.new(1,24,1,0)
lineNumbers.Position = UDim2.new(0,3,0,0)
lineNumbers.BackgroundTransparency = 1
lineNumbers.TextColor3 = Color3.fromRGB(204,204,204)
lineNumbers.TextSize = 14
lineNumbers.Font = Enum.Font.Code
lineNumbers.TextXAlignment = Enum.TextXAlignment.Center
lineNumbers.TextYAlignment = Enum.TextYAlignment.Top

-- TextBox (invisible) + highlight container
local editBox = Instance.new("TextBox", scrollFrame)
editBox.Name = "EditBox"
editBox.Size = UDim2.new(1, -40, 0, 200)
editBox.Position = UDim2.new(0,40,0,0)
editBox.BackgroundTransparency = 1
editBox.BorderSizePixel = 0
editBox.Text = "-- By Ultramix_7, Enjoy :) "
editBox.TextColor3 = Color3.fromRGB(204,204,204)
editBox.TextSize = 15
editBox.Font = Enum.Font.Code
editBox.MultiLine = true
editBox.TextWrapped = false
editBox.ClipsDescendants = true
editBox.ClearTextOnFocus = false
editBox.TextEditable = true
editBox.TextXAlignment = Enum.TextXAlignment.Left
editBox.TextYAlignment = Enum.TextYAlignment.Top
editBox.TextTransparency = 1 -- keep visible text via highlight labels

local highlightContainer = Instance.new("Folder", scrollFrame)
highlightContainer.Name = "HighlightRows"

-- Syntax colors (kept from original)
local Syntax = {
    Text = Color3.fromRGB(204,204,204),
    Operator = Color3.fromRGB(204,204,204),
    Number = Color3.fromRGB(255,198,0),
    String = Color3.fromRGB(173,241,149),
    Comment = Color3.fromRGB(102,102,102),
    Keyword = Color3.fromRGB(248,109,124),
    BuiltIn = Color3.fromRGB(132,214,247),
    LocalMethod = Color3.fromRGB(253,251,172),
    LocalProperty = Color3.fromRGB(97,161,241),
    Nil = Color3.fromRGB(255,198,0),
    Bool = Color3.fromRGB(255,198,0),
    Function = Color3.fromRGB(248,109,124),
    Local = Color3.fromRGB(248,109,124),
    Self = Color3.fromRGB(248,109,124),
    FunctionName = Color3.fromRGB(253,251,172),
    Bracket = Color3.fromRGB(204,204,204)
}

local function colorToHex(c)
    return string.format("#%02x%02x%02x", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
end

-- Tokenizer (kept)
local keywords = {
    ["and"]=true,["break"]=true,["do"]=true,["else"]=true,["elseif"]=true,["end"]=true,
    ["false"]=true,["for"]=true,["function"]=true,["if"]=true,["in"]=true,["local"]=true,
    ["nil"]=true,["not"]=true,["or"]=true,["repeat"]=true,["return"]=true,["then"]=true,
    ["true"]=true,["until"]=true,["while"]=true
}

local specialFuncs = {
    ["WaitForChild"] = true,
    ["FindFirstChild"] = true,
    ["GetService"] = true,
    ["Destroy"] = true,
    ["Clone"] = true,
    ["IsA"] = true,
    ["ClearAllChildren"] = true,
    ["GetChildren"] = true,
    ["GetDescendants"] = true,
    ["Connect"] = true,
    ["Disconnect"] = true,
    ["Fire"] = true,
    ["Invoke"] = true,
    ["rgb"] = true,
    ["FireServer"] = true,
    ["request"] = true,
    ["call"] = true, 
}
local specialBuiltIns = {
    ["game"] = true,
    ["Players"] = true,
    ["TweenService"] = true,
    ["ScreenGui"] = true,
    ["Instance"] = true,
    ["UDim2"] = true,
    ["Vector2"] = true,
    ["Vector3"] = true,
    ["Color3"] = true,
    ["Enum"] = true,
    ["loadstring"] = true,
    ["warn"] = true,
    ["pcall"] = true,
    ["print"] = true,
    ["UDim"] = true,
    ["delay"] = true,
    ["require"] = true, 
    ["spawn"] = true,
    ["tick"] = true,
    ["getfenv"] = true,
    ["workspace"] = true,
    ["setfenv"] = true,
    ["getgenv"] = true,
    ["script"] = true,
    ["string"] = true,
    ["pairs"] = true, 
    ["type"] = true,
    ["math"] = true,
    ["tonumber"] = true,
    ["tostring"] = true, 
    ["CFrame"] = true,
    ["BrickColor"] = true,
    ["table"] = true,
    ["Random"] = true, 
    ["Ray"] = true, 
    ["xpcall"] = true,
    ["coroutine"] = true,
    ["_G"] = true,
    ["_VERSION"] = true,
    ["debug"] = true,
    ["Axes"] = true,
    ["assert"] = true, 
    ["error"] = true, 
    ["ipairs"] = true, 
    ["rawequal"] = true,
    ["rawget"] = true,
    ["rawset"] = true,
    ["select"] = true,
}

local function tokenize(line)
    local tokens = {}
    local i = 1
    while i <= #line do
        local c = line:sub(i,i)
        if c == "-" and line:sub(i,i+1) == "--" then
            table.insert(tokens,{line:sub(i),"Comment"})
            break
        elseif c == '"' or c == "'" then
            local quote = c
            local j = i+1
            while j <= #line do
                if line:sub(j,j) == quote and line:sub(j-1,j-1) ~= "\\" then break end
                j=j+1
            end
            table.insert(tokens,{line:sub(i,j),"String"})
            i=j
        elseif c:match("%d") then
            local j=i
            while j <= #line and line:sub(j,j):match("[%d%.]") do j=j+1 end
            table.insert(tokens,{line:sub(i,j-1),"Number"})
            i=j-1
        elseif c:match("[%a_]") then
            local j=i
            while j <= #line and line:sub(j,j):match("[%w_]") do j=j+1 end
            table.insert(tokens,{line:sub(i,j-1),"Word"})
            i=j-1
        else
            table.insert(tokens,{c,"Operator"})
        end
        i=i+1
    end
    return tokens
end

local function detectType(tokens,index)
    local token = tokens[index]
    local val,typ = token[1], token[2]
    if typ ~= "Word" then return typ end
    if keywords[val] then return "Keyword" end
    if specialBuiltIns[val] then return "BuiltIn" end
    if specialFuncs[val] then return "LocalMethod" end
    if index > 1 and tokens[index-1][1] == "." then return "LocalProperty" end
    if index > 1 and tokens[index-1][1] == ":" then return "LocalMethod" end
    if val == "self" then return "Self" end
    if val == "true" or val == "false" then return "Bool" end
    if val == "nil" then return "Nil" end
    if index > 1 and tokens[index-1][1] == "function" then return "FunctionName" end
    return "Text"
end

local function highlightLine(line)
    local tokens = tokenize(line)
    local out = ""
    for i, token in ipairs(tokens) do
        local ttype = detectType(tokens,i)
        local color = Syntax[ttype] or Syntax.Text
        out = out .. string.format('<font color="%s">%s</font>', colorToHex(color), token[1]:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;"))
    end
    return out
end

-- Update highlights and also compute canvas width/height
local function updateLinesHighlight()
    -- limpiar viejo highlight
    for _,c in ipairs(highlightContainer:GetChildren()) do c:Destroy() end
    for _,c in ipairs(linesFrame:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end

    local text = editBox.Text or ""
    local linesTbl = {}
    local longestLen = 0
    for line in text:gmatch("([^\n]*)\n?") do
        table.insert(linesTbl, line)
        if #line > longestLen then longestLen = #line end
    end

    local lineHeight = editBox.TextSize + 4
    local yOffset = 0

    -- approximate char width
    local charWidth = math.floor(editBox.TextSize * 0.6)

    for i, line in ipairs(linesTbl) do
        -- Highlight label (richtext)
        local lbl = Instance.new("TextLabel")
        -- width will be set later based on canvas width; temporarily set full
        lbl.Size = UDim2.new(0, 0, 0, lineHeight) -- will set Width after calculating
        lbl.Position = UDim2.new(0, 40, 0, yOffset)
        lbl.BackgroundTransparency = 1
        lbl.Font = editBox.Font
        lbl.TextSize = editBox.TextSize
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextYAlignment = Enum.TextYAlignment.Top
        lbl.RichText = true
        lbl.TextWrapped = false
        lbl.Text = highlightLine(line)
        lbl.Parent = highlightContainer

        -- Número de línea
        local numLbl = Instance.new("TextLabel")
        numLbl.Size = UDim2.new(1, 0, 0, lineHeight)
        numLbl.Position = UDim2.new(0, 0, 0, yOffset)
        numLbl.BackgroundTransparency = 1
        numLbl.TextColor3 = Color3.fromRGB(204,204,204)
        numLbl.Font = editBox.Font
        numLbl.TextSize = editBox.TextSize
        numLbl.TextXAlignment = Enum.TextXAlignment.Center
        numLbl.TextYAlignment = Enum.TextYAlignment.Top
        numLbl.Text = tostring(i)
        numLbl.Parent = linesFrame

        yOffset = yOffset + lineHeight
    end

    -- compute canvas width in pixels from longest line
    local minContentWidth = math.max(200, scrollFrame.AbsoluteSize.X - 40) -- at least visible area
    local contentWidth = math.max(minContentWidth, longestLen * charWidth + 80) -- margins
    -- apply sizes now
    for _,lbl in ipairs(highlightContainer:GetChildren()) do
        if lbl:IsA("TextLabel") then
            lbl.Size = UDim2.new(0, contentWidth - 40, 0, lineHeight)
        end
    end

    linesFrame.Size = UDim2.new(0, 40, 0, yOffset)
    editBox.Size = UDim2.new(0, contentWidth, 0, yOffset)
    scrollFrame.CanvasSize = UDim2.new(0, contentWidth, 0, yOffset)
end

-- Connect and initial update
editBox:GetPropertyChangedSignal("Text"):Connect(updateLinesHighlight)
scrollFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLinesHighlight)
updateLinesHighlight()

-- ========== Custom scrollbar logic (pixel-perfect) ==========

local MIN_HANDLE_PIXELS = 40

local function clamp(n,a,b) if n < a then return a end if n > b then return b end return n end

local function updateHandles()
    -- Vertical
    local frameH = scrollFrame.AbsoluteSize.Y
    local canvasH = scrollFrame.CanvasSize.Y.Offset
    local trackH = vScrollBar.AbsoluteSize.Y
    if canvasH <= 0 then
        vHandle.Size = UDim2.new(1,0,1,0)
        vHandle.Position = UDim2.new(0,0,0,0)
    else
        if canvasH <= frameH then
            vHandle.Size = UDim2.new(1,0,1,0)
            vHandle.Position = UDim2.new(0,0,0,0)
        else
            local handleH = math.max(MIN_HANDLE_PIXELS, math.floor(frameH / canvasH * trackH))
            handleH = math.min(handleH, trackH)
            vHandle.Size = UDim2.new(1,0,0,handleH)
            local maxHandleTravel = trackH - handleH
            local maxCanvasTravel = canvasH - frameH
            local yOffset = 0
            if maxCanvasTravel > 0 then
                yOffset = math.floor(scrollFrame.CanvasPosition.Y / maxCanvasTravel * maxHandleTravel + 0.5)
            end
            vHandle.Position = UDim2.new(0,0,0,yOffset)
        end
    end

    -- Horizontal
    local frameW = scrollFrame.AbsoluteSize.X
    local canvasW = scrollFrame.CanvasSize.X.Offset
    local trackW = hScrollBar.AbsoluteSize.X
    if canvasW <= 0 then
        hHandle.Size = UDim2.new(1,0,1,0)
        hHandle.Position = UDim2.new(0,0,0,0)
    else
        if canvasW <= frameW then
            hHandle.Size = UDim2.new(1,0,1,0)
            hHandle.Position = UDim2.new(0,0,0,0)
        else
            local handleW = math.max(MIN_HANDLE_PIXELS, math.floor(frameW / canvasW * trackW))
            handleW = math.min(handleW, trackW)
            hHandle.Size = UDim2.new(0, handleW, 1, 0)
            local maxHandleTravelX = trackW - handleW
            local maxCanvasTravelX = canvasW - frameW
            local xOffset = 0
            if maxCanvasTravelX > 0 then
                xOffset = math.floor(scrollFrame.CanvasPosition.X / maxCanvasTravelX * maxHandleTravelX + 0.5)
            end
            hHandle.Position = UDim2.new(0, xOffset, 0, 0)
        end
    end
end

-- Sync when canvas moves (mouse wheel, keyboard, programmatic)
scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    updateHandles()
end)
scrollFrame:GetPropertyChangedSignal("CanvasSize"):Connect(function()
    updateHandles()
end)
vScrollBar:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateHandles)
hScrollBar:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateHandles)
RunService.RenderStepped:Connect(updateHandles)

-- Dragging behavior
local draggingV = false
local draggingH = false
local dragOffsetV = 0
local dragOffsetH = 0

vHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingV = true
        dragOffsetV = input.Position.Y - vHandle.AbsolutePosition.Y
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then draggingV = false end
        end)
    end
end)

hHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingH = true
        dragOffsetH = input.Position.X - hHandle.AbsolutePosition.X
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then draggingH = false end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if draggingV and input.UserInputType == Enum.UserInputType.MouseMovement then
        local trackY = vScrollBar.AbsolutePosition.Y
        local trackH = vScrollBar.AbsoluteSize.Y
        local handleH = vHandle.AbsoluteSize.Y
        local y = clamp(input.Position.Y - trackY - dragOffsetV, 0, math.max(0, trackH - handleH))
        vHandle.Position = UDim2.new(0,0,0,y)
        -- map to canvas
        local canvasH = scrollFrame.CanvasSize.Y.Offset
        local frameH = scrollFrame.AbsoluteSize.Y
        local maxCanvasTravel = math.max(0, canvasH - frameH)
        local maxHandleTravel = math.max(0, trackH - handleH)
        if maxHandleTravel > 0 then
            local newCanvasY = (y / maxHandleTravel) * maxCanvasTravel
            scrollFrame.CanvasPosition = Vector2.new(scrollFrame.CanvasPosition.X, math.floor(newCanvasY + 0.5))
        end
    end

    if draggingH and input.UserInputType == Enum.UserInputType.MouseMovement then
        local trackX = hScrollBar.AbsolutePosition.X
        local trackW = hScrollBar.AbsoluteSize.X
        local handleW = hHandle.AbsoluteSize.X
        local x = clamp(input.Position.X - trackX - dragOffsetH, 0, math.max(0, trackW - handleW))
        hHandle.Position = UDim2.new(0, x, 0, 0)
        -- map to canvas X
        local canvasW = scrollFrame.CanvasSize.X.Offset
        local frameW = scrollFrame.AbsoluteSize.X
        local maxCanvasTravelX = math.max(0, canvasW - frameW)
        local maxHandleTravelX = math.max(0, trackW - handleW)
        if maxHandleTravelX > 0 then
            local newCanvasX = (x / maxHandleTravelX) * maxCanvasTravelX
            scrollFrame.CanvasPosition = Vector2.new(math.floor(newCanvasX + 0.5), scrollFrame.CanvasPosition.Y)
        end
    end
end)

-- Allow clicking on track to move (page style)
vScrollBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and input.Target == vScrollBar then
        local relY = input.Position.Y - vScrollBar.AbsolutePosition.Y
        local handleH = vHandle.AbsoluteSize.Y
        local trackH = vScrollBar.AbsoluteSize.Y
        local maxHandleTravel = math.max(0, trackH - handleH)
        local y = clamp(relY - handleH/2, 0, maxHandleTravel)
        vHandle.Position = UDim2.new(0,0,0,y)
        -- update canvas
        local canvasH = scrollFrame.CanvasSize.Y.Offset
        local frameH = scrollFrame.AbsoluteSize.Y
        local maxCanvasTravel = math.max(0, canvasH - frameH)
        if maxHandleTravel > 0 then
            local newCanvasY = (y / maxHandleTravel) * maxCanvasTravel
            scrollFrame.CanvasPosition = Vector2.new(scrollFrame.CanvasPosition.X, math.floor(newCanvasY + 0.5))
        end
    end
end)

hScrollBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and input.Target == hScrollBar then
        local relX = input.Position.X - hScrollBar.AbsolutePosition.X
        local handleW = hHandle.AbsoluteSize.X
        local trackW = hScrollBar.AbsoluteSize.X
        local maxHandleTravel = math.max(0, trackW - handleW)
        local x = clamp(relX - handleW/2, 0, maxHandleTravel)
        hHandle.Position = UDim2.new(0,x,0,0)
        -- update canvas
        local canvasW = scrollFrame.CanvasSize.X.Offset
        local frameW = scrollFrame.AbsoluteSize.X
        local maxCanvasTravel = math.max(0, canvasW - frameW)
        if maxHandleTravel > 0 then
            local newCanvasX = (x / maxHandleTravel) * maxCanvasTravel
            scrollFrame.CanvasPosition = Vector2.new(math.floor(newCanvasX + 0.5), scrollFrame.CanvasPosition.Y)
        end
    end
end)

-- Basic copy/save/dump connections (kept)
copyButton.MouseButton1Click:Connect(function()
    if setclipboard then pcall(setclipboard, editBox.Text) end
end)
saveButton.MouseButton1Click:Connect(function()
    if writefile then pcall(writefile,"script.txt",editBox.Text) end
end)
dumpButton.MouseButton1Click:Connect(function()
    local funcs = {}
    for line in editBox.Text:gmatch("[^\r\n]+") do
        local fn = line:match("function%s+([%w_%.:]+)")
        if fn then table.insert(funcs,fn) end
    end
    if #funcs>0 then
        print("Funciones encontradas:")
        for _,f in ipairs(funcs) do print(f) end
    else
        print("No se encontraron funciones.")
    end
end)

-- Execute / Clear sample (kept minimal)
local executeButton = Instance.new("TextButton", content)
executeButton.Name = "Execute"
executeButton.Size = UDim2.new(0, 250, 0, 20)
executeButton.Position = UDim2.new(0, 1, 0, 360)
executeButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
executeButton.Text = "Execute"
executeButton.TextColor3 = Color3.fromRGB(255,255,255)
executeButton.TextSize = 8
executeButton.Font = Enum.Font.Legacy

executeButton.MouseButton1Click:Connect(function()
    local code = editBox.Text
    local func, err = loadstring(code)
    if func then
        pcall(func)
    else
        warn("Error en el código: "..err)
    end
end)

local clearButton = Instance.new("TextButton", content)
clearButton.Name = "Clear"
clearButton.Size = UDim2.new(0, 250, 0, 20)
clearButton.Position = UDim2.new(0, 250, 0, 360)
clearButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
clearButton.Text = "Clear"
clearButton.TextColor3 = Color3.fromRGB(255,255,255)
clearButton.TextSize = 8
clearButton.Font = Enum.Font.Legacy

clearButton.MouseButton1Click:Connect(function()
    editBox.Text = ""
    updateLinesHighlight()
end)

-- initial handle update
task.defer(updateHandles)

-- ======================
-- Scrollbar buttons (decorative)
-- ======================

-- Vertical scrollbar UP
local vUpBtn = Instance.new("Frame", vScrollBar)
vUpBtn.Size = UDim2.new(1,0,0,SCROLLBAR_THICK)
vUpBtn.Position = UDim2.new(0,0,0,0)
vUpBtn.BackgroundTransparency = 1 -- transparente
vUpBtn.BorderSizePixel = 0

local vUpArrow = Instance.new("TextLabel", vUpBtn)
vUpArrow.Size = UDim2.new(1,0,1,0)
vUpArrow.BackgroundTransparency = 1
vUpArrow.Text = "▲"
vUpArrow.TextColor3 = Color3.new(1,1,1)
vUpArrow.TextScaled = false

-- Vertical scrollbar DOWN
local vDownBtn = Instance.new("Frame", vScrollBar)
vDownBtn.Size = UDim2.new(1,0,0,SCROLLBAR_THICK)
vDownBtn.Position = UDim2.new(0,0,1,-SCROLLBAR_THICK)
vDownBtn.BackgroundTransparency = 1 -- transparente
vDownBtn.BorderSizePixel = 0

local vDownArrow = Instance.new("TextLabel", vDownBtn)
vDownArrow.Size = UDim2.new(1,0,1,0)
vDownArrow.BackgroundTransparency = 1
vDownArrow.Text = "▼"
vDownArrow.TextColor3 = Color3.new(1,1,1)
vDownArrow.TextScaled = false

-- Horizontal scrollbar LEFT
local hLeftBtn = Instance.new("Frame", hScrollBar)
hLeftBtn.Size = UDim2.new(0, SCROLLBAR_THICK, 1,0)
hLeftBtn.Position = UDim2.new(0,0,0,0)
hLeftBtn.BackgroundTransparency = 1 -- transparente
hLeftBtn.BorderSizePixel = 0

local hLeftArrow = Instance.new("TextLabel", hLeftBtn)
hLeftArrow.Size = UDim2.new(1,0,1,0)
hLeftArrow.BackgroundTransparency = 1
hLeftArrow.Text = "◄"
hLeftArrow.TextColor3 = Color3.new(1,1,1)
hLeftArrow.TextScaled = false

-- Horizontal scrollbar RIGHT
local hRightBtn = Instance.new("Frame", hScrollBar)
hRightBtn.Size = UDim2.new(0, SCROLLBAR_THICK, 1,0)
hRightBtn.Position = UDim2.new(1,-SCROLLBAR_THICK,0,0)
hRightBtn.BackgroundTransparency = 1 -- transparente
hRightBtn.BorderSizePixel = 0

local hRightArrow = Instance.new("TextLabel", hRightBtn)
hRightArrow.Size = UDim2.new(1,0,1,0)
hRightArrow.BackgroundTransparency = 1
hRightArrow.Text = "►"
hRightArrow.TextColor3 = Color3.new(1,1,1)
hRightArrow.TextScaled = false

-- === Selección en editor ===
local selectionFolder = Instance.new("Folder", scrollFrame)
selectionFolder.Name = "SelectionFolder"

local selectionColor = Color3.fromRGB(16, 131, 255)
local lineHeight = editBox.TextSize + 4
local minTextX = 44

local selecting = false
local startPosAbs

local function clearSelection()
    for _,c in ipairs(selectionFolder:GetChildren()) do c:Destroy() end
end

local function createPiece(lineIndex, xStart, xEnd)
    if xEnd <= xStart then return end
    local frame = Instance.new("Frame")
    frame.Name = "SelPart"
    frame.AnchorPoint = Vector2.new(0,0)
    frame.BackgroundColor3 = selectionColor
    frame.BackgroundTransparency = 0.45
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(0, math.max(2, math.floor(xEnd - xStart)), 0, lineHeight)
    frame.Position = UDim2.new(0, math.floor(xStart), 0, (lineIndex-1) * lineHeight)
    frame.ZIndex = 1
    frame.Parent = selectionFolder
end

local function clampLine(n, maxLines)
    if n < 1 then return 1 end
    if n > maxLines then return maxLines end
    return n
end

local function toLocalInContent(absVec2)
    local csPos = scrollFrame.AbsolutePosition
    return Vector2.new(absVec2.X - csPos.X, absVec2.Y - csPos.Y + scrollFrame.CanvasPosition.Y)
end

local function updateSelectionVisual(startAbs, currentAbs)
    clearSelection()
    if not startAbs or not currentAbs then return end

    local s = toLocalInContent(startAbs)
    local c = toLocalInContent(currentAbs)

    local linesTbl = {}
    for line in editBox.Text:gmatch("([^\n]*)\n?") do
        table.insert(linesTbl, line)
    end
    local maxLines = #linesTbl

    local sLine = clampLine(math.floor(s.Y / lineHeight) + 1, maxLines)
    local cLine = clampLine(math.floor(c.Y / lineHeight) + 1, maxLines)
    local minLine = math.min(sLine, cLine)
    local maxLine = math.max(sLine, cLine)

    local contentWidth = math.max(0, scrollFrame.AbsoluteSize.X)
    local leftBound = minTextX
    local rightBound = contentWidth - 6

    for line = minLine, maxLine do
        if minLine == maxLine then
            local x1 = math.max(leftBound, math.min(s.X, c.X))
            local x2 = math.min(rightBound, math.max(s.X, c.X))
            createPiece(line, x1, x2)
        else
            if line == minLine then
                local x1 = math.max(leftBound, s.X)
                local x2 = rightBound
                createPiece(line, x1, x2)
            elseif line == maxLine then
                local x1 = leftBound
                local x2 = math.min(rightBound, c.X)
                createPiece(line, x1, x2)
            else
                createPiece(line, leftBound, rightBound)
            end
        end
    end
end

-- === Eventos de Input ===
editBox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        selecting = true
        startPosAbs = input.Position
        scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y -- Solo vertical mientras seleccionas
    end
end)

editBox.InputChanged:Connect(function(input)
    if selecting and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSelectionVisual(startPosAbs, input.Position)
    end
end)

editBox.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        selecting = false
        scrollFrame.ScrollingDirection = Enum.ScrollingDirection.XY -- Restaurar XY al soltar
    end
end)

task.wait(0.2) -- pequeña espera por seguridad

local cursor = Instance.new("Frame")
cursor.Name = "SelectionCursor"
cursor.Size = UDim2.new(0, 1, 0, 20)
cursor.Position = UDim2.new(0, 0, 0, 0)
cursor.AnchorPoint = Vector2.new(0, 0)
cursor.BackgroundColor3 = Color3.fromRGB(171, 171, 171)
cursor.BorderSizePixel = 0
cursor.BackgroundTransparency = 0
cursor.ZIndex = 100
cursor.Visible = true
cursor.Parent = editBox

print("Cursor creado:", cursor.Parent)

-- Parpadeo del cursor
task.spawn(function()
	while cursor and cursor.Parent do
		cursor.Visible = not cursor.Visible
		task.wait(0.5) -- cada medio segundo cambia de estado
	end
end)

-- Movimiento del cursor con toques
local lineHeight = 20 -- mismo valor que usas para el texto
local minTextX = 44   -- margen izquierdo (como en tu selección)

editBox.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		-- Convertir posición absoluta del toque a Vector2
		local absTouch = Vector2.new(input.Position.X, input.Position.Y)
		local localPos = absTouch - editBox.AbsolutePosition

		-- Calcular línea y columna aproximada
		local lineIndex = math.floor(localPos.Y / lineHeight)
		local cursorX = math.max(minTextX, localPos.X)
		local cursorY = lineIndex * lineHeight

		-- Actualizar posición del cursor
		cursor.Position = UDim2.new(0, cursorX, 0, cursorY)
	end
end)

-- Ajustar tamaño del editBox según texto
editBox:GetPropertyChangedSignal("Text"):Connect(function()
	local lines = select(2, editBox.Text:gsub("\n", "")) + 1
	local totalHeight = lines * lineHeight
	editBox.Size = UDim2.new(1, 0, 0, totalHeight)
end)

local icon = Instance.new("ImageLabel")
icon.Name = "NotepadIcon"
icon.Size = UDim2.new(0, 16, 0, 16) -- tamaño
icon.Position = UDim2.new(0, 75, 0, 2) -- posición dentro de mainFrame
icon.BackgroundTransparency = 1 -- sin fondo
icon.Image = "rbxassetid://475456048"
icon.ZIndex = 30
icon.Parent = main
