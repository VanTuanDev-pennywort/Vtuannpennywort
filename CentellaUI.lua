-- 🌿 Centella asiatica UI — by VanTuanDEV | Mobile | Sailor Piece
if getgenv and getgenv().CENTELLA_UI_RUNNING then warn("[Centella] Already running!") return end
if getgenv then getgenv().CENTELLA_UI_RUNNING = true end
repeat task.wait() until game:IsLoaded()

local Players=game:GetService("Players") local TweenSvc=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local LP=Players.LocalPlayer local PGui=LP:WaitForChild("PlayerGui")

local MAIN_URL="https://raw.githubusercontent.com/VanTuanDev-pennywort/Vtuannpennywort/refs/heads/main/main.lua"
local AC=Color3.fromRGB(72,160,72) local ACD=Color3.fromRGB(28,65,28)
local BD=Color3.fromRGB(10,10,10) local BM=Color3.fromRGB(16,16,16)
local BI=Color3.fromRGB(20,20,20) local BI2=Color3.fromRGB(23,23,23)
local TM=Color3.fromRGB(215,215,215) local TD=Color3.fromRGB(72,72,72)
local TG=Color3.fromRGB(100,200,100) local BR=Color3.fromRGB(30,30,30)

local VP=workspace.CurrentCamera.ViewportSize
local MW=math.min(325,VP.X-10) local MH=math.min(565,VP.Y-50) local SW=52

local function Tw(o,t,p) return TweenSvc:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quad),p) end
local function Cor(p,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 8) c.Parent=p end
local function Str(p,c,t) local s=Instance.new("UIStroke") s.Color=c or AC s.Thickness=t or 1.2 s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border s.Parent=p end
local function Pad(p,l,r,t,b) local pd=Instance.new("UIPadding") pd.PaddingLeft=UDim.new(0,l or 0) pd.PaddingRight=UDim.new(0,r or 0) pd.PaddingTop=UDim.new(0,t or 0) pd.PaddingBottom=UDim.new(0,b or 0) pd.Parent=p end
local function VL(p,g) local l=Instance.new("UIListLayout") l.SortOrder=Enum.SortOrder.LayoutOrder l.FillDirection=Enum.FillDirection.Vertical l.Padding=UDim.new(0,g or 0) l.Parent=p return l end
local function TL(p,txt,size,bold,col,xa,zi)
    local l=Instance.new("TextLabel") l.BackgroundTransparency=1 l.Text=txt
    l.TextSize=size or 12 l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextColor3=col or TM l.TextXAlignment=xa or Enum.TextXAlignment.Center
    l.ZIndex=zi or 14 l.Parent=p return l
end

for _,v in pairs(PGui:GetChildren()) do if v.Name=="CentellaUI" then v:Destroy() end end

local SG=Instance.new("ScreenGui") SG.Name="CentellaUI" SG.ResetOnSpawn=false
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling SG.DisplayOrder=999 SG.IgnoreGuiInset=true
pcall(function() SG.Parent=game:GetService("CoreGui") end)
if not SG.Parent then SG.Parent=PGui end

-- NOTIFY
local NH=Instance.new("Frame") NH.Size=UDim2.new(0,215,0,0)
NH.AnchorPoint=Vector2.new(1,1) NH.Position=UDim2.new(1,-6,1,-6)
NH.BackgroundTransparency=1 NH.ZIndex=100 NH.AutomaticSize=Enum.AutomaticSize.Y NH.Parent=SG
VL(NH,4)
local function Notify(msg,dur)
    dur=dur or 3
    local nf=Instance.new("Frame") nf.Size=UDim2.new(1,0,0,0) nf.AutomaticSize=Enum.AutomaticSize.Y
    nf.BackgroundColor3=BM nf.BorderSizePixel=0 nf.BackgroundTransparency=1
    nf.ZIndex=101 nf.LayoutOrder=-tick() nf.Parent=NH
    Cor(nf,8) Str(nf,AC,1.2) Pad(nf,10,10,7,7)
    local nl=Instance.new("TextLabel") nl.Size=UDim2.new(1,0,0,0)
    nl.AutomaticSize=Enum.AutomaticSize.Y nl.BackgroundTransparency=1
    nl.Text=msg nl.TextColor3=TM nl.TextSize=11 nl.Font=Enum.Font.Gotham
    nl.TextWrapped=true nl.TextXAlignment=Enum.TextXAlignment.Left nl.ZIndex=102 nl.Parent=nf
    Tw(nf,0.2,{BackgroundTransparency=0}):Play()
    task.delay(dur,function() Tw(nf,0.3,{BackgroundTransparency=1}):Play() task.delay(0.35,function() pcall(function() nf:Destroy() end) end) end)
