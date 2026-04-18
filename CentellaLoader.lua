-- ╔══════════════════════════════════════════════════════════════════╗
-- ║         🌿 Centella asiatica — by VanTuanDEV 🌿                ║
-- ║         Loader Script | Sailor Piece                            ║
-- ╚══════════════════════════════════════════════════════════════════╝

if getgenv and getgenv().CENTELLA_RUNNING then
    warn("[Centella] Script already running!")
    return
end
if getgenv then getgenv().CENTELLA_RUNNING = true end

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.GameId ~= 0

-- ─────────────────────────────────────────────────────────────────
--  SERVICES
-- ─────────────────────────────────────────────────────────────────
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local LP               = Players.LocalPlayer
local PGui             = LP:WaitForChild("PlayerGui")

-- ─────────────────────────────────────────────────────────────────
--  HELPER
-- ─────────────────────────────────────────────────────────────────
local function Tween(obj, info, props)
    return TweenService:Create(obj, info, props)
end

local function Shadow(parent, size, transparency)
    local s = Instance.new("ImageLabel")
    s.Name = "Shadow"
    s.AnchorPoint = Vector2.new(0.5, 0.5)
    s.BackgroundTransparency = 1
    s.Image = "rbxassetid://6014261993"
    s.ImageColor3 = Color3.fromRGB(0, 0, 0)
    s.ImageTransparency = transparency or 0.5
    s.ScaleType = Enum.ScaleType.Slice
    s.SliceCenter = Rect.new(49, 49, 450, 450)
    s.Size = UDim2.new(1, size or 30, 1, size or 30)
    s.Position = UDim2.new(0.5, 0, 0.5, 4)
    s.ZIndex = parent.ZIndex - 1
    s.Parent = parent
    return s
end

local function Stroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(80, 160, 80)
    s.Thickness = thickness or 1.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

-- ─────────────────────────────────────────────────────────────────
--  DESTROY OLD GUI
-- ─────────────────────────────────────────────────────────────────
for _, v in pairs(PGui:GetChildren()) do
    if v.Name == "CentellaLoader" then v:Destroy() end
end

-- ─────────────────────────────────────────────────────────────────
--  SCREEN GUI
-- ─────────────────────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CentellaLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = PGui
end

-- ─────────────────────────────────────────────────────────────────
--  BACKGROUND BLUR OVERLAY
-- ─────────────────────────────────────────────────────────────────
local Overlay = Instance.new("Frame")
Overlay.Name = "Overlay"
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.45
Overlay.BorderSizePixel = 0
Overlay.ZIndex = 1
Overlay.Parent = ScreenGui

-- Subtle grain texture
local Grain = Instance.new("ImageLabel")
Grain.Size = UDim2.new(1, 0, 1, 0)
Grain.BackgroundTransparency = 1
Grain.Image = "rbxassetid://8639959236"
Grain.ImageTransparency = 0.92
Grain.ImageColor3 = Color3.fromRGB(120, 200, 120)
Grain.ScaleType = Enum.ScaleType.Tile
Grain.TileSize = UDim2.new(0, 200, 0, 200)
Grain.ZIndex = 2
Grain.Parent = ScreenGui

-- ─────────────────────────────────────────────────────────────────
--  MAIN WINDOW
-- ─────────────────────────────────────────────────────────────────
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 520, 0, 580)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.BorderSizePixel = 0
Main.ZIndex = 3
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
Stroke(Main, Color3.fromRGB(70, 155, 70), 1.5)

-- Subtle top gradient accent
local TopGrad = Instance.new("Frame")
TopGrad.Size = UDim2.new(1, 0, 0, 3)
TopGrad.Position = UDim2.new(0, 0, 0, 0)
TopGrad.BackgroundColor3 = Color3.fromRGB(80, 175, 80)
TopGrad.BorderSizePixel = 0
TopGrad.ZIndex = 10
TopGrad.Parent = Main

local TopGradUI = Instance.new("UIGradient")
TopGradUI.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 120, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 120, 40)),
})
TopGradUI.Parent = TopGrad

-- Decorative corner dots
local function CornerDot(x, y)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(0, 5, 0, 5)
    d.Position = UDim2.new(x, x == 0 and 8 or -13, y, y == 0 and 8 or -13)
    d.BackgroundColor3 = Color3.fromRGB(70, 155, 70)
    d.BorderSizePixel = 0
    d.ZIndex = 10
    d.Parent = Main
    Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
end
CornerDot(0, 0) CornerDot(1, 0) CornerDot(0, 1) CornerDot(1, 1)

-- ─────────────────────────────────────────────────────────────────
--  HEADER
-- ─────────────────────────────────────────────────────────────────
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 110)
Header.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Header.BorderSizePixel = 0
Header.ZIndex = 4
Header.Parent = Main

local HeaderBottomLine = Instance.new("Frame")
HeaderBottomLine.Size = UDim2.new(1, 0, 0, 1)
HeaderBottomLine.Position = UDim2.new(0, 0, 1, -1)
HeaderBottomLine.BackgroundColor3 = Color3.fromRGB(60, 140, 60)
HeaderBottomLine.BorderSizePixel = 0
HeaderBottomLine.ZIndex = 5
HeaderBottomLine.Parent = Header

-- Avatar / Icon frame
local IconFrame = Instance.new("Frame")
IconFrame.Name = "IconFrame"
IconFrame.Size = UDim2.new(0, 72, 0, 72)
IconFrame.Position = UDim2.new(0, 18, 0.5, -36)
IconFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
IconFrame.BorderSizePixel = 0
IconFrame.ZIndex = 6
IconFrame.Parent = Header
Instance.new("UICorner", IconFrame).CornerRadius = UDim.new(0, 10)
Stroke(IconFrame, Color3.fromRGB(70, 155, 70), 1.5)

