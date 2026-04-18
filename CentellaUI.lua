-- ╔══════════════════════════════════════════════════════════════════╗
-- ║  🌿 Centella asiatica UI  —  by VanTuanDEV                      ║
-- ║  Mobile-First | Sidebar Layout | Sailor Piece                    ║
-- ╚══════════════════════════════════════════════════════════════════╝
-- loadstring(game:HttpGet("RAW_LINK_CentellaUI"))()

if getgenv and getgenv().CENTELLA_UI_RUNNING then
    warn("[Centella UI] Already running!")
    return
end
if getgenv then getgenv().CENTELLA_UI_RUNNING = true end

repeat task.wait() until game:IsLoaded()

local Players    = game:GetService("Players")
local TweenSvc   = game:GetService("TweenService")
local UIS        = game:GetService("UserInputService")
local LP         = Players.LocalPlayer
local PGui       = LP:WaitForChild("PlayerGui")

-- ─── CONFIG ────────────────────────────────────────────────────────
local MAIN_URL = "https://raw.githubusercontent.com/VanTuanDev-pennywort/Vtuannpennywort/refs/heads/main/main.lua"
local ACCENT   = Color3.fromRGB(72, 160, 72)
local ACCENT_DIM = Color3.fromRGB(40, 90, 40)
local BG_DARK  = Color3.fromRGB(10, 10, 10)
local BG_MID   = Color3.fromRGB(16, 16, 16)
local BG_ITEM  = Color3.fromRGB(20, 20, 20)
local BG_ITEM2 = Color3.fromRGB(24, 24, 24)
local TXT_MAIN = Color3.fromRGB(220, 220, 220)
local TXT_DIM  = Color3.fromRGB(80, 80, 80)
local TXT_GREEN= Color3.fromRGB(100, 200, 100)
local BORDER   = Color3.fromRGB(35, 35, 35)

-- Screen size
local VP = workspace.CurrentCamera.ViewportSize
local SW, SH = VP.X, VP.Y
-- Mobile 6.5" ≈ 390×844 logical. Menu: 340 wide, full height
local MENU_W = math.min(340, SW - 10)
local MENU_H = math.min(580, SH - 60)
local SIDEBAR_W = 56
local CONTENT_W = MENU_W - SIDEBAR_W

-- ─── HELPERS ───────────────────────────────────────────────────────
local function Tw(obj, t, props)
    return TweenSvc:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quad), props)
end
local function Corner(p, r) local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, r or 8) c.Parent = p return c end
local function Stroke(p, col, thick) local s = Instance.new("UIStroke") s.Color = col or ACCENT s.Thickness = thick or 1.2 s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border s.Parent = p return s end
local function Pad(p, l, r, t, b) local pd = Instance.new("UIPadding") pd.PaddingLeft=UDim.new(0,l or 0) pd.PaddingRight=UDim.new(0,r or 0) pd.PaddingTop=UDim.new(0,t or 0) pd.PaddingBottom=UDim.new(0,b or 0) pd.Parent=p return pd end
local function List(p, dir, pad) local l = Instance.new("UIListLayout") l.SortOrder=Enum.SortOrder.LayoutOrder l.FillDirection=dir or Enum.FillDirection.Vertical l.Padding=UDim.new(0,pad or 0) l.Parent=p return l end

-- ─── DESTROY OLD ───────────────────────────────────────────────────
for _, v in pairs(PGui:GetChildren()) do
    if v.Name == "CentellaAsiaticaUI" then v:Destroy() end
end

-- ─── SCREEN GUI ────────────────────────────────────────────────────
local SG = Instance.new("ScreenGui")
SG.Name            = "CentellaAsiaticaUI"
SG.ResetOnSpawn    = false
SG.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
SG.DisplayOrder    = 999
SG.IgnoreGuiInset  = true
pcall(function() SG.Parent = game:GetService("CoreGui") end)
if not SG.Parent then SG.Parent = PGui end

-- ─── OPEN BUTTON (always visible) ──────────────────────────────────
local OpenBtn = Instance.new("ImageButton")
OpenBtn.Name             = "OpenBtn"
OpenBtn.Size             = UDim2.new(0, 46, 0, 46)
OpenBtn.Position         = UDim2.new(0, 8, 0.5, -23)
OpenBtn.BackgroundColor3 = BG_DARK
OpenBtn.BorderSizePixel  = 0
OpenBtn.ZIndex           = 5
OpenBtn.Image            = ""
OpenBtn.Parent           = SG
Corner(OpenBtn, 12)
Stroke(OpenBtn, ACCENT, 1.5)

local OBGrad = Instance.new("UIGradient")
OBGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18,40,18)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10,10,10)),
})
OBGrad.Rotation = 135
OBGrad.Parent = OpenBtn

local OBLabel = Instance.new("TextLabel")
OBLabel.Size                = UDim2.new(1,0,1,0)
OBLabel.BackgroundTransparency = 1
OBLabel.Text                = "🌿"
OBLabel.TextSize            = 22
OBLabel.Font                = Enum.Font.GothamBold
OBLabel.ZIndex              = 6
OBLabel.Parent              = OpenBtn

-- Drag open button
do
    local drag, ds, sp = false, nil, nil
    OpenBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true ds = inp.Position sp = OpenBtn.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = inp.Position - ds
            OpenBtn.Position = UDim2.new(sp.X.Scale, sp.X.Offset+delta.X, sp.Y.Scale, sp.Y.Offset+delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = false
        end
    end)
end