end
_G.CENTELLA_NOTIFY=Notify

-- OPEN BUTTON
local OB=Instance.new("TextButton") OB.Name="OpenBtn"
OB.Size=UDim2.new(0,44,0,44) OB.Position=UDim2.new(0,6,0.5,-22)
OB.BackgroundColor3=BD OB.BorderSizePixel=0
OB.Text="🌿" OB.TextSize=20 OB.Font=Enum.Font.GothamBold OB.ZIndex=20 OB.Parent=SG
Cor(OB,12) Str(OB,AC,1.5)
do
    local dr,ds,sp=false,nil,nil
    OB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true ds=i.Position sp=OB.Position end end)
    UIS.InputChanged:Connect(function(i) if dr and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then local d=i.Position-ds OB.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
end

-- PANEL
local Panel=Instance.new("Frame") Panel.Name="Panel"
Panel.Size=UDim2.new(0,MW,0,MH) Panel.Position=UDim2.new(0,-MW-20,0.5,-MH/2)
Panel.BackgroundColor3=BD Panel.BorderSizePixel=0 Panel.ZIndex=10
Panel.ClipsDescendants=true Panel.Visible=false Panel.Parent=SG
Cor(Panel,12) Str(Panel,AC,1.5)

local TL2=Instance.new("Frame") TL2.Size=UDim2.new(1,0,0,2) TL2.BackgroundColor3=AC
TL2.BorderSizePixel=0 TL2.ZIndex=11 TL2.Parent=Panel
local tlg=Instance.new("UIGradient") tlg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(25,80,25)),ColorSequenceKeypoint.new(0.5,AC),ColorSequenceKeypoint.new(1,Color3.fromRGB(25,80,25))}) tlg.Parent=TL2

-- HEADER
local Hdr=Instance.new("Frame") Hdr.Size=UDim2.new(1,0,0,50) Hdr.Position=UDim2.new(0,0,0,2)
Hdr.BackgroundColor3=BM Hdr.BorderSizePixel=0 Hdr.ZIndex=11 Hdr.Parent=Panel
local HLine=Instance.new("Frame") HLine.Size=UDim2.new(1,0,0,1) HLine.Position=UDim2.new(0,0,1,-1)
HLine.BackgroundColor3=BR HLine.BorderSizePixel=0 HLine.ZIndex=12 HLine.Parent=Hdr

local IF=Instance.new("Frame") IF.Size=UDim2.new(0,34,0,34) IF.Position=UDim2.new(0,10,0.5,-17)
IF.BackgroundColor3=ACD IF.BorderSizePixel=0 IF.ZIndex=12 IF.Parent=Hdr
Cor(IF,8) Str(IF,AC,1.2)
local IL=TL(IF,"🌿",18,true,nil,nil,13) IL.Size=UDim2.new(1,0,1,0)

local TitleL=Instance.new("TextLabel") TitleL.Size=UDim2.new(1,-100,0,20) TitleL.Position=UDim2.new(0,52,0,7)
TitleL.BackgroundTransparency=1 TitleL.Text="Centella asiatica" TitleL.TextColor3=TM
TitleL.TextSize=13 TitleL.Font=Enum.Font.GothamBold TitleL.TextXAlignment=Enum.TextXAlignment.Left
TitleL.ZIndex=12 TitleL.Parent=Hdr
local tg2=Instance.new("UIGradient") tg2.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,TG)}) tg2.Parent=TitleL

local SubL=Instance.new("TextLabel") SubL.Size=UDim2.new(1,-100,0,13) SubL.Position=UDim2.new(0,52,0,28)
SubL.BackgroundTransparency=1 SubL.Text="by VanTuanDEV  •  Sailor Piece" SubL.TextColor3=TD
SubL.TextSize=9 SubL.Font=Enum.Font.Gotham SubL.TextXAlignment=Enum.TextXAlignment.Left
SubL.ZIndex=12 SubL.Parent=Hdr

local XBtn=Instance.new("TextButton") XBtn.Size=UDim2.new(0,26,0,26) XBtn.Position=UDim2.new(1,-34,0.5,-13)
XBtn.BackgroundColor3=BI XBtn.BorderSizePixel=0 XBtn.Text="✕" XBtn.TextColor3=TD
XBtn.TextSize=11 XBtn.Font=Enum.Font.GothamBold XBtn.ZIndex=13 XBtn.Parent=Hdr
Cor(XBtn,6) Str(XBtn,BR,1)

-- BODY
local Body=Instance.new("Frame") Body.Size=UDim2.new(1,0,1,-74) Body.Position=UDim2.new(0,0,0,52)
Body.BackgroundTransparency=1 Body.ZIndex=11 Body.Parent=Panel