-- Avatar image (the cute sleeping character from user)
local Avatar = Instance.new("ImageLabel")
Avatar.Name = "Avatar"
Avatar.Size = UDim2.new(1, -4, 1, -4)
Avatar.Position = UDim2.new(0, 2, 0, 2)
Avatar.BackgroundTransparency = 1
Avatar.Image = "rbxassetid://75791874"   -- placeholder; replace with uploaded texture ID
Avatar.ScaleType = Enum.ScaleType.Fit
Avatar.ZIndex = 7
Avatar.Parent = IconFrame

-- Centella leaf badge overlay on icon
local LeafBadge = Instance.new("ImageLabel")
LeafBadge.Name = "LeafBadge"
LeafBadge.Size = UDim2.new(0, 26, 0, 26)
LeafBadge.Position = UDim2.new(1, -10, 1, -10)
LeafBadge.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
LeafBadge.BorderSizePixel = 0
LeafBadge.Image = "rbxassetid://11963751409"  -- leaf icon
LeafBadge.ImageColor3 = Color3.fromRGB(90, 190, 90)
LeafBadge.ZIndex = 8
LeafBadge.Parent = IconFrame
Instance.new("UICorner", LeafBadge).CornerRadius = UDim.new(1, 0)
Stroke(LeafBadge, Color3.fromRGB(60, 140, 60), 1)

-- Title text block
local TitleBlock = Instance.new("Frame")
TitleBlock.Size = UDim2.new(1, -108, 0, 72)
TitleBlock.Position = UDim2.new(0, 100, 0.5, -36)
TitleBlock.BackgroundTransparency = 1
TitleBlock.ZIndex = 6
TitleBlock.Parent = Header

-- 🌿 icon prefix
local LeafPrefix = Instance.new("TextLabel")
LeafPrefix.Size = UDim2.new(0, 30, 0, 26)
LeafPrefix.Position = UDim2.new(0, 0, 0, 8)
LeafPrefix.BackgroundTransparency = 1
LeafPrefix.Text = "🌿"
LeafPrefix.TextSize = 20
LeafPrefix.Font = Enum.Font.GothamBold
LeafPrefix.ZIndex = 7
LeafPrefix.Parent = TitleBlock

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, -32, 0, 28)
TitleLabel.Position = UDim2.new(0, 30, 0, 6)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Centella asiatica"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 7
TitleLabel.Parent = TitleBlock

-- Gradient on title
local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(180, 235, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 200, 120)),
})
TitleGrad.Rotation = 0
TitleGrad.Parent = TitleLabel

local SubLabel = Instance.new("TextLabel")
SubLabel.Name = "Sub"
SubLabel.Size = UDim2.new(1, -30, 0, 18)
SubLabel.Position = UDim2.new(0, 30, 0, 36)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "by VanTuanDEV  •  Sailor Piece"
SubLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
SubLabel.TextSize = 12
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLabel.ZIndex = 7
SubLabel.Parent = TitleBlock

-- Version badge
local VerBadge = Instance.new("Frame")
VerBadge.Size = UDim2.new(0, 58, 0, 20)
VerBadge.Position = UDim2.new(0, 30, 0, 58)
VerBadge.BackgroundColor3 = Color3.fromRGB(20, 45, 20)
VerBadge.BorderSizePixel = 0
VerBadge.ZIndex = 7
VerBadge.Parent = TitleBlock
Instance.new("UICorner", VerBadge).CornerRadius = UDim.new(0, 5)
Stroke(VerBadge, Color3.fromRGB(60, 140, 60), 1)

local VerText = Instance.new("TextLabel")
VerText.Size = UDim2.new(1, 0, 1, 0)
VerText.BackgroundTransparency = 1
VerText.Text = "v 1.0"
VerText.TextColor3 = Color3.fromRGB(90, 190, 90)
VerText.TextSize = 11
VerText.Font = Enum.Font.GothamBold
VerText.ZIndex = 8
VerText.Parent = VerBadge

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "Close"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -44, 0, 14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 8
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
Stroke(CloseBtn, Color3.fromRGB(50, 50, 50), 1)

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "Min"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -80, 0, 14)
MinBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "─"
MinBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
MinBtn.TextSize = 13
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 8
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)
Stroke(MinBtn, Color3.fromRGB(50, 50, 50), 1)

-- ─────────────────────────────────────────────────────────────────
--  TAB BAR
-- ─────────────────────────────────────────────────────────────────
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, 0, 0, 38)
TabBar.Position = UDim2.new(0, 0, 0, 110)
TabBar.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 4
TabBar.Parent = Main

local TabBarLine = Instance.new("Frame")
TabBarLine.Size = UDim2.new(1, 0, 0, 1)
TabBarLine.Position = UDim2.new(0, 0, 1, -1)
TabBarLine.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabBarLine.BorderSizePixel = 0
TabBarLine.ZIndex = 5
TabBarLine.Parent = TabBar

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 2)
TabList.Parent = TabBar

local TabPad = Instance.new("UIPadding")
TabPad.PaddingLeft = UDim.new(0, 8)
TabPad.PaddingTop = UDim.new(0, 5)
TabPad.Parent = TabBar

-- ─────────────────────────────────────────────────────────────────
--  CONTENT AREA
-- ─────────────────────────────────────────────────────────────────
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -150)
Content.Position = UDim2.new(0, 0, 0, 150)
Content.BackgroundTransparency = 1
Content.ZIndex = 4
Content.ClipsDescendants = true
Content.Parent = Main