-- ─── MAIN PANEL ────────────────────────────────────────────────────
local Panel = Instance.new("Frame")
Panel.Name             = "Panel"
Panel.Size             = UDim2.new(0, MENU_W, 0, MENU_H)
Panel.Position         = UDim2.new(0, -MENU_W-10, 0.5, -MENU_H/2)
Panel.BackgroundColor3 = BG_DARK
Panel.BorderSizePixel  = 0
Panel.ZIndex           = 10
Panel.ClipsDescendants = true
Panel.Visible          = false
Panel.Parent           = SG
Corner(Panel, 12)
Stroke(Panel, ACCENT, 1.5)

-- Top accent line
local TopLine = Instance.new("Frame")
TopLine.Size             = UDim2.new(1,0,0,2)
TopLine.BackgroundColor3 = ACCENT
TopLine.BorderSizePixel  = 0
TopLine.ZIndex           = 11
TopLine.Parent           = Panel
local TLGrad = Instance.new("UIGradient")
TLGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,100,30)),ColorSequenceKeypoint.new(0.5,ACCENT),ColorSequenceKeypoint.new(1,Color3.fromRGB(30,100,30))})
TLGrad.Parent = TopLine

-- ─── HEADER ────────────────────────────────────────────────────────
local Header = Instance.new("Frame")
Header.Size             = UDim2.new(1,0,0,52)
Header.Position         = UDim2.new(0,0,0,2)
Header.BackgroundColor3 = BG_MID
Header.BorderSizePixel  = 0
Header.ZIndex           = 11
Header.Parent           = Panel

local HdrLine = Instance.new("Frame")
HdrLine.Size             = UDim2.new(1,0,0,1)
HdrLine.Position         = UDim2.new(0,0,1,-1)
HdrLine.BackgroundColor3 = BORDER
HdrLine.BorderSizePixel  = 0
HdrLine.ZIndex           = 12
HdrLine.Parent           = Header

-- Avatar frame
local AvatarF = Instance.new("Frame")
AvatarF.Size             = UDim2.new(0,36,0,36)
AvatarF.Position         = UDim2.new(0,10,0.5,-18)
AvatarF.BackgroundColor3 = BG_ITEM
AvatarF.BorderSizePixel  = 0
AvatarF.ZIndex           = 12
AvatarF.Parent           = Header
Corner(AvatarF, 8)
Stroke(AvatarF, ACCENT, 1.2)

local AvatarLbl = Instance.new("TextLabel")
AvatarLbl.Size                = UDim2.new(1,0,1,0)
AvatarLbl.BackgroundTransparency = 1
AvatarLbl.Text                = "🌿"
AvatarLbl.TextSize            = 18
AvatarLbl.Font                = Enum.Font.GothamBold
AvatarLbl.ZIndex              = 13
AvatarLbl.Parent              = AvatarF

-- Title block
local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size                = UDim2.new(1,-110,0,22)
TitleLbl.Position            = UDim2.new(0,52,0,8)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text                = "Centella asiatica"
TitleLbl.TextColor3          = TXT_MAIN
TitleLbl.TextSize            = 14
TitleLbl.Font                = Enum.Font.GothamBold
TitleLbl.TextXAlignment      = Enum.TextXAlignment.Left
TitleLbl.ZIndex              = 12
TitleLbl.Parent              = Header

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,TXT_GREEN)})
TitleGrad.Parent = TitleLbl

local SubLbl = Instance.new("TextLabel")
SubLbl.Size                = UDim2.new(1,-110,0,14)
SubLbl.Position            = UDim2.new(0,52,0,31)
SubLbl.BackgroundTransparency = 1
SubLbl.Text                = "by VanTuanDEV • Sailor Piece"
SubLbl.TextColor3          = TXT_DIM
SubLbl.TextSize            = 10
SubLbl.Font                = Enum.Font.Gotham
SubLbl.TextXAlignment      = Enum.TextXAlignment.Left
SubLbl.ZIndex              = 12
SubLbl.Parent              = Header

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size             = UDim2.new(0,28,0,28)
CloseBtn.Position         = UDim2.new(1,-36,0.5,-14)
CloseBtn.BackgroundColor3 = BG_ITEM
CloseBtn.BorderSizePixel  = 0
CloseBtn.Text             = "✕"
CloseBtn.TextColor3       = TXT_DIM
CloseBtn.TextSize         = 12
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.ZIndex           = 13
CloseBtn.Parent           = Header
Corner(CloseBtn, 6)
Stroke(CloseBtn, BORDER, 1)

-- ─── BODY (sidebar + content) ──────────────────────────────────────
local Body = Instance.new("Frame")
Body.Size             = UDim2.new(1,0,1,-54)
Body.Position         = UDim2.new(0,0,0,54)
Body.BackgroundTransparency = 1
Body.ZIndex           = 11
Body.Parent           = Panel

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Name             = "Sidebar"
Sidebar.Size             = UDim2.new(0,SIDEBAR_W,1,0)
Sidebar.BackgroundColor3 = BG_MID
Sidebar.BorderSizePixel  = 0
Sidebar.ZIndex           = 12
Sidebar.Parent           = Body

local SBLine = Instance.new("Frame")
SBLine.Size             = UDim2.new(0,1,1,0)
SBLine.Position         = UDim2.new(1,-1,0,0)
SBLine.BackgroundColor3 = BORDER
SBLine.BorderSizePixel  = 0
SBLine.ZIndex           = 13
SBLine.Parent           = Sidebar