local Sidebar=Instance.new("Frame") Sidebar.Size=UDim2.new(0,SW,1,0)
Sidebar.BackgroundColor3=BM Sidebar.BorderSizePixel=0 Sidebar.ZIndex=12 Sidebar.Parent=Body
local SBL=Instance.new("Frame") SBL.Size=UDim2.new(0,1,1,0) SBL.Position=UDim2.new(1,-1,0,0)
SBL.BackgroundColor3=BR SBL.BorderSizePixel=0 SBL.ZIndex=13 SBL.Parent=Sidebar
VL(Sidebar,2) Pad(Sidebar,3,3,6,4)

local CA=Instance.new("Frame") CA.Size=UDim2.new(1,-SW,1,0) CA.Position=UDim2.new(0,SW,0,0)
CA.BackgroundTransparency=1 CA.ZIndex=12 CA.ClipsDescendants=true CA.Parent=Body

-- STATUS
local SB=Instance.new("Frame") SB.Size=UDim2.new(1,0,0,22) SB.Position=UDim2.new(0,0,1,-22)
SB.BackgroundColor3=Color3.fromRGB(8,8,8) SB.BorderSizePixel=0 SB.ZIndex=15 SB.Parent=Panel
local SBTop=Instance.new("Frame") SBTop.Size=UDim2.new(1,0,0,1) SBTop.BackgroundColor3=BR
SBTop.BorderSizePixel=0 SBTop.ZIndex=16 SBTop.Parent=SB
local SDot=Instance.new("Frame") SDot.Size=UDim2.new(0,6,0,6) SDot.Position=UDim2.new(0,8,0.5,-3)
SDot.BackgroundColor3=AC SDot.BorderSizePixel=0 SDot.ZIndex=16 SDot.Parent=SB Cor(SDot,3)
local STxt=Instance.new("TextLabel") STxt.Size=UDim2.new(1,-18,1,0) STxt.Position=UDim2.new(0,18,0,0)
STxt.BackgroundTransparency=1 STxt.Text="Ready" STxt.TextColor3=TD STxt.TextSize=9
STxt.Font=Enum.Font.Gotham STxt.TextXAlignment=Enum.TextXAlignment.Left STxt.ZIndex=16 STxt.Parent=SB

local function SetStatus(t,e) STxt.Text=t SDot.BackgroundColor3=e and Color3.fromRGB(200,60,60) or AC end

-- ══════════════════════════════════════════
-- TAB SYSTEM — fixed: SwitchTab uses lookup
-- ══════════════════════════════════════════
local TabList={} -- {Btn,NameL,ABar,pageName,Page}
local Pages={}

local function SwitchTab(pn)
    for _,td in ipairs(TabList) do
        Tw(td.Btn,0.12,{BackgroundColor3=BM}):Play()
        td.NameL.TextColor3=TD
        Tw(td.ABar,0.12,{Size=UDim2.new(0,3,0,0)}):Play()
        td.Page.Visible=false
    end
    for _,td in ipairs(TabList) do
        if td.pageName==pn then
            Tw(td.Btn,0.15,{BackgroundColor3=ACD}):Play()
            td.NameL.TextColor3=TG
            Tw(td.ABar,0.15,{Size=UDim2.new(0,3,0,32)}):Play()
            td.Page.Visible=true
            break
        end
    end
end

local function MakeTab(icon,label,order,pn)
    -- page
    local pg=Instance.new("ScrollingFrame") pg.Name="Pg_"..pn
    pg.Size=UDim2.new(1,0,1,0) pg.BackgroundTransparency=1 pg.BorderSizePixel=0
    pg.ScrollBarThickness=3 pg.ScrollBarImageColor3=AC
    pg.CanvasSize=UDim2.new(0,0,0,0) pg.AutomaticCanvasSize=Enum.AutomaticSize.Y
    pg.Visible=false pg.ZIndex=13 pg.Parent=CA
    Pad(pg,7,5,6,8) VL(pg,6) Pages[pn]=pg
    -- button
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(1,0,0,50)
    btn.BackgroundColor3=BM btn.BorderSizePixel=0 btn.Text=""
    btn.ZIndex=13 btn.LayoutOrder=order btn.Parent=Sidebar Cor(btn,7)
    local ico=Instance.new("TextLabel") ico.Size=UDim2.new(1,0,0,26) ico.Position=UDim2.new(0,0,0,5)
    ico.BackgroundTransparency=1 ico.Text=icon ico.TextSize=20 ico.Font=Enum.Font.GothamBold ico.ZIndex=14 ico.Parent=btn
    local nm=Instance.new("TextLabel") nm.Size=UDim2.new(1,0,0,13) nm.Position=UDim2.new(0,0,0,30)
    nm.BackgroundTransparency=1 nm.Text=label nm.TextColor3=TD nm.TextSize=8
    nm.Font=Enum.Font.GothamBold nm.ZIndex=14 nm.Parent=btn
    local ab=Instance.new("Frame") ab.Size=UDim2.new(0,3,0,0) ab.Position=UDim2.new(1,-3,0.5,0)
    ab.AnchorPoint=Vector2.new(0,0.5) ab.BackgroundColor3=AC ab.BorderSizePixel=0 ab.ZIndex=14 ab.Parent=btn Cor(ab,2)
    local td={Btn=btn,NameL=nm,ABar=ab,pageName=pn,Page=pg}
    table.insert(TabList,td)
    btn.MouseButton1Click:Connect(function() SwitchTab(pn) end)
    return pg