-- ─────────────────────────────────────────────────────────────────
--  STATUS BAR
-- ─────────────────────────────────────────────────────────────────
local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Size = UDim2.new(1, 0, 0, 28)
StatusBar.Position = UDim2.new(0, 0, 1, -28)
StatusBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
StatusBar.BorderSizePixel = 0
StatusBar.ZIndex = 6
StatusBar.Parent = Main

local StatusTopLine = Instance.new("Frame")
StatusTopLine.Size = UDim2.new(1, 0, 0, 1)
StatusTopLine.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
StatusTopLine.BorderSizePixel = 0
StatusTopLine.ZIndex = 7
StatusTopLine.Parent = StatusBar

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0, 7, 0, 7)
StatusDot.Position = UDim2.new(0, 10, 0.5, -3)
StatusDot.BackgroundColor3 = Color3.fromRGB(80, 190, 80)
StatusDot.BorderSizePixel = 0
StatusDot.ZIndex = 7
StatusDot.Parent = StatusBar
Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -80, 1, 0)
StatusText.Position = UDim2.new(0, 22, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Ready — Sailor Piece detected"
StatusText.TextColor3 = Color3.fromRGB(90, 90, 90)
StatusText.TextSize = 11
StatusText.Font = Enum.Font.Gotham
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.ZIndex = 7
StatusText.Parent = StatusBar

local StatusTime = Instance.new("TextLabel")
StatusTime.Size = UDim2.new(0, 70, 1, 0)
StatusTime.Position = UDim2.new(1, -75, 0, 0)
StatusTime.BackgroundTransparency = 1
StatusTime.Text = "00:00"
StatusTime.TextColor3 = Color3.fromRGB(60, 60, 60)
StatusTime.TextSize = 11
StatusTime.Font = Enum.Font.GothamMono
StatusTime.ZIndex = 7
StatusTime.Parent = StatusBar

-- ─────────────────────────────────────────────────────────────────
--  HELPER: CREATE TAB + PAGE
-- ─────────────────────────────────────────────────────────────────
local Tabs = {}
local Pages = {}
local CurrentTab = nil

local function SetStatus(txt, isError)
    StatusText.Text = txt
    StatusDot.BackgroundColor3 = isError
        and Color3.fromRGB(200, 60, 60)
        or  Color3.fromRGB(80, 190, 80)
end

local function CreateTab(name, icon, order)
    local Btn = Instance.new("TextButton")
    Btn.Name = "Tab_"..name
    Btn.Size = UDim2.new(0, 0, 1, -5)
    Btn.AutomaticSize = Enum.AutomaticSize.X
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 5
    Btn.LayoutOrder = order
    Btn.Parent = TabBar

    local Inner = Instance.new("Frame")
    Inner.Size = UDim2.new(1, 0, 1, 0)
    Inner.BackgroundTransparency = 1
    Inner.ZIndex = 5
    Inner.Parent = Btn

    local BtnPad = Instance.new("UIPadding")
    BtnPad.PaddingLeft = UDim.new(0, 12)
    BtnPad.PaddingRight = UDim.new(0, 12)
    BtnPad.Parent = Btn

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = (icon and icon.." " or "")..name
    Lbl.TextColor3 = Color3.fromRGB(80, 80, 80)
    Lbl.TextSize = 12
    Lbl.Font = Enum.Font.GothamBold
    Lbl.ZIndex = 6
    Lbl.Parent = Inner

    local ActiveLine = Instance.new("Frame")
    ActiveLine.Size = UDim2.new(0, 0, 0, 2)
    ActiveLine.Position = UDim2.new(0.5, 0, 1, -2)
    ActiveLine.AnchorPoint = Vector2.new(0.5, 0)
    ActiveLine.BackgroundColor3 = Color3.fromRGB(80, 175, 80)
    ActiveLine.BorderSizePixel = 0
    ActiveLine.ZIndex = 6
    ActiveLine.Parent = Inner

    -- Page
    local Page = Instance.new("ScrollingFrame")
    Page.Name = "Page_"..name
    Page.Size = UDim2.new(1, 0, 1, -28)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(70, 155, 70)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.ZIndex = 4
    Page.Parent = Content

    local PagePad = Instance.new("UIPadding")
    PagePad.PaddingLeft = UDim.new(0, 14)
    PagePad.PaddingRight = UDim.new(0, 14)
    PagePad.PaddingTop = UDim.new(0, 10)
    PagePad.PaddingBottom = UDim.new(0, 10)
    PagePad.Parent = Page

    local PageList = Instance.new("UIListLayout")
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 8)
    PageList.Parent = Page

    local tabData = { Btn=Btn, Lbl=Lbl, ActiveLine=ActiveLine, Page=Page }
    table.insert(Tabs, tabData)
    Pages[name] = Page

    Btn.MouseButton1Click:Connect(function()
        for _, t in ipairs(Tabs) do
            t.Lbl.TextColor3 = Color3.fromRGB(80, 80, 80)
            Tween(t.ActiveLine, TweenInfo.new(0.18), {Size=UDim2.new(0,0,0,2)}):Play()
            t.Page.Visible = false
        end
        Lbl.TextColor3 = Color3.fromRGB(190, 230, 190)
        Tween(ActiveLine, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size=UDim2.new(1,0,0,2)}):Play()
        Page.Visible = true
        CurrentTab = name
    end)

    return Page
end