local SideList = Instance.new("UIListLayout")
SideList.SortOrder        = Enum.SortOrder.LayoutOrder
SideList.FillDirection    = Enum.FillDirection.Vertical
SideList.Padding          = UDim.new(0,2)
SideList.Parent           = Sidebar
local SidePad = Instance.new("UIPadding")
SidePad.PaddingTop        = UDim.new(0,6)
SidePad.PaddingLeft       = UDim.new(0,4)
SidePad.PaddingRight      = UDim.new(0,4)
SidePad.Parent            = Sidebar

-- CONTENT AREA
local ContentArea = Instance.new("Frame")
ContentArea.Name             = "Content"
ContentArea.Size             = UDim2.new(1,-SIDEBAR_W,1,0)
ContentArea.Position         = UDim2.new(0,SIDEBAR_W,0,0)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex           = 12
ContentArea.ClipsDescendants = true
ContentArea.Parent           = Body

-- Status bar at bottom
local StatusBar = Instance.new("Frame")
StatusBar.Size             = UDim2.new(1,0,0,22)
StatusBar.Position         = UDim2.new(0,0,1,-22)
StatusBar.BackgroundColor3 = Color3.fromRGB(8,8,8)
StatusBar.BorderSizePixel  = 0
StatusBar.ZIndex           = 15
StatusBar.Parent           = Panel

local SDot = Instance.new("Frame")
SDot.Size             = UDim2.new(0,6,0,6)
SDot.Position         = UDim2.new(0,8,0.5,-3)
SDot.BackgroundColor3 = ACCENT
SDot.BorderSizePixel  = 0
SDot.ZIndex           = 16
SDot.Parent           = StatusBar
Corner(SDot,3)

local STxt = Instance.new("TextLabel")
STxt.Size             = UDim2.new(1,-20,1,0)
STxt.Position         = UDim2.new(0,18,0,0)
STxt.BackgroundTransparency = 1
STxt.Text             = "Ready"
STxt.TextColor3       = TXT_DIM
STxt.TextSize         = 10
STxt.Font             = Enum.Font.Gotham
STxt.TextXAlignment   = Enum.TextXAlignment.Left
STxt.ZIndex           = 16
STxt.Parent           = StatusBar

local function SetStatus(txt, isErr)
    STxt.Text = txt
    SDot.BackgroundColor3 = isErr and Color3.fromRGB(200,60,60) or ACCENT
end

-- ─── NOTIFY SYSTEM ─────────────────────────────────────────────────
local NotifHolder = Instance.new("Frame")
NotifHolder.Name             = "NotifHolder"
NotifHolder.Size             = UDim2.new(0,240,0,0)
NotifHolder.AnchorPoint      = Vector2.new(0.5,1)
NotifHolder.Position         = UDim2.new(0.5,0,1,-5)
NotifHolder.BackgroundTransparency = 1
NotifHolder.ZIndex           = 50
NotifHolder.AutomaticSize    = Enum.AutomaticSize.Y
NotifHolder.Parent           = SG
List(NotifHolder, Enum.FillDirection.Vertical, 4)

local function Notify(msg, dur)
    dur = dur or 3
    local nf = Instance.new("Frame")
    nf.Size             = UDim2.new(1,0,0,0)
    nf.AutomaticSize    = Enum.AutomaticSize.Y
    nf.BackgroundColor3 = BG_MID
    nf.BorderSizePixel  = 0
    nf.ZIndex           = 51
    nf.LayoutOrder      = -tick()
    nf.Parent           = NotifHolder
    Corner(nf,8) Stroke(nf,ACCENT,1.2)
    Pad(nf,10,10,6,6)
    local nl = Instance.new("TextLabel")
    nl.Size             = UDim2.new(1,0,0,0)
    nl.AutomaticSize    = Enum.AutomaticSize.Y
    nl.BackgroundTransparency = 1
    nl.Text             = msg
    nl.TextColor3       = TXT_MAIN
    nl.TextSize         = 11
    nl.Font             = Enum.Font.Gotham
    nl.TextWrapped      = true
    nl.TextXAlignment   = Enum.TextXAlignment.Left
    nl.ZIndex           = 52
    nl.Parent           = nf
    nf.BackgroundTransparency = 1
    Tw(nf,0.2,{BackgroundTransparency=0}):Play()
    task.delay(dur, function()
        Tw(nf,0.3,{BackgroundTransparency=1}):Play()
        task.delay(0.35, function() pcall(function() nf:Destroy() end) end)
    end)
end

_G.CENTELLA_NOTIFY = Notify

-- ─── TAB SYSTEM ────────────────────────────────────────────────────
local Tabs = {}
local Pages = {}
local CurrentTab = nil

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name                  = "Page_"..name
    page.Size                  = UDim2.new(1,0,1,-24)
    page.BackgroundTransparency = 1
    page.BorderSizePixel       = 0
    page.ScrollBarThickness    = 3
    page.ScrollBarImageColor3  = ACCENT
    page.CanvasSize            = UDim2.new(0,0,0,0)
    page.AutomaticCanvasSize   = Enum.AutomaticSize.Y
    page.Visible               = false
    page.ZIndex                = 13
    page.Parent                = ContentArea
    Pad(page,8,8,6,26)
    List(page, Enum.FillDirection.Vertical, 6)
    Pages[name] = page
    return page
end