end

-- create all tabs
local P={
    Main  =MakeTab("⚔","Main",  1,"Main"),
    Boss  =MakeTab("💀","Boss",  2,"Boss"),
    Auto  =MakeTab("🔄","Auto",  3,"Auto"),
    Player=MakeTab("🧑","Player",4,"Player"),
    Misc  =MakeTab("🌿","Misc",  5,"Misc"),
    Config=MakeTab("⚙","Config",6,"Config"),
}

-- ══════════════════════════════════════════
-- ELEMENT BUILDERS
-- ══════════════════════════════════════════
local function Sec(page,title,order)
    local sec=Instance.new("Frame") sec.Size=UDim2.new(1,0,0,0) sec.AutomaticSize=Enum.AutomaticSize.Y
    sec.BackgroundColor3=BI sec.BorderSizePixel=0 sec.ZIndex=14 sec.LayoutOrder=order or 0 sec.Parent=page
    Cor(sec,8) Str(sec,BR,1) Pad(sec,8,8,5,8) VL(sec,4)
    local tr=Instance.new("Frame") tr.Size=UDim2.new(1,0,0,22) tr.BackgroundTransparency=1
    tr.ZIndex=15 tr.LayoutOrder=0 tr.Parent=sec
    local ac2=Instance.new("Frame") ac2.Size=UDim2.new(0,2,0,13) ac2.Position=UDim2.new(0,0,0.5,-6)
    ac2.BackgroundColor3=AC ac2.BorderSizePixel=0 ac2.ZIndex=16 ac2.Parent=tr Cor(ac2,2)
    local tl3=Instance.new("TextLabel") tl3.Size=UDim2.new(1,-10,1,0) tl3.Position=UDim2.new(0,8,0,0)
    tl3.BackgroundTransparency=1 tl3.Text=title:upper() tl3.TextColor3=TG tl3.TextSize=9
    tl3.Font=Enum.Font.GothamBold tl3.TextXAlignment=Enum.TextXAlignment.Left tl3.ZIndex=16 tl3.Parent=tr
    local items=Instance.new("Frame") items.Name="I" items.Size=UDim2.new(1,0,0,0)
    items.AutomaticSize=Enum.AutomaticSize.Y items.BackgroundTransparency=1
    items.ZIndex=15 items.LayoutOrder=1 items.Parent=sec VL(items,3)
    return items
end