-- ─────────────────────────────────────────────────────────────────
--  HELPER: SECTION & ELEMENTS
-- ─────────────────────────────────────────────────────────────────
local function CreateSection(page, title, order)
    local Sec = Instance.new("Frame")
    Sec.Name = "Section_"..title
    Sec.Size = UDim2.new(1, 0, 0, 0)
    Sec.AutomaticSize = Enum.AutomaticSize.Y
    Sec.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    Sec.BorderSizePixel = 0
    Sec.ZIndex = 5
    Sec.LayoutOrder = order or 0
    Sec.Parent = page
    Instance.new("UICorner", Sec).CornerRadius = UDim.new(0, 8)
    Stroke(Sec, Color3.fromRGB(32, 32, 32), 1)

    local SecPad = Instance.new("UIPadding")
    SecPad.PaddingLeft = UDim.new(0, 12)
    SecPad.PaddingRight = UDim.new(0, 12)
    SecPad.PaddingTop = UDim.new(0, 6)
    SecPad.PaddingBottom = UDim.new(0, 10)
    SecPad.Parent = Sec

    local SecList = Instance.new("UIListLayout")
    SecList.SortOrder = Enum.SortOrder.LayoutOrder
    SecList.Padding = UDim.new(0, 5)
    SecList.Parent = Sec

    -- Header row
    local TitleRow = Instance.new("Frame")
    TitleRow.Size = UDim2.new(1, 0, 0, 26)
    TitleRow.BackgroundTransparency = 1
    TitleRow.ZIndex = 6
    TitleRow.LayoutOrder = 0
    TitleRow.Parent = Sec

    local TitleAccent = Instance.new("Frame")
    TitleAccent.Size = UDim2.new(0, 3, 0, 14)
    TitleAccent.Position = UDim2.new(0, 0, 0.5, -7)
    TitleAccent.BackgroundColor3 = Color3.fromRGB(70, 155, 70)
    TitleAccent.BorderSizePixel = 0
    TitleAccent.ZIndex = 7
    TitleAccent.Parent = TitleRow
    Instance.new("UICorner", TitleAccent).CornerRadius = UDim.new(0, 2)

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, -12, 1, 0)
    TitleLbl.Position = UDim2.new(0, 10, 0, 0)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = title:upper()
    TitleLbl.TextColor3 = Color3.fromRGB(70, 155, 70)
    TitleLbl.TextSize = 10
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.ZIndex = 7
    TitleLbl.Parent = TitleRow

    local Content2 = Instance.new("Frame")
    Content2.Name = "Items"
    Content2.Size = UDim2.new(1, 0, 0, 0)
    Content2.AutomaticSize = Enum.AutomaticSize.Y
    Content2.BackgroundTransparency = 1
    Content2.ZIndex = 6
    Content2.LayoutOrder = 1
    Content2.Parent = Sec

    local ItemList = Instance.new("UIListLayout")
    ItemList.SortOrder = Enum.SortOrder.LayoutOrder
    ItemList.Padding = UDim.new(0, 4)
    ItemList.Parent = Content2

    return Content2
end

-- Toggle element
local Toggles = {}
local function CreateToggle(parent, labelText, description, order, defaultVal, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 42)
    Row.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
    Row.BorderSizePixel = 0
    Row.ZIndex = 7
    Row.LayoutOrder = order or 0
    Row.Parent = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    Stroke(Row, Color3.fromRGB(30, 30, 30), 1)

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -58, 0, 20)
    Lbl.Position = UDim2.new(0, 10, 0, 6)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = labelText
    Lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
    Lbl.TextSize = 13
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 8
    Lbl.Parent = Row

    if description and description ~= "" then
        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1, -58, 0, 14)
        Desc.Position = UDim2.new(0, 10, 0, 24)
        Desc.BackgroundTransparency = 1
        Desc.Text = description
        Desc.TextColor3 = Color3.fromRGB(70, 70, 70)
        Desc.TextSize = 10
        Desc.Font = Enum.Font.Gotham
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.ZIndex = 8
        Desc.Parent = Row
    end

    -- Toggle switch
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0, 40, 0, 22)
    Track.Position = UDim2.new(1, -50, 0.5, -11)
    Track.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Track.BorderSizePixel = 0
    Track.ZIndex = 8
    Track.Parent = Row
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
    Stroke(Track, Color3.fromRGB(40, 40, 40), 1)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, 3, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 9
    Knob.Parent = Track
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 10
    Btn.Parent = Track

    local val = defaultVal or false

    local function SetVal(v, skipCb)
        val = v
        if v then
            Tween(Track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 110, 45)}):Play()
            Tween(Knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0, 21, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(100, 210, 100)
            }):Play()
        else
            Tween(Track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            Tween(Knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0, 3, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            }):Play()
        end
        if not skipCb and callback then callback(v) end
    end

    SetVal(val, true)

    Btn.MouseButton1Click:Connect(function() SetVal(not val) end)
    Row.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then SetVal(not val) end
    end)

    local obj = { SetValue = SetVal, GetValue = function() return val end }
    table.insert(Toggles, obj)
    return obj
end

-- Button element
local function CreateButton(parent, labelText, desc, order, callback)
    local Row = Instance.new("TextButton")
    Row.Size = UDim2.new(1, 0, 0, 38)
    Row.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
    Row.BorderSizePixel = 0
    Row.Text = ""
    Row.ZIndex = 7
    Row.LayoutOrder = order or 0
    Row.Parent = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    Stroke(Row, Color3.fromRGB(30, 30, 30), 1)

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -16, 1, 0)
    Lbl.Position = UDim2.new(0, 10, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = labelText
    Lbl.TextColor3 = Color3.fromRGB(190, 190, 190)
    Lbl.TextSize = 12
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 8
    Lbl.Parent = Row

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -24, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "›"
    Arrow.TextColor3 = Color3.fromRGB(70, 155, 70)
    Arrow.TextSize = 18
    Arrow.Font = Enum.Font.GothamBold
    Arrow.ZIndex = 8
    Arrow.Parent = Row

    Row.MouseEnter:Connect(function()
        Tween(Row, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(26, 26, 26)}):Play()
    end)
    Row.MouseLeave:Connect(function()
        Tween(Row, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(21, 21, 21)}):Play()
    end)
    Row.MouseButton1Click:Connect(function()
        Tween(Row, TweenInfo.new(0.06), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        task.delay(0.08, function()
            Tween(Row, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(21, 21, 21)}):Play()
        end)
        if callback then callback() end
    end)
    return Row