local function CreateSideTab(icon, label, order, pageName)
    local Btn = Instance.new("TextButton")
    Btn.Name              = "STab_"..label
    Btn.Size              = UDim2.new(1,0,0,48)
    Btn.BackgroundColor3  = BG_MID
    Btn.BorderSizePixel   = 0
    Btn.Text              = ""
    Btn.ZIndex            = 13
    Btn.LayoutOrder       = order
    Btn.Parent            = Sidebar
    Corner(Btn, 8)

    local IcoLbl = Instance.new("TextLabel")
    IcoLbl.Size             = UDim2.new(1,0,0,24)
    IcoLbl.Position         = UDim2.new(0,0,0,6)
    IcoLbl.BackgroundTransparency = 1
    IcoLbl.Text             = icon
    IcoLbl.TextSize         = 18
    IcoLbl.Font             = Enum.Font.GothamBold
    IcoLbl.ZIndex           = 14
    IcoLbl.Parent           = Btn

    local NameLbl = Instance.new("TextLabel")
    NameLbl.Size            = UDim2.new(1,0,0,12)
    NameLbl.Position        = UDim2.new(0,0,0,28)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Text            = label
    NameLbl.TextColor3      = TXT_DIM
    NameLbl.TextSize        = 8
    NameLbl.Font            = Enum.Font.GothamBold
    NameLbl.ZIndex          = 14
    NameLbl.Parent          = Btn

    local ActiveBar = Instance.new("Frame")
    ActiveBar.Size          = UDim2.new(0,3,0,0)
    ActiveBar.Position      = UDim2.new(1,-3,0.5,0)
    ActiveBar.AnchorPoint   = Vector2.new(0,0.5)
    ActiveBar.BackgroundColor3 = ACCENT
    ActiveBar.BorderSizePixel = 0
    ActiveBar.ZIndex        = 14
    ActiveBar.Parent        = Btn
    Corner(ActiveBar,2)

    local tabData = {Btn=Btn, IcoLbl=IcoLbl, NameLbl=NameLbl, ActiveBar=ActiveBar, Page=nil}
    table.insert(Tabs, tabData)

    Btn.MouseButton1Click:Connect(function()
        -- deactivate all
        for _, t in ipairs(Tabs) do
            Tw(t.Btn, 0.15, {BackgroundColor3=BG_MID}):Play()
            t.NameLbl.TextColor3 = TXT_DIM
            Tw(t.ActiveBar, 0.15, {Size=UDim2.new(0,3,0,0)}):Play()
            if t.Page then t.Page.Visible = false end
        end
        -- activate this
        Tw(Btn, 0.15, {BackgroundColor3=ACCENT_DIM}):Play()
        NameLbl.TextColor3 = TXT_GREEN
        Tw(ActiveBar, 0.15, {Size=UDim2.new(0,3,0,28)}):Play()
        if Pages[pageName] then Pages[pageName].Visible = true end
        CurrentTab = pageName
    end)

    return tabData
end

-- ─── UI ELEMENT BUILDERS ───────────────────────────────────────────

-- Section header
local function Section(page, title, order)
    local sec = Instance.new("Frame")
    sec.Size             = UDim2.new(1,0,0,0)
    sec.AutomaticSize    = Enum.AutomaticSize.Y
    sec.BackgroundColor3 = BG_ITEM
    sec.BorderSizePixel  = 0
    sec.ZIndex           = 14
    sec.LayoutOrder      = order or 0
    sec.Parent           = page
    Corner(sec, 8)
    Stroke(sec, BORDER, 1)
    Pad(sec, 8, 8, 4, 6)
    local sl = List(sec, Enum.FillDirection.Vertical, 3)

    -- title row
    local tr = Instance.new("Frame")
    tr.Size             = UDim2.new(1,0,0,20)
    tr.BackgroundTransparency = 1
    tr.ZIndex           = 15
    tr.LayoutOrder      = 0
    tr.Parent           = sec

    local accent = Instance.new("Frame")
    accent.Size         = UDim2.new(0,2,0,12)
    accent.Position     = UDim2.new(0,0,0.5,-6)
    accent.BackgroundColor3 = ACCENT
    accent.BorderSizePixel = 0
    accent.ZIndex       = 16
    accent.Parent       = tr
    Corner(accent,2)

    local tl = Instance.new("TextLabel")
    tl.Size             = UDim2.new(1,-10,1,0)
    tl.Position         = UDim2.new(0,8,0,0)
    tl.BackgroundTransparency = 1
    tl.Text             = title:upper()
    tl.TextColor3       = TXT_GREEN
    tl.TextSize         = 9
    tl.Font             = Enum.Font.GothamBold
    tl.TextXAlignment   = Enum.TextXAlignment.Left
    tl.ZIndex           = 16
    tl.Parent           = tr

    local items = Instance.new("Frame")
    items.Name          = "Items"
    items.Size          = UDim2.new(1,0,0,0)
    items.AutomaticSize = Enum.AutomaticSize.Y
    items.BackgroundTransparency = 1
    items.ZIndex        = 15
    items.LayoutOrder   = 1
    items.Parent        = sec
    List(items, Enum.FillDirection.Vertical, 3)

    return items
end