local function Tog(par,label,desc,order,def,key)
    local h=desc and 46 or 38
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,h) row.BackgroundColor3=BI2
    row.BorderSizePixel=0 row.ZIndex=16 row.LayoutOrder=order or 0 row.Parent=par
    Cor(row,6) Str(row,BR,1)
    local lbl=Instance.new("TextLabel") lbl.Size=UDim2.new(1,-54,0,18)
    lbl.Position=UDim2.new(0,9,0,desc and 6 or 10) lbl.BackgroundTransparency=1
    lbl.Text=label lbl.TextColor3=TM lbl.TextSize=12 lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left lbl.ZIndex=17 lbl.Parent=row
    if desc then
        local dl=Instance.new("TextLabel") dl.Size=UDim2.new(1,-54,0,13)
        dl.Position=UDim2.new(0,9,0,24) dl.BackgroundTransparency=1 dl.Text=desc
        dl.TextColor3=TD dl.TextSize=9 dl.Font=Enum.Font.Gotham
        dl.TextXAlignment=Enum.TextXAlignment.Left dl.ZIndex=17 dl.Parent=row
    end
    local trk=Instance.new("Frame") trk.Size=UDim2.new(0,38,0,20) trk.Position=UDim2.new(1,-45,0.5,-10)
    trk.BackgroundColor3=Color3.fromRGB(32,32,32) trk.BorderSizePixel=0 trk.ZIndex=17 trk.Parent=row Cor(trk,10)
    local knb=Instance.new("Frame") knb.Size=UDim2.new(0,14,0,14) knb.Position=UDim2.new(0,3,0.5,-7)
    knb.BackgroundColor3=Color3.fromRGB(72,72,72) knb.BorderSizePixel=0 knb.ZIndex=18 knb.Parent=trk Cor(knb,7)
    local val=def or false
    local function SV(v,skip)
        val=v
        if v then Tw(trk,0.18,{BackgroundColor3=ACD}):Play() Tw(knb,0.18,{Position=UDim2.new(0,21,0.5,-7),BackgroundColor3=TG}):Play()
        else Tw(trk,0.18,{BackgroundColor3=Color3.fromRGB(32,32,32)}):Play() Tw(knb,0.18,{Position=UDim2.new(0,3,0.5,-7),BackgroundColor3=Color3.fromRGB(72,72,72)}):Play() end
        if not skip and key and getgenv().CENTELLA_TOGGLES then
            local T=getgenv().CENTELLA_TOGGLES if T[key] then T[key]:SetValue(v) end
        end
    end
    SV(val,true)
    local hb=Instance.new("TextButton") hb.Size=UDim2.new(1,0,1,0) hb.BackgroundTransparency=1
    hb.Text="" hb.ZIndex=19 hb.Parent=row
    hb.MouseButton1Click:Connect(function() SV(not val) end)
    task.spawn(function()
        while SG.Parent do task.wait(1.2)
            if key and getgenv().CENTELLA_TOGGLES then
                local T=getgenv().CENTELLA_TOGGLES
                if T[key] and T[key].Value~=val then SV(T[key].Value,true) end
            end
        end
    end)
    return {Set=SV,Get=function() return val end}
end

local function Butn(par,label,order,cb)
    local b=Instance.new("TextButton") b.Size=UDim2.new(1,0,0,38) b.BackgroundColor3=BI2
    b.BorderSizePixel=0 b.Text="" b.ZIndex=16 b.LayoutOrder=order or 0 b.Parent=par
    Cor(b,6) Str(b,BR,1)
    local lbl=Instance.new("TextLabel") lbl.Size=UDim2.new(1,-28,1,0) lbl.Position=UDim2.new(0,9,0,0)
    lbl.BackgroundTransparency=1 lbl.Text=label lbl.TextColor3=TM lbl.TextSize=12
    lbl.Font=Enum.Font.GothamBold lbl.TextXAlignment=Enum.TextXAlignment.Left lbl.ZIndex=17 lbl.Parent=b
    local arr=Instance.new("TextLabel") arr.Size=UDim2.new(0,18,1,0) arr.Position=UDim2.new(1,-22,0,0)
    arr.BackgroundTransparency=1 arr.Text="›" arr.TextColor3=TG arr.TextSize=18
    arr.Font=Enum.Font.GothamBold arr.ZIndex=17 arr.Parent=b
    b.MouseButton1Click:Connect(function()
        Tw(b,0.06,{BackgroundColor3=BM}):Play() task.delay(0.1,function() Tw(b,0.08,{BackgroundColor3=BI2}):Play() end)
        if cb then pcall(cb) end
    end)
end

local function Info(par,text,order,green)
    local l=Instance.new("TextLabel") l.Size=UDim2.new(1,0,0,0) l.AutomaticSize=Enum.AutomaticSize.Y
    l.BackgroundTransparency=1 l.Text=text l.TextColor3=green and TG or TD
    l.TextSize=10 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left
    l.TextWrapped=true l.ZIndex=16 l.LayoutOrder=order or 0 l.Parent=par
end

-- ══════════════════════════════════════════
-- TAB CONTENT
-- ══════════════════════════════════════════

-- MAIN
do
    local s=Sec(P.Main,"Auto Farm",1)
    Tog(s,"🗡 Farm Mob","Farm mob đã chọn",1,false,"MobFarm")
    Tog(s,"🌀 Farm All Mobs","Xoay vòng toàn bộ mob",2,false,"AllMobFarm")
    Tog(s,"📈 Farm Level","Farm quest theo level",3,false,"LevelFarm")
    local s2=Sec(P.Main,"Combat & Skills",2)
    Tog(s2,"👊 Auto M1","Spam M1 tự động",1,false,"AutoM1")
    Tog(s2,"💥 Auto Skill","Dùng skill Z/X/C/V/F",2,false,"AutoSkill")
    Tog(s2,"🌀 Auto Combo","Chạy combo skill",3,false,"AutoCombo")
    Tog(s2,"⚡ Kill Aura","Tấn công mob gần nhất",4,false,"KillAura")
    Tog(s2,"☠ Instant Kill","Kill tức thì theo HP%",5,false,"InstaKill")
    Tog(s2,"🔄 Switch Weapon","Xoay vũ khí khi farm",6,true,"SwitchWeapon")
    local s3=Sec(P.Main,"Haki",3)
    Tog(s3,"👁 Observation Haki",nil,1,false,"ObserHaki")
    Tog(s3,"💪 Armament Haki",nil,2,false,"ArmHaki")
    Tog(s3,"👑 Conqueror Haki",nil,3,false,"ConquerorHaki")