end

-- Label element
local function CreateLabel(parent, text, order, isHighlight)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 0, 0)
    Lbl.AutomaticSize = Enum.AutomaticSize.Y
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = isHighlight and Color3.fromRGB(90, 180, 90) or Color3.fromRGB(85, 85, 85)
    Lbl.TextSize = 11
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextWrapped = true
    Lbl.ZIndex = 7
    Lbl.LayoutOrder = order or 0
    Lbl.Parent = parent
    return Lbl
end

-- Divider
local function CreateDivider(parent, order)
    local D = Instance.new("Frame")
    D.Size = UDim2.new(1, 0, 0, 1)
    D.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    D.BorderSizePixel = 0
    D.ZIndex = 7
    D.LayoutOrder = order or 0
    D.Parent = parent
    return D
end

-- ─────────────────────────────────────────────────────────────────
--  BUILD TABS
-- ─────────────────────────────────────────────────────────────────
local P_Main     = CreateTab("Main",      "⚔",  1)
local P_Boss     = CreateTab("Boss",      "💀",  2)
local P_Auto     = CreateTab("Auto",      "🔄",  3)
local P_Player   = CreateTab("Player",    "🧑",  4)
local P_Misc     = CreateTab("Misc",      "🌿",  5)
local P_Config   = CreateTab("Config",    "⚙",   6)