-- Toggle row
local function Toggle(parent, label, desc, order, default, tglKey)
    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1,0,0, desc and 44 or 36)
    row.BackgroundColor3 = BG_ITEM2
    row.BorderSizePixel  = 0
    row.ZIndex           = 16
    row.LayoutOrder      = order or 0
    row.Parent           = parent
    Corner(row, 6)
    Stroke(row, BORDER, 1)

    local lbl = Instance.new("TextLabel")
    lbl.Size             = UDim2.new(1,-54,0,18)
    lbl.Position         = UDim2.new(0,8,0, desc and 5 or 9)
    lbl.BackgroundTransparency = 1
    lbl.Text             = label
    lbl.TextColor3       = TXT_MAIN
    lbl.TextSize         = 12
    lbl.Font             = Enum.Font.GothamBold
    lbl.TextXAlignment   = Enum.TextXAlignment.Left
    lbl.ZIndex           = 17
    lbl.Parent           = row

    if desc then
        local dl = Instance.new("TextLabel")
        dl.Size             = UDim2.new(1,-54,0,14)
        dl.Position         = UDim2.new(0,8,0,22)
        dl.BackgroundTransparency = 1
        dl.Text             = desc
        dl.TextColor3       = TXT_DIM
        dl.TextSize         = 9
        dl.Font             = Enum.Font.Gotham
        dl.TextXAlignment   = Enum.TextXAlignment.Left
        dl.ZIndex           = 17
        dl.Parent           = row
    end

    -- Switch track
    local track = Instance.new("Frame")
    track.Size           = UDim2.new(0,38,0,20)
    track.Position       = UDim2.new(1,-46,0.5,-10)
    track.BackgroundColor3 = Color3.fromRGB(35,35,35)
    track.BorderSizePixel = 0
    track.ZIndex         = 17
    track.Parent         = row
    Corner(track,10)

    local knob = Instance.new("Frame")
    knob.Size            = UDim2.new(0,14,0,14)
    knob.Position        = UDim2.new(0,3,0.5,-7)
    knob.BackgroundColor3 = Color3.fromRGB(80,80,80)
    knob.BorderSizePixel = 0
    knob.ZIndex          = 18
    knob.Parent          = track
    Corner(knob,7)

    local val = default or false

    local function SetVal(v, skipExt)
        val = v
        if v then
            Tw(track,0.18,{BackgroundColor3=ACCENT_DIM}):Play()
            Tw(knob,0.18,{Position=UDim2.new(0,21,0.5,-7), BackgroundColor3=TXT_GREEN}):Play()
        else
            Tw(track,0.18,{BackgroundColor3=Color3.fromRGB(35,35,35)}):Play()
            Tw(knob,0.18,{Position=UDim2.new(0,3,0.5,-7), BackgroundColor3=Color3.fromRGB(80,80,80)}):Play()
        end
        if not skipExt and tglKey and getgenv().CENTELLA_TOGGLES then
            local T = getgenv().CENTELLA_TOGGLES
            if T[tglKey] then T[tglKey]:SetValue(v) end
        end
    end

    SetVal(val, true)

    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1
    btn.Text             = ""
    btn.ZIndex           = 19
    btn.Parent           = row
    btn.MouseButton1Click:Connect(function() SetVal(not val) end)

    -- Sync back if main script changes toggle
    task.spawn(function()
        while SG.Parent do
            task.wait(0.5)
            if tglKey and getgenv().CENTELLA_TOGGLES then
                local T = getgenv().CENTELLA_TOGGLES
                if T[tglKey] and T[tglKey].Value ~= val then
                    SetVal(T[tglKey].Value, true)
                end
            end
        end
    end)

    return {SetValue = SetVal, GetValue = function() return val end}
end

-- Button row
local function Button(parent, label, order, cb)
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(1,0,0,36)
    btn.BackgroundColor3 = BG_ITEM2
    btn.BorderSizePixel  = 0
    btn.Text             = ""
    btn.ZIndex           = 16
    btn.LayoutOrder      = order or 0
    btn.Parent           = parent
    Corner(btn,6)
    Stroke(btn,BORDER,1)

    local lbl = Instance.new("TextLabel")
    lbl.Size             = UDim2.new(1,-30,1,0)
    lbl.Position         = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text             = label
    lbl.TextColor3       = TXT_MAIN
    lbl.TextSize         = 12
    lbl.Font             = Enum.Font.GothamBold
    lbl.TextXAlignment   = Enum.TextXAlignment.Left
    lbl.ZIndex           = 17
    lbl.Parent           = btn

    local arr = Instance.new("TextLabel")
    arr.Size             = UDim2.new(0,20,1,0)
    arr.Position         = UDim2.new(1,-24,0,0)
    arr.BackgroundTransparency = 1
    arr.Text             = "›"
    arr.TextColor3       = TXT_GREEN
    arr.TextSize         = 18
    arr.Font             = Enum.Font.GothamBold
    arr.ZIndex           = 17
    arr.Parent           = btn

    btn.MouseButton1Click:Connect(function()
        Tw(btn,0.06,{BackgroundColor3=BG_MID}):Play()
        task.delay(0.1,function() Tw(btn,0.1,{BackgroundColor3=BG_ITEM2}):Play() end)
        if cb then pcall(cb) end
    end)
    return btn
end

-- Info label
local function Label(parent, text, order, green)
    local l = Instance.new("TextLabel")
    l.Size               = UDim2.new(1,0,0,0)
    l.AutomaticSize      = Enum.AutomaticSize.Y
    l.BackgroundTransparency = 1
    l.Text               = text
    l.TextColor3         = green and TXT_GREEN or TXT_DIM
    l.TextSize           = 10
    l.Font               = Enum.Font.Gotham
    l.TextXAlignment     = Enum.TextXAlignment.Left
    l.TextWrapped        = true
    l.ZIndex             = 16
    l.LayoutOrder        = order or 0
    l.Parent             = parent
    return l
end