end

-- BOSS
do
    local s=Sec(P.Boss,"World Boss",1)
    Tog(s,"💀 Farm Boss","Farm boss đã chọn",1,false,"BossesFarm")
    Tog(s,"💀 Farm All Bosses","Farm mọi boss spawn",2,false,"AllBossesFarm")
    local s2=Sec(P.Boss,"Summon Boss",2)
    Tog(s2,"🔮 Auto Summon","Tự summon boss",1,false,"AutoSummon")
    Tog(s2,"⚔ Farm Summon Boss","Farm summon boss",2,false,"SummonBossFarm")
    local s3=Sec(P.Boss,"Pity Boss",3)
    Tog(s3,"📊 Pity Boss Farm","Build pity → dùng pity boss",1,false,"PityBossFarm")
    local s4=Sec(P.Boss,"Other Summon",4)
    Tog(s4,"🌟 Auto Other Summon","Summon Anos/Strongest...",1,false,"AutoOtherSummon")
    Tog(s4,"⚔ Farm Other Summon","Farm other summon boss",2,false,"OtherSummonFarm")
    local s5=Sec(P.Boss,"Alt Help",5)
    Tog(s5,"🤝 Auto Help Alt","Giúp alt farm boss",1,false,"AltBossFarm")
    Info(s5,"⚠ Cấu hình boss/alt sau khi inject script",2)
end

-- AUTO
do
    local s=Sec(P.Auto,"Stats & Tiến Trình",1)
    Tog(s,"📊 Auto Stats","Tự phân bổ stat points",1,false,"AutoStats")
    Tog(s,"🎲 Auto Roll Gem Stats","Reroll gem đến rank mục tiêu",2,false,"AutoRollStats")
    Tog(s,"⬆ Auto Ascend","Tự ascend khi đủ điều kiện",3,false,"AutoAscend")
    Tog(s,"🌳 Auto Skill Tree","Tự upgrade skill tree",4,false,"AutoSkillTree")
    local s2=Sec(P.Auto,"Rolls",2)
    Tog(s2,"🃏 Auto Roll Trait","Roll đến trait mục tiêu",1,false,"AutoTrait")
    Tog(s2,"🧬 Auto Roll Race","Roll đến race mục tiêu",2,false,"AutoRace")
    Tog(s2,"🛡 Auto Roll Clan","Roll đến clan mục tiêu",3,false,"AutoClan")
    Tog(s2,"🔮 Auto Reroll Passive","Reroll spec passive",4,false,"AutoSpec")
    local s3=Sec(P.Auto,"Equipment",3)
    Tog(s3,"✨ Auto Enchant","Tự enchant accessory",1,false,"AutoEnchant")
    Tog(s3,"✨ Auto Enchant All","Enchant toàn bộ",2,false,"AutoEnchantAll")
    Tog(s3,"🙏 Auto Blessing","Tự bless vũ khí",3,false,"AutoBlessing")
    Tog(s3,"🙏 Auto Blessing All","Bless toàn bộ",4,false,"AutoBlessingAll")
    local s4=Sec(P.Auto,"Artifact",4)
    Tog(s4,"⬆ Auto Upgrade","Tự upgrade artifact",1,false,"ArtifactUpgrade")
    Tog(s4,"🔒 Auto Lock","Tự lock artifact tốt",2,false,"ArtifactLock")
    Tog(s4,"🗑 Auto Delete","Tự xóa artifact xấu",3,false,"ArtifactDelete")
    Tog(s4,"🎽 Auto Equip","Equip artifact tốt nhất",4,false,"ArtifactEquip")
    Tog(s4,"🏆 Artifact Milestone","Claim milestone",5,false,"ArtifactMilestone")
    local s5=Sec(P.Auto,"Dungeon & Content",5)
    Tog(s5,"🚪 Auto Join Dungeon","Tự vào dungeon",1,false,"AutoDungeon")
    Tog(s5,"🗼 Auto Infinite Tower","Farm Infinite Tower",2,false,"AutoInfiniteTower")
    Tog(s5,"📜 Auto Questline","Tự làm questline [BETA]",3,false,"AutoQuestline")
    local s6=Sec(P.Auto,"Unlock Quests ✨",6)
    Tog(s6,"🧩 Dungeon Pieces Quest","Thu 6 mảnh dungeon puzzle",1,false,"DungeonQuest")
    Tog(s6,"💎 Hogyoku Fragments","Thu mảnh → mở Soul Society",2,false,"HogyokuQuest")
    Info(s6,"🌿 Dungeon: Starter→Jungle→Desert→Snow→Shibuya→HuecoMundo\n🌿 Hogyoku: Snow→Shibuya→HuecoMundo→Shinjuku→Slime→Judgement",3,true)