-- ─────────────────────────────────────────────────────────────────
--  RUNTIME STATE (mirrors script's runtime flags)
-- ─────────────────────────────────────────────────────────────────
local RT = {
    Farm = false,
    MobFarm = false,
    AllMobFarm = false,
    LevelFarm = false,
    BossFarm = false,
    AllBossFarm = false,
    AutoSummon = false,
    SummonBossFarm = false,
    PityBossFarm = false,
    AltBossFarm = false,
    ObserHaki = false,
    ArmHaki = false,
    ConquerorHaki = false,
    AutoM1 = false,
    AutoSkill = false,
    AutoCombo = false,
    SwitchWeapon = false,
    AutoStats = false,
    AutoRollStats = false,
    AutoAscend = false,
    AutoTrait = false,
    AutoRace = false,
    AutoClan = false,
    AutoSpec = false,
    AutoSkillTree = false,
    ArtifactMilestone = false,
    AutoEnchant = false,
    AutoBlessing = false,
    ArtifactLock = false,
    ArtifactDelete = false,
    ArtifactUpgrade = false,
    AutoDungeon = false,
    AutoInfiniteTower = false,
    AutoMerchant = false,
    AutoChest = false,
    AutoCraftItem = false,
    DungeonQuest = false,
    HogyokuQuest = false,
    AntiAFK = true,
    AutoReconnect = false,
    FPSBoost = false,
    Noclip = false,
    AntiKnockback = false,
    SendWebhook = false,
    AutoKick = false,
    AutoQuestline = false,
    KillAura = false,
    InstaKill = false,
}

-- ─────────────────────────────────────────────────────────────────
--  TAB: MAIN (Autofarm)
-- ─────────────────────────────────────────────────────────────────
do
    local s1 = CreateSection(P_Main, "Auto Farm", 1)
    CreateToggle(s1, "🗡 Autofarm Mob", "Farm selected mob automatically", 1, false, function(v) RT.MobFarm = v end)
    CreateToggle(s1, "🌀 Autofarm All Mobs", "Rotate through all available mobs", 2, false, function(v) RT.AllMobFarm = v end)
    CreateToggle(s1, "📈 Autofarm Level", "Farm with best quest NPC for your level", 3, false, function(v) RT.LevelFarm = v end)

    local s2 = CreateSection(P_Main, "Skills & Combat", 2)
    CreateToggle(s2, "👊 Auto Attack (M1)", "Spam M1 automatically", 1, false, function(v) RT.AutoM1 = v end)
    CreateToggle(s2, "💥 Auto Use Skills", "Use Z/X/C/V/F skills automatically", 2, false, function(v) RT.AutoSkill = v end)
    CreateToggle(s2, "🌀 Auto Skill Combo", "Execute skill combo pattern", 3, false, function(v) RT.AutoCombo = v end)
    CreateToggle(s2, "⚡ Kill Aura", "Attack nearest NPC in range", 4, false, function(v) RT.KillAura = v end)
    CreateToggle(s2, "☠ Instant Kill", "Force kill when HP threshold reached", 5, false, function(v) RT.InstaKill = v end)
    CreateToggle(s2, "🔄 Auto Switch Weapon", "Rotate weapon types during farm", 6, true, function(v) RT.SwitchWeapon = v end)

    local s3 = CreateSection(P_Main, "Haki", 3)
    CreateToggle(s3, "👁 Observation Haki", "Keep observation haki active", 1, false, function(v) RT.ObserHaki = v end)
    CreateToggle(s3, "💪 Armament Haki", "Keep armament haki active", 2, false, function(v) RT.ArmHaki = v end)
    CreateToggle(s3, "👑 Conqueror Haki", "Keep conqueror haki active", 3, false, function(v) RT.ConquerorHaki = v end)
end

-- ─────────────────────────────────────────────────────────────────
--  TAB: BOSS
-- ─────────────────────────────────────────────────────────────────
do
    local s1 = CreateSection(P_Boss, "Boss Farm", 1)
    CreateToggle(s1, "💀 Autofarm Boss", "Farm selected world bosses", 1, false, function(v) RT.BossFarm = v end)
    CreateToggle(s1, "💀 Autofarm All Bosses", "Farm any boss that spawns", 2, false, function(v) RT.AllBossFarm = v end)

    local s2 = CreateSection(P_Boss, "Summon Boss", 2)
    CreateToggle(s2, "🔮 Auto Summon", "Auto summon selected summon boss", 1, false, function(v) RT.AutoSummon = v end)
    CreateToggle(s2, "⚔ Autofarm Summon Boss", "Farm the summoned boss", 2, false, function(v) RT.SummonBossFarm = v end)
    CreateToggle(s2, "📊 Pity Boss Farm", "Build pity then use pity boss", 3, false, function(v) RT.PityBossFarm = v end)

    local s3 = CreateSection(P_Boss, "Alt / Misc Boss", 3)
    CreateToggle(s3, "🤝 Auto Help Alt", "Help alt account kill boss", 1, false, function(v) RT.AltBossFarm = v end)
    CreateLabel(s3, "⚠ Configure boss selection & difficulty in-game after loading script", 2)
end

-- ─────────────────────────────────────────────────────────────────
--  TAB: AUTO (Automation)
-- ─────────────────────────────────────────────────────────────────
do
    local s1 = CreateSection(P_Auto, "Stats & Progression", 1)
    CreateToggle(s1, "📊 Auto Allocate Stats", "Auto spend stat points", 1, false, function(v) RT.AutoStats = v end)
    CreateToggle(s1, "🎲 Auto Roll Gem Stats", "Reroll gem stats to target rank", 2, false, function(v) RT.AutoRollStats = v end)
    CreateToggle(s1, "⬆ Auto Ascend", "Automatically ascend when ready", 3, false, function(v) RT.AutoAscend = v end)
    CreateToggle(s1, "🌳 Auto Skill Tree", "Auto upgrade skill tree nodes", 4, false, function(v) RT.AutoSkillTree = v end)

    local s2 = CreateSection(P_Auto, "Rolls", 2)
    CreateToggle(s2, "🃏 Auto Roll Trait", "Keep rolling for target trait", 1, false, function(v) RT.AutoTrait = v end)
    CreateToggle(s2, "🧬 Auto Roll Race", "Keep rolling for target race", 2, false, function(v) RT.AutoRace = v end)
    CreateToggle(s2, "🛡 Auto Roll Clan", "Keep rolling for target clan", 3, false, function(v) RT.AutoClan = v end)
    CreateToggle(s2, "🔮 Auto Reroll Passive", "Auto reroll spec passive", 4, false, function(v) RT.AutoSpec = v end)

    local s3 = CreateSection(P_Auto, "Equipment", 3)
    CreateToggle(s3, "✨ Auto Enchant", "Auto enchant accessories", 1, false, function(v) RT.AutoEnchant = v end)
    CreateToggle(s3, "🙏 Auto Blessing", "Auto bless weapons", 2, false, function(v) RT.AutoBlessing = v end)

    local s4 = CreateSection(P_Auto, "Artifact", 4)
    CreateToggle(s4, "⬆ Auto Upgrade Artifact", "Auto upgrade artifacts", 1, false, function(v) RT.ArtifactUpgrade = v end)
    CreateToggle(s4, "🔒 Auto Lock Artifact", "Auto lock good artifacts", 2, false, function(v) RT.ArtifactLock = v end)
    CreateToggle(s4, "🗑 Auto Delete Artifact", "Auto delete bad artifacts", 3, false, function(v) RT.ArtifactDelete = v end)
    CreateToggle(s4, "🏆 Artifact Milestone", "Auto claim artifact milestones", 4, false, function(v) RT.ArtifactMilestone = v end)

    local s5 = CreateSection(P_Auto, "Dungeon & Content", 5)
    CreateToggle(s5, "🚪 Auto Join Dungeon", "Auto join dungeon portal", 1, false, function(v) RT.AutoDungeon = v end)
    CreateToggle(s5, "🗼 Auto Infinite Tower", "Farm infinite tower", 2, false, function(v) RT.AutoInfiniteTower = v end)
    CreateToggle(s5, "📜 Auto Questline [BETA]", "Auto complete questlines", 3, false, function(v) RT.AutoQuestline = v end)

    local s6 = CreateSection(P_Auto, "Quests (Unlock)", 6)
    CreateToggle(s6, "🧩 Dungeon Pieces Quest", "Collect 6 dungeon puzzle pieces", 1, false, function(v) RT.DungeonQuest = v end)
    CreateToggle(s6, "💎 Hogyoku Fragments Quest", "Collect fragments → unlock Soul Society", 2, false, function(v) RT.HogyokuQuest = v end)
    CreateLabel(s6, "🌿 Dungeon: Starter→Jungle→Desert→Snow→Shibuya→Hueco Mundo\n🌿 Hogyoku: Snow→Shibuya→HuecoMundo→Slime→Judgement", 3)
end

-- ─────────────────────────────────────────────────────────────────
--  TAB: PLAYER
-- ─────────────────────────────────────────────────────────────────
do
    local s1 = CreateSection(P_Player, "Server & Connection", 1)
    CreateToggle(s1, "💤 Anti AFK", "Prevent AFK kick", 1, true, function(v) RT.AntiAFK = v end)
    CreateToggle(s1, "🔄 Auto Reconnect", "Auto rejoin on disconnect", 2, false, function(v) RT.AutoReconnect = v end)
    CreateToggle(s1, "🚫 Anti Kick", "Client-side anti kick", 3, false)

    local s2 = CreateSection(P_Player, "Safety", 2)
    CreateToggle(s2, "🛡 Auto Kick (Safety)", "Kick if mod/player joins", 1, false, function(v) RT.AutoKick = v end)

    local s3 = CreateSection(P_Player, "Performance", 3)
    CreateToggle(s3, "⚡ FPS Boost", "Remove shadows & particles", 1, false, function(v) RT.FPSBoost = v end)
    CreateToggle(s3, "🚶 Noclip", "Walk through walls", 2, false, function(v) RT.Noclip = v end)
    CreateToggle(s3, "🛡 Anti Knockback", "Prevent getting knocked back", 3, false, function(v) RT.AntiKnockback = v end)

    local s4 = CreateSection(P_Player, "Teleport", 4)
    CreateLabel(s4, "🌿 Island teleport is available in-game after loading.", 1)
    CreateButton(s4, "🗺 Open Island Teleport", "Teleport to any island", 2, function()
        SetStatus("Teleport panel opened in-game", false)
    end)

    local s5 = CreateSection(P_Player, "Webhook", 5)
    CreateToggle(s5, "📨 Send Webhook", "Send stats/items to Discord", 1, false, function(v) RT.SendWebhook = v end)
    CreateLabel(s5, "⚠ Configure Webhook URL in-game after loading script", 2)
end

-- ─────────────────────────────────────────────────────────────────
--  TAB: MISC
-- ─────────────────────────────────────────────────────────────────
do
    local s1 = CreateSection(P_Misc, "Merchant", 1)
    CreateToggle(s1, "🛒 Auto Merchant", "Auto buy items from merchant", 1, false, function(v) RT.AutoMerchant = v end)
    CreateLabel(s1, "🌿 Supports: Regular, Dungeon, Valentine, Tower, Boss Rush merchants", 2)

    local s2 = CreateSection(P_Misc, "Items", 2)
    CreateToggle(s2, "📦 Auto Open Chests", "Open all chests automatically", 1, false, function(v) RT.AutoChest = v end)
    CreateToggle(s2, "⚒ Auto Craft Item", "Auto craft Divine Grail & Slime Key", 2, false, function(v) RT.AutoCraftItem = v end)

    local s3 = CreateSection(P_Misc, "Puzzles", 3)
    CreateButton(s3, "🗝 Complete Dungeon Puzzle", "Collect all 6 pieces", 1, function()
        SetStatus("Running Dungeon Puzzle solver...", false)
    end)
    CreateButton(s3, "🟢 Complete Slime Key Puzzle", "Collect all pieces", 2, function()
        SetStatus("Running Slime Key solver...", false)
    end)
    CreateButton(s3, "💝 Complete Valentine Puzzle", "Collect hearts", 3, function()
        SetStatus("Running Valentine solver...", false)
    end)
    CreateButton(s3, "🌑 Complete Demonite Puzzle", "Collect all pieces", 4, function()
        SetStatus("Running Demonite solver...", false)
    end)
    CreateButton(s3, "💎 Complete Hogyoku Puzzle", "Collect all fragments", 5, function()
        SetStatus("Running Hogyoku solver...", false)
    end)

    local s4 = CreateSection(P_Misc, "Priority Order", 4)
    CreateLabel(s4, "🌿 Current priority: Boss > Pity Boss > Summon > Level Farm > Mob > Merchant\n⚠ Edit in-game Priority tab for custom ordering.", 1)
end

-- ─────────────────────────────────────────────────────────────────
--  TAB: CONFIG
-- ─────────────────────────────────────────────────────────────────
do
    local s1 = CreateSection(P_Config, "Script Info", 1)
    CreateLabel(s1, "🌿 Centella asiatica — by VanTuanDEV", 1, true)
    CreateLabel(s1, "📜 Script: celina (will.txt) + Hogyoku/Dungeon Quest from PIMPLE", 2)
    CreateLabel(s1, "🎮 Game: Sailor Piece", 3)
    CreateLabel(s1, "⌨ Press U to toggle UI | Press P for panic stop", 4)
    CreateDivider(s1, 5)
    CreateLabel(s1, "⚠ Supported executors: Synapse X, KRNL, Fluxus, Hydrogen, Xeno (limited)", 6)

    local s2 = CreateSection(P_Config, "Load Script", 2)
    CreateLabel(s2, "🌿 Click the button below to inject the script into the game.", 1)

    local LoadBtn = Instance.new("TextButton")
    LoadBtn.Size = UDim2.new(1, 0, 0, 48)
    LoadBtn.BackgroundColor3 = Color3.fromRGB(22, 50, 22)
    LoadBtn.BorderSizePixel = 0
    LoadBtn.Text = ""
    LoadBtn.ZIndex = 7
    LoadBtn.LayoutOrder = 2
    LoadBtn.Parent = s2
    Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 8)
    Stroke(LoadBtn, Color3.fromRGB(70, 155, 70), 1.5)

    local LoadGrad = Instance.new("UIGradient")
    LoadGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 58, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 42, 18)),
    })
    LoadGrad.Rotation = 90
    LoadGrad.Parent = LoadBtn

    local LoadIcon = Instance.new("TextLabel")
    LoadIcon.Size = UDim2.new(0, 30, 1, 0)
    LoadIcon.Position = UDim2.new(0, 14, 0, 0)
    LoadIcon.BackgroundTransparency = 1
    LoadIcon.Text = "🌿"
    LoadIcon.TextSize = 22
    LoadIcon.Font = Enum.Font.GothamBold
    LoadIcon.ZIndex = 8
    LoadIcon.Parent = LoadBtn

    local LoadLbl = Instance.new("TextLabel")
    LoadLbl.Size = UDim2.new(1, -50, 1, 0)
    LoadLbl.Position = UDim2.new(0, 44, 0, 0)
    LoadLbl.BackgroundTransparency = 1
    LoadLbl.Text = "INJECT SCRIPT"
    LoadLbl.TextColor3 = Color3.fromRGB(130, 220, 130)
    LoadLbl.TextSize = 14
    LoadLbl.Font = Enum.Font.GothamBold
    LoadLbl.TextXAlignment = Enum.TextXAlignment.Left
    LoadLbl.ZIndex = 8
    LoadLbl.Parent = LoadBtn

    LoadBtn.MouseEnter:Connect(function()
        Tween(LoadBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28, 62, 28)}):Play()
    end)
    LoadBtn.MouseLeave:Connect(function()
        Tween(LoadBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 50, 22)}):Play()
    end)

    local isLoaded = false
    LoadBtn.MouseButton1Click:Connect(function()
        if isLoaded then
            SetStatus("Script already loaded!", false)
            return
        end
        isLoaded = true
        LoadLbl.Text = "LOADING..."
        LoadLbl.TextColor3 = Color3.fromRGB(200, 200, 100)
        SetStatus("🌿 Injecting Centella asiatica script...", false)

        task.spawn(function()
            -- Animate loading dots
            for i = 1, 6 do
                task.wait(0.3)
                local dots = string.rep(".", (i % 4))
                LoadLbl.Text = "LOADING" .. dots
            end

            local ok, err = pcall(function()
                -- Apply RT flags to main script toggles (Toggles table)
                -- The main script uses Library.Toggles — set flags before load
                if getgenv then
                    getgenv().CENTELLA_PRESET = RT
                end
                -- Load celina script
                loadstring(game:HttpGet(
                    "https://raw.githubusercontent.com/VanTuanDev-pennywort/Vtuannpennywort/refs/heads/main/CentellaLoader.lua",
                    true
                ))()
            end)

            if ok then
                LoadLbl.Text = "✓ LOADED!"
                LoadLbl.TextColor3 = Color3.fromRGB(130, 220, 130)
                SetStatus("🌿 Script loaded successfully!", false)

                -- Hide loader after 2s
                task.delay(2, function()
                    Tween(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                        Position = UDim2.new(0.5, 0, -0.8, 0)
                    }):Play()
                    task.wait(0.6)
                    Tween(Overlay, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    Tween(Grain, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
                    task.wait(0.4)
                    ScreenGui:Destroy()
                    if getgenv then getgenv().CENTELLA_RUNNING = nil end
                end)
            else
                isLoaded = false
                LoadLbl.Text = "⚠ FAILED — RETRY"
                LoadLbl.TextColor3 = Color3.fromRGB(220, 80, 80)
                SetStatus("Failed to load: " .. tostring(err):sub(1, 60), true)
            end
        end)
    end)

    local s3 = CreateSection(P_Config, "Keybinds", 3)
    CreateLabel(s3, "U  →  Toggle Menu\nP  →  Panic Stop (disable all)\nV  →  Toggle Farm\nB  →  Toggle Boss\nN  →  Toggle Summon Boss", 1)
end

-- ─────────────────────────────────────────────────────────────────
--  ACTIVATE FIRST TAB
-- ─────────────────────────────────────────────────────────────────
task.wait(0.05)
if #Tabs > 0 then
    Tabs[1].Btn.MouseButton1Click:Fire()
end

-- ─────────────────────────────────────────────────────────────────
--  DRAG FUNCTIONALITY
-- ─────────────────────────────────────────────────────────────────
do
    local dragging, dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- ─────────────────────────────────────────────────────────────────
--  MINIMIZE / CLOSE
-- ─────────────────────────────────────────────────────────────────
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Tween(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 520, 0, 110)
        }):Play()
        MinBtn.Text = "□"
    else
        Tween(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 520, 0, 580)
        }):Play()
        MinBtn.Text = "─"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    Tween(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    task.delay(0.35, function()
        Tween(Overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        Tween(Grain, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
        task.wait(0.3)
        ScreenGui:Destroy()
        if getgenv then getgenv().CENTELLA_RUNNING = nil end
    end)
end)

-- ─────────────────────────────────────────────────────────────────
--  KEYBIND: U = Toggle
-- ─────────────────────────────────────────────────────────────────
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.U then
        guiVisible = not guiVisible
        if guiVisible then
            Main.Visible = true
            Tween(Main, TweenInfo.new(0.25), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
        else
            Tween(Main, TweenInfo.new(0.2), {
                Position = UDim2.new(0.5, 0, 1.2, 0)
            }):Play()
            task.delay(0.22, function() Main.Visible = false end)
        end
    end
end)

-- ─────────────────────────────────────────────────────────────────
--  STATUS TIME TICKER
-- ─────────────────────────────────────────────────────────────────
local startTick = tick()
task.spawn(function()
    while ScreenGui.Parent do
        local elapsed = tick() - startTick
        local m = math.floor(elapsed / 60)
        local s = math.floor(elapsed % 60)
        StatusTime.Text = string.format("%02d:%02d", m, s)
        task.wait(1)
    end
end)

-- ─────────────────────────────────────────────────────────────────
--  ENTRANCE ANIMATION
-- ─────────────────────────────────────────────────────────────────
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Overlay.BackgroundTransparency = 1
Grain.ImageTransparency = 1

Tween(Overlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.45}):Play()
Tween(Grain, TweenInfo.new(0.4), {ImageTransparency = 0.92}):Play()
task.wait(0.15)
Tween(Main, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 520, 0, 580)
}):Play()

-- Done
SetStatus("🌿 Centella asiatica ready — go to Config to inject", false)