-- ─── CREATE TABS & PAGES ───────────────────────────────────────────
local tabDefs = {
    {"⚔","Main",  1, "Main"},
    {"💀","Boss",  2, "Boss"},
    {"🔄","Auto",  3, "Auto"},
    {"🧑","Player",4, "Player"},
    {"🌿","Misc",  5, "Misc"},
    {"⚙","Config", 6, "Config"},
}
for _, td in ipairs(tabDefs) do
    local tData = CreateSideTab(td[1], td[2], td[3], td[4])
    local pg = CreatePage(td[4])
    tData.Page = pg
end

-- ─── TAB: MAIN ─────────────────────────────────────────────────────
do
    local p = Pages.Main
    local s1 = Section(p,"Auto Farm",1)
    Toggle(s1,"🗡 Farm Mob","Farm mob đã chọn",1,false,"MobFarm")
    Toggle(s1,"🌀 Farm All Mobs","Xoay vòng tất cả mob",2,false,"AllMobFarm")
    Toggle(s1,"📈 Farm Level","Farm quest theo level",3,false,"LevelFarm")

    local s2 = Section(p,"Combat & Skills",2)
    Toggle(s2,"👊 Auto M1","Spam M1 tự động",1,false,"AutoM1")
    Toggle(s2,"💥 Auto Skill","Dùng skill Z/X/C/V/F",2,false,"AutoSkill")
    Toggle(s2,"🌀 Auto Combo","Chạy combo skill tự động",3,false,"AutoCombo")
    Toggle(s2,"⚡ Kill Aura","Tấn công mob gần nhất",4,false,"KillAura")
    Toggle(s2,"☠ Instant Kill","Kill tức thì khi đủ HP%",5,false,"InstaKill")
    Toggle(s2,"🔄 Auto Switch Weapon","Xoay vũ khí khi farm",6,true,"SwitchWeapon")

    local s3 = Section(p,"Haki",3)
    Toggle(s3,"👁 Observation Haki","Giữ obs haki",1,false,"ObserHaki")
    Toggle(s3,"💪 Armament Haki","Giữ arm haki",2,false,"ArmHaki")
    Toggle(s3,"👑 Conqueror Haki","Giữ conqueror haki",3,false,"ConquerorHaki")
end

-- ─── TAB: BOSS ─────────────────────────────────────────────────────
do
    local p = Pages.Boss
    local s1 = Section(p,"World Boss",1)
    Toggle(s1,"💀 Farm Boss","Farm boss đã chọn",1,false,"BossesFarm")
    Toggle(s1,"💀 Farm All Bosses","Farm mọi boss spawn",2,false,"AllBossesFarm")

    local s2 = Section(p,"Summon Boss",2)
    Toggle(s2,"🔮 Auto Summon","Tự summon boss đã chọn",1,false,"AutoSummon")
    Toggle(s2,"⚔ Farm Summon Boss","Farm summon boss",2,false,"SummonBossFarm")

    local s3 = Section(p,"Pity Boss",3)
    Toggle(s3,"📊 Pity Boss Farm","Build pity → dùng boss pity",1,false,"PityBossFarm")
    Label(s3,"⚠ Chọn boss build pity & use pity sau khi load script",2)

    local s4 = Section(p,"Other Summon",4)
    Toggle(s4,"🌟 Auto Other Summon","Summon Anos/Strongest...",1,false,"AutoOtherSummon")
    Toggle(s4,"⚔ Farm Other Summon","Farm boss other summon",2,false,"OtherSummonFarm")

    local s5 = Section(p,"Alt Help",5)
    Toggle(s5,"🤝 Auto Help Alt","Giúp alt farm boss",1,false,"AltBossFarm")
    Label(s5,"⚠ Cấu hình boss & alt trong script sau khi load",2)
end

-- ─── TAB: AUTO ─────────────────────────────────────────────────────
do
    local p = Pages.Auto
    local s1 = Section(p,"Stats & Progression",1)
    Toggle(s1,"📊 Auto Stats","Tự phân bổ stat points",1,false,"AutoStats")
    Toggle(s1,"🎲 Auto Roll Gem Stats","Reroll gem đến rank mục tiêu",2,false,"AutoRollStats")
    Toggle(s1,"⬆ Auto Ascend","Tự ascend khi đủ điều kiện",3,false,"AutoAscend")
    Toggle(s1,"🌳 Auto Skill Tree","Tự upgrade skill tree",4,false,"AutoSkillTree")

    local s2 = Section(p,"Rolls",2)
    Toggle(s2,"🃏 Auto Roll Trait","Roll đến trait mục tiêu",1,false,"AutoTrait")
    Toggle(s2,"🧬 Auto Roll Race","Roll đến race mục tiêu",2,false,"AutoRace")
    Toggle(s2,"🛡 Auto Roll Clan","Roll đến clan mục tiêu",3,false,"AutoClan")
    Toggle(s2,"🔮 Auto Reroll Passive","Reroll spec passive",4,false,"AutoSpec")

    local s3 = Section(p,"Equipment",3)
    Toggle(s3,"✨ Auto Enchant","Tự enchant accessory",1,false,"AutoEnchant")
    Toggle(s3,"✨ Auto Enchant All","Enchant toàn bộ",2,false,"AutoEnchantAll")
    Toggle(s3,"🙏 Auto Blessing","Tự bless vũ khí",3,false,"AutoBlessing")
    Toggle(s3,"🙏 Auto Blessing All","Bless toàn bộ",4,false,"AutoBlessingAll")

    local s4 = Section(p,"Artifact",4)
    Toggle(s4,"⬆ Auto Upgrade","Tự upgrade artifact",1,false,"ArtifactUpgrade")
    Toggle(s4,"🔒 Auto Lock","Tự lock artifact tốt",2,false,"ArtifactLock")
    Toggle(s4,"🗑 Auto Delete","Tự xóa artifact xấu",3,false,"ArtifactDelete")
    Toggle(s4,"🏅 Auto Equip","Tự equip artifact tốt nhất",4,false,"ArtifactEquip")
    Toggle(s4,"🏆 Artifact Milestone","Claim milestone artifact",5,false,"ArtifactMilestone")

    local s5 = Section(p,"Dungeon & Content",5)
    Toggle(s5,"🚪 Auto Join Dungeon","Tự vào dungeon",1,false,"AutoDungeon")
    Toggle(s5,"🗼 Auto Infinite Tower","Farm Infinite Tower",2,false,"AutoInfiniteTower")
    Toggle(s5,"📜 Auto Questline","Tự làm questline [BETA]",3,false,"AutoQuestline")

    local s6 = Section(p,"Unlock Quests ✨",6)
    Toggle(s6,"🧩 Dungeon Pieces Quest","Thu 6 mảnh dungeon",1,false,"DungeonQuest")
    Toggle(s6,"💎 Hogyoku Fragments","Thu mảnh → mở Soul Society",2,false,"HogyokuQuest")
    Label(s6,"🌿 Dungeon: Starter→Jungle→Desert→Snow→Shibuya→HuecoMundo\n🌿 Hogyoku: Snow→Shibuya→HuecoMundo→Shinjuku→Slime→Judgement",3,true)