end

-- PLAYER
do
    local s=Sec(P.Player,"Server & Kết Nối",1)
    Tog(s,"💤 Anti AFK","Tránh bị kick AFK",1,true,"AntiAFK")
    Tog(s,"🔄 Auto Reconnect","Tự rejoin khi disconnect",2,false,"AutoReconnect")
    Tog(s,"🚫 Anti Kick","Chống kick client-side",3,false,"AntiKick")
    Tog(s,"🔕 Auto Hide Notif","Ẩn thông báo thừa",4,false,"AutoDeleteNotif")
    local s2=Sec(P.Player,"Safety",2)
    Tog(s2,"🛡 Auto Kick Safety","Kick nếu mod/player join",1,false,"AutoKick")
    local s3=Sec(P.Player,"Performance",3)
    Tog(s3,"⚡ FPS Boost","Xóa shadow & particle",1,false,"FPSBoost")
    Tog(s3,"⚡ FPS Boost Farm","Xóa island khi farm",2,false,"FPSBoost_AF")
    Tog(s3,"🚶 Noclip","Đi xuyên tường",3,false,"Noclip")
    Tog(s3,"🛡 Anti Knockback","Chống knockback",4,false,"AntiKnockback")
    Tog(s3,"💡 Fullbright","Sáng toàn bộ map",5,false,"Fullbright")
    Tog(s3,"🌫 No Fog","Xóa sương mù",6,false,"NoFog")
    local s4=Sec(P.Player,"Actions",4)
    Butn(s4,"⚠ Panic Stop (Dừng Tất Cả)",1,function()
        if getgenv().CENTELLA_TOGGLES then for _,t in pairs(getgenv().CENTELLA_TOGGLES) do pcall(function() t:SetValue(false) end) end end
        Notify("🌿 Panic Stop — Đã dừng tất cả!",3) SetStatus("PANIC STOP",true)
    end)
    Butn(s4,"🔄 Rejoin Server",2,function()
        game:GetService("TeleportService"):Teleport(game.PlaceId,LP)
    end)
end

-- MISC
do
    local s=Sec(P.Misc,"Merchant",1)
    Tog(s,"🛒 Auto Merchant","Tự mua item từ merchant",1,false,"AutoMerchant")
    Info(s,"🌿 Regular, Dungeon, Valentine, Tower, Boss Rush",2,true)
    local s2=Sec(P.Misc,"Items",2)
    Tog(s2,"📦 Auto Open Chests","Tự mở tất cả chest",1,false,"AutoChest")
    Tog(s2,"⚒ Auto Craft","Craft Divine Grail & Slime Key",2,false,"AutoCraftItem")
    local s3=Sec(P.Misc,"Puzzle Solvers",3)
    Butn(s3,"🗝 Dungeon Puzzle (6 Mảnh)",1,function()
        if getgenv().CENTELLA_TOGGLES then getgenv().CENTELLA_TOGGLES.DungeonQuest:SetValue(true) end
        Notify("🌿 Dungeon Quest bắt đầu!",3)
    end)
    Butn(s3,"💎 Hogyoku Fragments Quest",2,function()
        if getgenv().CENTELLA_TOGGLES then getgenv().CENTELLA_TOGGLES.HogyokuQuest:SetValue(true) end
        Notify("🌿 Hogyoku Quest bắt đầu!",3)
    end)
    Butn(s3,"💝 Valentine Puzzle",3,function()
        pcall(function()
            local RS2=game:GetService("ReplicatedStorage")
            RS2.Remotes.TeleportToPortal:FireServer("Valentine") task.wait(2.5)
            local c2=LP.Character
            for i=1,3 do
                local item=workspace:FindFirstChild("Heart"..i)
                if item then
                    local pr=item:FindFirstChildOfClass("ProximityPrompt")
                    if pr and c2 then c2.HumanoidRootPart.CFrame=item.CFrame*CFrame.new(0,3,0) task.wait(0.2) fireproximityprompt(pr) task.wait(0.5) end
                end
            end
        end)
        Notify("🌿 Valentine Puzzle xong!",3)
    end)