end

-- ─── TAB: PLAYER ───────────────────────────────────────────────────
do
    local p = Pages.Player
    local s1 = Section(p,"Server & Connection",1)
    Toggle(s1,"💤 Anti AFK","Tránh bị kick AFK",1,true,"AntiAFK")
    Toggle(s1,"🔄 Auto Reconnect","Tự rejoin khi bị disconnect",2,false,"AutoReconnect")
    Toggle(s1,"🚫 Anti Kick","Chống kick client-side",3,false,"AntiKick")

    local s2 = Section(p,"Safety",2)
    Toggle(s2,"🛡 Auto Kick (Safety)","Kick nếu mod/player join",1,false,"AutoKick")
    Toggle(s2,"🔕 Auto Hide Notif","Ẩn thông báo không cần thiết",2,false,"AutoDeleteNotif")

    local s3 = Section(p,"Performance",3)
    Toggle(s3,"⚡ FPS Boost","Xóa shadow & particle",1,false,"FPSBoost")
    Toggle(s3,"⚡ FPS Boost [Farm]","Xóa island khi farm",2,false,"FPSBoost_AF")
    Toggle(s3,"🚶 Noclip","Đi xuyên tường",3,false,"Noclip")
    Toggle(s3,"🛡 Anti Knockback","Chống knockback",4,false,"AntiKnockback")
    Toggle(s3,"💡 Fullbright","Sáng toàn bộ map",5,false,"Fullbright")
    Toggle(s3,"🌫 No Fog","Xóa sương mù",6,false,"NoFog")

    local s4 = Section(p,"Actions",4)
    Button(s4,"⚠ Panic Stop (Dừng tất cả)",1,function()
        if getgenv().CENTELLA_TOGGLES then
            for _, tgl in pairs(getgenv().CENTELLA_TOGGLES) do
                pcall(function() tgl:SetValue(false) end)
            end
        end
        Notify("🌿 Panic Stop — Đã dừng tất cả!",3)
        SetStatus("PANIC STOP",true)
    end)
    Button(s4,"🔄 Rejoin Server",2,function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end)
end

-- ─── TAB: MISC ─────────────────────────────────────────────────────
do
    local p = Pages.Misc
    local s1 = Section(p,"Merchant",1)
    Toggle(s1,"🛒 Auto Merchant","Mua item từ merchant",1,false,"AutoMerchant")
    Label(s1,"🌿 Hỗ trợ: Regular, Dungeon, Valentine, Tower, Boss Rush",2,true)

    local s2 = Section(p,"Items",2)
    Toggle(s2,"📦 Auto Open Chests","Tự mở chest",1,false,"AutoChest")
    Toggle(s2,"⚒ Auto Craft","Tự craft Divine Grail & Slime Key",2,false,"AutoCraftItem")

    local s3 = Section(p,"Puzzle Solvers",3)
    Button(s3,"🗝 Complete Dungeon Puzzle",1,function()
        if getgenv().CENTELLA_TOGGLES then
            getgenv().CENTELLA_TOGGLES.DungeonQuest:SetValue(true)
        end
        Notify("🌿 Dungeon Puzzle đang chạy!",3)
    end)
    Button(s3,"🟢 Complete Slime Key Puzzle",2,function()
        Notify("🌿 Slime Puzzle: Dùng tab Auto → Dungeon Pieces Quest",3)
    end)
    Button(s3,"💝 Valentine Puzzle",3,function()
        local ok,err = pcall(function()
            local RS2 = game:GetService("ReplicatedStorage")
            local Char2 = LP.Character
            RS2.Remotes.TeleportToPortal:FireServer("Valentine")
            task.wait(2.5)
            for i = 1,3 do
                local item = workspace:FindFirstChild("Heart"..i)
                if item then
                    local pr = item:FindFirstChildOfClass("ProximityPrompt") or item:FindFirstChildWhichIsA("ProximityPrompt",true)
                    if pr and Char2 then
                        Char2.HumanoidRootPart.CFrame = item.CFrame * CFrame.new(0,3,0)
                        task.wait(0.2)
                        fireproximityprompt(pr)
                        task.wait(0.5)
                    end
                end
            end
        end)
        Notify(ok and "🌿 Valentine Puzzle xong!" or "🌿 Valentine: "..tostring(err), 3)
    end)
    Button(s3,"💎 Hogyoku Fragments Quest",4,function()
        if getgenv().CENTELLA_TOGGLES then
            getgenv().CENTELLA_TOGGLES.HogyokuQuest:SetValue(true)
        end
        Notify("🌿 Hogyoku Quest đang chạy!",3)
    end)
end

-- ─── TAB: CONFIG ───────────────────────────────────────────────────
do
    local p = Pages.Config
    local s1 = Section(p,"Script",1)
    Label(s1,"🌿 Centella asiatica — by VanTuanDEV",1,true)
    Label(s1,"📜 Logic: celina (will.txt) + SP Quests\n🎮 Game: Sailor Piece\n⚡ Mở menu: Nút 🌿 bên trái",2)

    local s2 = Section(p,"Load Main Script",2)
    Label(s2,"🌿 Bấm nút bên dưới để inject toàn bộ script vào game.",1,true)

    local loadBtn = Instance.new("TextButton")
    loadBtn.Size             = UDim2.new(1,0,0,44)
    loadBtn.BackgroundColor3 = ACCENT_DIM
    loadBtn.BorderSizePixel  = 0
    loadBtn.Text             = ""
    loadBtn.ZIndex           = 16
    loadBtn.LayoutOrder      = 2
    loadBtn.Parent           = s2
    Corner(loadBtn, 8)
    Stroke(loadBtn, ACCENT, 1.5)

    local loadLbl = Instance.new("TextLabel")
    loadLbl.Size             = UDim2.new(1,0,1,0)
    loadLbl.BackgroundTransparency = 1
    loadLbl.Text             = "🌿  INJECT SCRIPT"
    loadLbl.TextColor3       = TXT_GREEN
    loadLbl.TextSize         = 13
    loadLbl.Font             = Enum.Font.GothamBold
    loadLbl.ZIndex           = 17
    loadLbl.Parent           = loadBtn

    local loaded = false
    loadBtn.MouseButton1Click:Connect(function()
        if loaded then Notify("🌿 Script đã được load rồi!",2) return end
        loaded = true
        loadLbl.Text = "🌿  ĐANG LOAD..."
        loadLbl.TextColor3 = Color3.fromRGB(200,200,80)
        SetStatus("Đang inject script...",false)
        task.spawn(function()
            local ok, err = pcall(function()
                loadstring(game:HttpGet(MAIN_URL, true))()
            end)
            if ok then
                loadLbl.Text = "✓  ĐÃ LOAD!"
                loadLbl.TextColor3 = TXT_GREEN
                SetStatus("🌿 Script loaded!",false)
                Notify("🌿 Centella asiatica đã load xong!",4)
            else
                loaded = false
                loadLbl.Text = "⚠  THẤT BẠI — THỬ LẠI"
                loadLbl.TextColor3 = Color3.fromRGB(220,80,80)
                SetStatus("Load thất bại: "..(tostring(err):sub(1,40)),true)
                Notify("🌿 Lỗi: "..tostring(err):sub(1,60),5)
            end
        end)
    end)

    local s3 = Section(p,"Priority (mặc định)",3)
    Label(s3,"1. Boss\n2. Pity Boss\n3. Summon [Other]\n4. Summon\n5. Level Farm\n6. All Mob Farm\n7. Mob\n8. Merchant\n9. Alt Help",1)
    Label(s3,"⚠ Thứ tự này được set tự động. Không cần chỉnh thêm.",2)
end

-- ─── PANEL OPEN/CLOSE ──────────────────────────────────────────────
local panelOpen = false
local OPEN_POS  = UDim2.new(0, 62, 0.5, -MENU_H/2)
local CLOSE_POS = UDim2.new(0, -MENU_W-10, 0.5, -MENU_H/2)

local function OpenPanel()
    panelOpen = true
    Panel.Visible = true
    Panel.Position = CLOSE_POS
    Tw(Panel, 0.3, {Position = OPEN_POS}):Play()
end
local function ClosePanel()
    panelOpen = false
    Tw(Panel, 0.25, {Position = CLOSE_POS}):Play()
    task.delay(0.27, function() Panel.Visible = false end)
end

OpenBtn.MouseButton1Click:Connect(function()
    if panelOpen then ClosePanel() else OpenPanel() end
end)
CloseBtn.MouseButton1Click:Connect(ClosePanel)

-- ─── DRAG PANEL ────────────────────────────────────────────────────
do
    local drag, ds, sp = false, nil, nil
    Header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true ds = inp.Position sp = Panel.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = inp.Position - ds
            Panel.Position = UDim2.new(sp.X.Scale, sp.X.Offset+delta.X, sp.Y.Scale, sp.Y.Offset+delta.Y)
            OPEN_POS = Panel.Position
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
end

-- ─── ACTIVATE DEFAULT TAB ──────────────────────────────────────────
task.wait(0.05)
if Tabs[1] then Tabs[1].Btn.MouseButton1Click:Fire() end

-- ─── ENTRANCE ANIMATION ────────────────────────────────────────────
OpenBtn.BackgroundTransparency = 1
Tw(OpenBtn,0.4,{BackgroundTransparency=0}):Play()

SetStatus("🌿 Ready — Vào Config để load script",false)
Notify("🌿 Centella asiatica UI sẵn sàng!\nVào Config → INJECT SCRIPT để bắt đầu.",4)