end

-- CONFIG
do
    local s=Sec(P.Config,"Thông Tin",1)
    Info(s,"🌿 Centella asiatica — by VanTuanDEV",1,true)
    Info(s,"📜 Logic: celina + SailorPiece Quests\n🎮 Sailor Piece\n🌿 Nút 🌿 bên trái = mở/đóng menu",2)
    local s2=Sec(P.Config,"Inject Script",2)
    Info(s2,"⚡ Bấm nút bên dưới để load script!\nCác toggle chỉ hoạt động SAU khi inject.",1,true)

    local lf=Instance.new("Frame") lf.Size=UDim2.new(1,0,0,48) lf.BackgroundColor3=ACD
    lf.BorderSizePixel=0 lf.ZIndex=16 lf.LayoutOrder=2 lf.Parent=s2
    Cor(lf,10) Str(lf,AC,1.5)
    local lb=Instance.new("TextButton") lb.Size=UDim2.new(1,0,1,0) lb.BackgroundTransparency=1
    lb.Text="" lb.ZIndex=17 lb.Parent=lf
    local li=Instance.new("TextLabel") li.Size=UDim2.new(0,34,1,0) li.Position=UDim2.new(0,10,0,0)
    li.BackgroundTransparency=1 li.Text="🌿" li.TextSize=22 li.Font=Enum.Font.GothamBold li.ZIndex=18 li.Parent=lf
    local lt=Instance.new("TextLabel") lt.Size=UDim2.new(1,-46,1,0) lt.Position=UDim2.new(0,44,0,0)
    lt.BackgroundTransparency=1 lt.Text="INJECT SCRIPT" lt.TextColor3=TG lt.TextSize=14
    lt.Font=Enum.Font.GothamBold lt.TextXAlignment=Enum.TextXAlignment.Left lt.ZIndex=18 lt.Parent=lf

    local loaded=false
    lb.MouseButton1Click:Connect(function()
        if loaded then Notify("🌿 Script đã được load rồi!",2) return end
        loaded=true lt.Text="ĐANG LOAD..." lt.TextColor3=Color3.fromRGB(200,200,70)
        SetStatus("Đang inject...",false)
        task.spawn(function()
            local ok,err=pcall(function() loadstring(game:HttpGet(MAIN_URL,true))() end)
            if ok then
                lt.Text="✓  ĐÃ LOAD!" lt.TextColor3=TG lf.BackgroundColor3=Color3.fromRGB(18,50,18)
                SetStatus("🌿 Script loaded!",false)
                Notify("🌿 Script đã load xong!\nGiờ bật toggle bên trái nhé.",4)
            else
                loaded=false lt.Text="⚠  THẤT BẠI — THỬ LẠI" lt.TextColor3=Color3.fromRGB(220,70,70)
                SetStatus("Lỗi load",true)
                Notify("🌿 Lỗi: "..tostring(err):sub(1,80),5)
            end
        end)
    end)

    local s3=Sec(P.Config,"Priority",3)
    Info(s3,"1.Boss  2.Pity Boss  3.Summon Other\n4.Summon  5.Level Farm  6.All Mob\n7.Mob  8.Merchant  9.Alt Help",1)
end

-- ══════════════════════════════════════════
-- OPEN/CLOSE
-- ══════════════════════════════════════════
local panelOpen=false
local OP=UDim2.new(0,56,0.5,-MH/2)
local CP=UDim2.new(0,-MW-20,0.5,-MH/2)

local function Open() panelOpen=true Panel.Visible=true Panel.Position=CP Tw(Panel,0.3,{Position=OP}):Play() end
local function Close() panelOpen=false Tw(Panel,0.25,{Position=CP}):Play() task.delay(0.27,function() Panel.Visible=false end) end

OB.MouseButton1Click:Connect(function() if panelOpen then Close() else Open() end end)
XBtn.MouseButton1Click:Connect(Close)

-- drag panel
do
    local dr,ds,sp=false,nil,nil
    Hdr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true ds=i.Position sp=Panel.Position end end)
    UIS.InputChanged:Connect(function(i)
        if dr and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            local d=i.Position-ds local np=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
            Panel.Position=np OP=np
        end
    end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
end

-- ── ACTIVATE MAIN TAB ──
task.wait(0.15)
SwitchTab("Main")

OB.BackgroundTransparency=1 Tw(OB,0.5,{BackgroundTransparency=0}):Play()
SetStatus("🌿 Vào Config → INJECT SCRIPT",false)
Notify("🌿 Centella asiatica ready!\nNút 🌿 trái = mở menu\nConfig → Inject Script để bắt đầu.",4)
