--[[
⠀this is just a test
]]--

local s={}
s.Appearance={Title="RFour Hub",Subtitle="idc",Icon=""}
s.Links={GetKey="",Discord="https://suic1.de/discord"}
s.LinkActions={GetKey={Clipboard=true,WebView=true},Discord={Clipboard=true,WebView=false},Buy={Clipboard=true,WebView=true}}
s.Storage={FileName="RFOUR_KEY",Folder="",Remember=true,AutoLoad=true}
s.Options={Keyless=nil,KeylessUi=true,Draggable=true,Intro=false,Blur=true,ToastDuration=3.2}
s.Shop={Enabled=true,Title="",Subtitle="",ButtonText="Buy",Icon="",Link="https://arch.rest/buy"}
s.Callbacks={OnVerify="",OnSuccess="",OnFail="",OnReady=""}
s.Theme={bg=Color3.fromRGB(5,5,6),panel=Color3.fromRGB(18,19,21),panel2=Color3.fromRGB(24,25,28),panel3=Color3.fromRGB(31,32,35),edge=Color3.fromRGB(61,62,66),edge2=Color3.fromRGB(43,44,47),text=Color3.fromRGB(245,245,245),sub=Color3.fromRGB(157,157,160),muted=Color3.fromRGB(101,102,105),white=Color3.fromRGB(255,255,255)}
s.Defaults={Appearance={Title="RFour Hub",Subtitle="idc",Icon=""},Links={GetKey="",Discord="https://suic1.de/discord"},LinkActions={GetKey={Clipboard=true,WebView=true},Discord={Clipboard=true,WebView=false},Buy={Clipboard=true,WebView=true}},Storage={FileName="RFOUR_KEY",Folder="",Remember=true,AutoLoad=true},Options={Keyless=nil,KeylessUi=true,Draggable=true,Intro=false,Blur=true,ToastDuration=3.2},Shop={Enabled=true,Title="",Subtitle="",ButtonText="Buy",Icon="",Link="https://arch.rest/buy"}}
local T=game:GetService("TweenService")
local U=game:GetService("UserInputService")
local L=game:GetService("Lighting")
local PL=game:GetService("Players")
local CG=game:GetService("CoreGui")
local st={on=false,busy=false,fail=0,until=0,root=nil,card=nil,input=nil,verify=nil,close=nil,get=nil,disc=nil,toasth=nil,tid=0,sdk=nil,sdkBusy=false,sdkErr=nil,junkie=nil,closing=false}
local con={}
local objs={}
local toastList={}
local function q(f,...)
 if type(f)~="function" then return false,nil end
 return pcall(f,...)
end
local function c(x) if x then con[#con+1]=x end return x end
local function o(x) if x then objs[#objs+1]=x end return x end
local function mk(k,p,par)
 local x=Instance.new(k)
 if p then for a,b in pairs(p) do x[a]=b end end
 x.Parent=par
 return o(x)
end
local function cr(x,r) return mk("UICorner",{CornerRadius=UDim.new(0,r)},x) end
local function stx(x,col,tr,th) return mk("UIStroke",{Color=col or s.Theme.edge,Transparency=tr or 0,Thickness=th or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},x) end
local function tw(x,d,p,e,dr)
 if not x then return end
 local z=T:Create(x,TweenInfo.new(d or .2,e or Enum.EasingStyle.Quint,dr or Enum.EasingDirection.Out),p);z:Play();return z
end
local function parent()
 if type(gethui)=="function" then local ok,v=pcall(gethui);if ok and v then return v end end
 return CG
end
local function clip(v)
 local f=setclipboard or toclipboard or set_clipboard
 if type(f)~="function" then return false end
 return pcall(f,tostring(v))
end
local function trim(v) return tostring(v or ""):gsub("^%s+",""):gsub("%s+$","") end
function s:Sanitize(v)
 v=trim(v):gsub("[%c]","")
 if #v>512 then v=v:sub(1,512) end
 return v
end
function s:IsMobile() return U.TouchEnabled and ((workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 600)<650) end
function s:IsAlive() return st.on==true end
function s:IsVerifying() return st.busy==true end
function s:GetFailures() return st.fail end
function s:GetCooldown() return math.max(0,st.until-os.clock()) end
function s:GetCooldownText() local n=self:GetCooldown();return n>0 and ("Wait "..math.ceil(n).."s") or "" end
function s:ResetFailures() st.fail=0;st.until=0 end
function s:ClearCooldown() st.until=0 end
function s:NormalizeKey(v) return self:Sanitize(v) end
function s:IsKeyShapeValid(v) return self:NormalizeKey(v)~="" end
function s:CheckFilesystem() return {Read=type(readfile)=="function",Write=type(writefile)=="function",Exists=type(isfile)=="function",Delete=type(delfile)=="function",Folder=type(isfolder)=="function",MakeFolder=type(makefolder)=="function"} end
function s:CheckClipboard() return type(setclipboard)=="function" or type(toclipboard)=="function" or type(set_clipboard)=="function" end
function s:CheckWebView() local ok,v=pcall(game.GetService,game,"WebViewService");return ok and v~=nil end
function s:CheckHttp() return type(game.HttpGet)=="function" end
function s:CheckLoadstring() return type(loadstring)=="function" end
function s:Compatibility() return {Filesystem=self:CheckFilesystem(),Clipboard=self:CheckClipboard(),WebView=self:CheckWebView(),Http=self:CheckHttp(),Loadstring=self:CheckLoadstring(),Mobile=self:IsMobile()} end
local function path()
 local f=tostring(s.Storage.Folder or "")
 local n=tostring(s.Storage.FileName or "RFOUR_KEY")
 if f=="" then return n end
 return f.."/"..n
end
local function setupFolder()
 if type(isfolder)=="function" and type(makefolder)=="function" then local f=tostring(s.Storage.Folder or "");if f~="" and not isfolder(f) then pcall(makefolder,f) end end
end
function s:GetSavedKey()
 if not (self.Storage.Remember and type(isfile)=="function" and type(readfile)=="function") then return nil end
 local p=path();if not isfile(p) then return nil end
 local ok,v=pcall(readfile,p);if not ok then return nil end
 v=self:NormalizeKey(v);return v~="" and v or nil
end
function s:Save(v)
 v=self:NormalizeKey(v);if v=="" or v=="KEYLESS" or not self.Storage.Remember or type(writefile)~="function" then return false end
 setupFolder();local ok=pcall(writefile,path(),v);return ok
end
function s:ClearSavedKey()
 if type(delfile)=="function" and type(isfile)=="function" and isfile(path()) then return pcall(delfile,path()) end
 return false
end
local function killOld()
 local p=parent()
 if st.root then pcall(function() st.root:Destroy() end) end
 pcall(function() for _,v in ipairs(p:GetChildren()) do if v:IsA("ScreenGui") and v.Name=="suic1de" then v:Destroy() end end end)
 st.root=nil
end
local icons={key="rbxassetid://96510194465420",shield="rbxassetid://110987169760162",check="rbxassetid://93898873302694",x="rbxassetid://110786993356448",link="rbxassetid://131607023382430",discord="rbxassetid://88082592882886",loader="rbxassetid://78408734580845",clipboard="rbxassetid://89601995828423",info="rbxassetid://124560466474914"}
local ICON_L="https://raw.githubusercontent.com/ArchIsDead/Arch-Vault/refs/heads/main/lucide-icons.lua"
local ICON_S="https://raw.githubusercontent.com/ArchIsDead/Arch-Vault/refs/heads/main/solar-icons.lua"
local packs={l={},s={}}
local want={key={"key","key-linear"},shield={"shield-check-linear","shield"},check={"check-circle-linear","circle-check","check"},x={"close-circle-linear","x","close"},link={"link-linear","link"},discord={"chat-round-linear","message-circle","discord"},loader={"refresh-circle-linear","loader-circle","loader"},clipboard={"clipboard-linear","clipboard"},info={"info-circle-linear","info"}}
local function rid(v)
 if type(v)=="string" then if v:match("^rbxassetid://") then return v elseif v:match("^%d+$") then return "rbxassetid://"..v end end
 if type(v)=="table" then return rid(v.id or v.Id or v[1]) end
 return nil
end
local function ia(n)
 for _,k in ipairs(want[n] or {n}) do local v=rid(packs.s[k]) or rid(packs.l[k]);if v then return v end end
 return icons[n] or ""
end
local function icon(par,n,sz,col)
 local x=mk("ImageLabel",{BackgroundTransparency=1,AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(sz,sz),Image=ia(n),ImageColor3=col or s.Theme.text,ScaleType=Enum.ScaleType.Fit},par);x:SetAttribute("i",n);return x
end
local function remote(url)
 local ok,src=pcall(game.HttpGet,game,url);if not ok or type(src)~="string" or src=="" then return nil end
 local ok2,fn=pcall(loadstring,src);if not ok2 or type(fn)~="function" then return nil end
 local ok3,v=pcall(fn);return ok3 and type(v)=="table" and v or nil
end
local function loadIcons()
 task.spawn(function()
  local a=remote(ICON_S);if a then packs.s=a end
  local b=remote(ICON_L);if b then packs.l=b end
  if st.root then for _,v in ipairs(st.root:GetDescendants()) do if v:IsA("ImageLabel") then local n=v:GetAttribute("i");if n then v.Image=ia(n) end end end end
 end)
end
local function blur(on)
 if on then
  if not s.Options.Blur then return end
  for _,x in ipairs(L:GetChildren()) do if x:IsA("BlurEffect") and x:GetAttribute("sui") then pcall(function() x:Destroy() end) elseif x:IsA("BlurEffect") and x.Name=="suic1de_blur" then pcall(function() x:Destroy() end) end end
  local b=Instance.new("BlurEffect");b.Size=0;b.Parent=L;o(b);b:SetAttribute("sui",true);tw(b,.26,{Size=11},Enum.EasingStyle.Quad)
 else
  for _,x in ipairs(L:GetChildren()) do if x:IsA("BlurEffect") and (x:GetAttribute("sui") or x.Name=="suic1de_blur") then tw(x,.18,{Size=0},Enum.EasingStyle.Quad);task.delay(.2,function() pcall(function() x:Destroy() end) end) end end
 end
end
local function toastKind(k)
 k=tostring(k or "info"):lower();if k=="warn" then k="warning" end
 return ({success=true,error=true,warning=true,info=true,copy=true})[k] and k or "info"
end
local function toastColors(k)
 if k=="error" then return s.Theme.white,s.Theme.sub end
 if k=="warning" then return s.Theme.text,s.Theme.muted end
 if k=="success" then return s.Theme.white,s.Theme.sub end
 return s.Theme.text,s.Theme.sub
end
local function toastRemove(n,fast)
 if not n or n.dead then return end
 n.dead=true
 if n.bar then pcall(function() n.bar:Cancel() end) end
 local sc=n.scale
 local t=n.frame
 if t and t.Parent then
  tw(sc,fast and .12 or .2,{Scale=.93},Enum.EasingStyle.Quint,Enum.EasingDirection.In)
  tw(t,fast and .12 or .18,{BackgroundTransparency=1},Enum.EasingStyle.Quad,Enum.EasingDirection.In)
  for _,v in ipairs(t:GetDescendants()) do if v:IsA("TextLabel") or v:IsA("TextButton") then tw(v,fast and .12 or .16,{TextTransparency=1},Enum.EasingStyle.Quad,Enum.EasingDirection.In) elseif v:IsA("ImageLabel") then tw(v,fast and .12 or .16,{ImageTransparency=1},Enum.EasingStyle.Quad,Enum.EasingDirection.In) elseif v:IsA("UIStroke") then tw(v,fast and .12 or .16,{Transparency=1},Enum.EasingStyle.Quad,Enum.EasingDirection.In) end end
  task.delay(fast and .13 or .2,function() pcall(function() t:Destroy() end) end)
 end
 for i=1,#toastList do if toastList[i]==n then table.remove(toastList,i) break end end
end
function s:ClearNotifications() for i=#toastList,1,-1 do toastRemove(toastList[i],true) end end
function s:Toast(msg,kind,dur)
 msg=tostring(msg or "");kind=toastKind(kind);dur=tonumber(dur) or self.Options.ToastDuration or 3.2
 if not st.root then return end
 while #toastList>=3 do toastRemove(toastList[1],true) end
 if not st.toasth then
  st.toasth=mk("Frame",{AnchorPoint=Vector2.new(.5,1),Position=UDim2.new(.5,0,1,-18),Size=UDim2.fromOffset(self:IsMobile() and 286 or 310,190),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=90},st.root)
  mk("UIListLayout",{VerticalAlignment=Enum.VerticalAlignment.Bottom,HorizontalAlignment=Enum.HorizontalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6)},st.toasth)
 end
 st.tid+=1
 local f=mk("Frame",{LayoutOrder=st.tid,Size=UDim2.new(1,0,0,48),BackgroundColor3=self.Theme.panel2,BackgroundTransparency=.03,BorderSizePixel=0,ZIndex=90},st.toasth);cr(f,8);stx(f,self.Theme.edge,.05,1)
 local dot=mk("Frame",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.fromOffset(10,0),Size=UDim2.fromOffset(26,26),BackgroundColor3=self.Theme.panel3,BorderSizePixel=0,ZIndex=91},f);cr(dot,7);stx(dot,self.Theme.edge2,.1,1)
 local nm=kind=="success" and "check" or kind=="error" and "x" or kind=="warning" and "info" or kind=="copy" and "clipboard" or "info"
 icon(dot,nm,14,self.Theme.text)
 local body=mk("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(46,0),Size=UDim2.new(1,-56,1,0),Font=Enum.Font.GothamMedium,Text=msg,TextColor3=self.Theme.text,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=91},f)
 local track=mk("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,0),Size=UDim2.new(1,0,0,2),BackgroundColor3=self.Theme.edge2,BorderSizePixel=0,ZIndex=91},f);local fill=mk("Frame",{Size=UDim2.fromScale(1,1),BackgroundColor3=self.Theme.white,BorderSizePixel=0,ZIndex=92},track)
 local sca=mk("UIScale",{Scale=.94},f);local n={frame=f,scale=sca,bar=nil,dead=false};toastList[#toastList+1]=n
 tw(sca,.2,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
 n.bar=T:Create(fill,TweenInfo.new(math.max(.5,dur),Enum.EasingStyle.Linear),{Size=UDim2.fromScale(0,1)});n.bar:Play()
 c(f.InputBegan:Connect(function(a) if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then toastRemove(n,false) end end))
 task.delay(math.max(.55,dur),function() toastRemove(n,false) end)
 return n
end
function s:Notify(title,msg,dur,kind)
 if msg==nil then msg=title;title="suic1.de" end
 return self:Toast(msg,kind,dur)
end
function s:Success(m,d) return self:Toast(m,"success",d) end
function s:Error(m,d) return self:Toast(m,"error",d) end
function s:Warning(m,d) return self:Toast(m,"warning",d) end
function s:Info(m,d) return self:Toast(m,"info",d) end
function s:Copied(m,d) return self:Toast(m or "Copied","copy",d) end
local function sdkLoad(j)
 if st.sdk then return st.sdk end
 if st.sdkBusy then while st.sdkBusy and not st.sdk and not st.sdkErr do task.wait() end;return st.sdk end
 st.sdkBusy=true;st.sdkErr=nil
 local ok,src=pcall(game.HttpGet,game,j.url)
 if not ok or type(src)~="string" or src=="" then st.sdkErr=tostring(src or "SDK request failed");st.sdkBusy=false;return nil end
 local ok2,fn=pcall(loadstring,src)
 if not ok2 or type(fn)~="function" then st.sdkErr="SDK compile failed";st.sdkBusy=false;return nil end
 local ok3,lib=pcall(fn)
 if not ok3 or type(lib)~="table" then st.sdkErr="SDK load failed";st.sdkBusy=false;return nil end
 lib.service=j.service;lib.identifier=j.identifier;lib.provider=j.provider
 if type(lib.check_key)~="function" then st.sdkErr="SDK verifier missing";st.sdkBusy=false;return nil end
 st.sdk=lib;st.sdkBusy=false;return lib
end
local function jresult(v)
 if v==true then return true,nil end
 if type(v)~="table" then return false,tostring(v or "INVALID_RESPONSE") end
 if v.valid==true or v.success==true then return true,nil end
 local m=tostring(v.error or v.reason or v.message or "KEY_INVALID")
 if m=="KEY_VALID" or m=="KEYLESS" then return true,m end
 return false,m
end
local function jcheck(key)
 local j=st.junkie;local lib=sdkLoad(j)
 if not lib then return nil,st.sdkErr or "SDK_LOAD_FAILED" end
 local ok,res=pcall(lib.check_key,key)
 if not ok then return nil,tostring(res) end
 local good,why=jresult(res)
 if good then return true,why,res end
 return false,why,res
end
local function jlink()
 local lib=sdkLoad(st.junkie);if not lib then return nil,st.sdkErr or "SDK_LOAD_FAILED" end
 if type(lib.get_key_link)~="function" then return nil,"GET_KEY_UNAVAILABLE" end
 local ok,a,b=pcall(lib.get_key_link)
 if not ok then return nil,tostring(a) end
 if type(a)~="string" or a=="" then return nil,tostring(b or "GET_KEY_UNAVAILABLE") end
 return a,nil
end
local function errText(e)
 e=tostring(e or "KEY_INVALID")
 local m={KEY_INVALID="Invalid or expired key",INVALID_KEY="Invalid or expired key",RATE_LIMITED="Too many requests, wait a moment",HWID_BANNED="This device is blocked",SDK_LOAD_FAILED="Unable to start verification",GET_KEY_UNAVAILABLE="Key link is unavailable",NETWORK="Connection failed",ERROR="Verification failed"}
 return m[e] or e:gsub("^ERROR:%s*","")
end
local function success(key)
 st.fail=0;st.until=0;if key~="KEYLESS" then s:Save(key) end
 local cb=s.Callbacks.OnSuccess
 if type(cb)=="function" then task.spawn(function() pcall(cb,key) end) end
 s:Toast("Key accepted","success",2.1)
 task.delay(.28,function() if st.on then s:Destroy() end end)
end
local function fail(e,key)
 if e=="RATE_LIMITED" then st.until=os.clock()+4 elseif e~="HWID_BANNED" then st.fail=st.fail+1;if st.fail>=4 then st.until=os.clock()+5;st.fail=0 end end
 local k=(e=="RATE_LIMITED" and "warning") or "error"
 s:Toast(errText(e),k)
 local cb=s.Callbacks.OnFail;if type(cb)=="function" then task.spawn(function() pcall(cb,e,key) end) end
 if e=="HWID_BANNED" then task.delay(1.1,function() local p=PL.LocalPlayer;if p then pcall(function() p:Kick("Access blocked") end) end end) end
end
local function linkSpec(v,action)
 if type(v)=="table" then return tostring(v.Url or v.Link or v[1] or ""),v else return tostring(v or ""),s.LinkActions[action] or {} end
end
local function openWeb(url)
 if url=="" then return false end
 local ok,w=pcall(game.GetService,game,"WebViewService")
 if ok and w and type(w.OpenWindowV2)=="function" then return pcall(w.OpenWindowV2,w,url) end
 return false
end
local function useLink(v,action)
 local url,cfg=linkSpec(v,action)
 if url=="" then return false end
 local web=cfg.WebView==true
 local copy=cfg.Clipboard==true
 local opened=false
 if web then opened=openWeb(url) end
 if copy then clip(url) end
 return opened or copy
end
local function build()
 if st.on then s:Destroy() end
 killOld()
 s:ValidateAll()
 local v=workspace.CurrentCamera
 local mobile=s:IsMobile();local w=mobile and math.clamp((v and v.ViewportSize.X or 340)-24,292,338) or 382
 local h=286
 st.root=mk("ScreenGui",{IgnoreGuiInset=true,ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Global,DisplayOrder=2147483646},parent())
 local cam=v
 if cam then c(cam:GetPropertyChangedSignal("ViewportSize"):Connect(function() if not st.card or not st.card.Parent then return end local m=s:IsMobile();local nw=m and math.clamp(cam.ViewportSize.X-24,292,338) or 382;st.card.Size=UDim2.fromOffset(nw,h) end)) end
 blur(true)
 local back=mk("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(w+6,h+6),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=.30,BorderSizePixel=0,ZIndex=1},st.root);cr(back,12)
 local card=mk("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(w,h),BackgroundColor3=s.Theme.panel,BackgroundTransparency=.08,BorderSizePixel=0,ZIndex=2},st.root);cr(card,12);stx(card,s.Theme.edge,.02,1)
 st.card=card
 local lip=mk("Frame",{Position=UDim2.fromOffset(1,1),Size=UDim2.new(1,-2,0,1),BackgroundColor3=s.Theme.white,BackgroundTransparency=.78,BorderSizePixel=0,ZIndex=4},card)
 local inner=mk("Frame",{Position=UDim2.fromOffset(12,12),Size=UDim2.new(1,-24,1,-24),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=4},card)
 local brand=mk("TextLabel",{BackgroundTransparency=1,Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,0,18),Font=Enum.Font.GothamBold,Text="suic1.de",TextColor3=s.Theme.text,TextSize=11,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=5},inner)
 local bline=mk("Frame",{AnchorPoint=Vector2.new(.5,0),Position=UDim2.new(.5,0,0,24),Size=UDim2.fromOffset(38,1),BackgroundColor3=s.Theme.edge,BackgroundTransparency=.25,BorderSizePixel=0,ZIndex=5},inner)
 local title=mk("TextLabel",{BackgroundTransparency=1,Position=UDim2.new(0,0,0,40),Size=UDim2.new(1,0,0,27),Font=Enum.Font.GothamBold,Text=tostring(s.Appearance.Title or "suic1.de"),TextColor3=s.Theme.text,TextSize=21,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=5},inner)
 local sub=mk("TextLabel",{BackgroundTransparency=1,Position=UDim2.new(0,0,0,67),Size=UDim2.new(1,0,0,18),Font=Enum.Font.Gotham,Text=tostring(s.Appearance.Subtitle or "Enter your key"),TextColor3=s.Theme.sub,TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=5},inner)
 local field=mk("Frame",{Position=UDim2.new(0,18,0,98),Size=UDim2.new(1,-36,0,48),BackgroundColor3=s.Theme.panel2,BackgroundTransparency=.05,BorderSizePixel=0,ZIndex=5},inner);cr(field,9);local fs=stx(field,s.Theme.edge2,.02,1)
 local ki=mk("Frame",{Position=UDim2.fromOffset(1,1),Size=UDim2.new(0,42,1,-2),BackgroundColor3=s.Theme.panel3,BackgroundTransparency=.05,BorderSizePixel=0,ZIndex=6},field);cr(ki,8);icon(ki,"key",16,s.Theme.sub)
 local inp=mk("TextBox",{BackgroundTransparency=1,Position=UDim2.fromOffset(46,0),Size=UDim2.new(1,-112,1,0),ClearTextOnFocus=false,Font=Enum.Font.Code,Text="",PlaceholderText="",TextColor3=s.Theme.text,TextSize=13,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=6},field);st.input=inp
 local clear=mk("TextButton",{BackgroundTransparency=1,Position=UDim2.new(1,-37,0,0),Size=UDim2.fromOffset(34,48),AutoButtonColor=false,Text="×",TextColor3=s.Theme.muted,TextSize=18,Font=Enum.Font.Gotham,ZIndex=7},field)
 local paste=mk("TextButton",{BackgroundTransparency=1,Position=UDim2.new(1,-70,0,0),Size=UDim2.fromOffset(30,48),AutoButtonColor=false,Text="",ZIndex=7},field);icon(paste,"clipboard",13,s.Theme.muted)
 c(clear.MouseButton1Click:Connect(function() inp.Text="";inp:CaptureFocus() end))
 c(paste.MouseButton1Click:Connect(function()
  local f=getclipboard or fromclipboard or get_clipboard
  if type(f)=="function" then local ok,v=pcall(f);if ok and v then inp.Text=s:NormalizeKey(v);inp:CaptureFocus();s:Copied("Key pasted") else s:Warning("Clipboard unavailable") end else s:Warning("Clipboard unavailable") end
 end))
 c(inp.Focused:Connect(function() tw(fs,.13,{Color=s.Theme.white,Transparency=.05});tw(ki,.13,{BackgroundColor3=s.Theme.panel3}) end))
 c(inp.FocusLost:Connect(function() tw(fs,.13,{Color=s.Theme.edge2,Transparency=.02}) end))
 local vb=mk("TextButton",{Position=UDim2.new(0,18,0,156),Size=UDim2.new(1,-36,0,40),BackgroundColor3=s.Theme.white,BorderSizePixel=0,AutoButtonColor=false,Text="",ZIndex=5},inner);cr(vb,9);local vs=stx(vb,Color3.fromRGB(0,0,0),.82,1)
 local vi=mk("ImageLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(.5,-38,.5,0),Size=UDim2.fromOffset(15,15),BackgroundTransparency=1,Image=ia("shield"),ImageColor3=Color3.fromRGB(0,0,0),ScaleType=Enum.ScaleType.Fit,ZIndex=6},vb)
 local vt=mk("TextLabel",{BackgroundTransparency=1,Position=UDim2.new(.5,-23,0,0),Size=UDim2.fromOffset(80,40),Font=Enum.Font.GothamBold,Text="Verify",TextColor3=Color3.fromRGB(0,0,0),TextSize=12,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=6},vb);st.verify=vb
 local acts=mk("Frame",{Position=UDim2.new(0,18,0,208),Size=UDim2.new(1,-36,0,38),BackgroundTransparency=1,ZIndex=5},inner)
 local gl,dc,buy
 gl=mk("TextButton",{Position=UDim2.fromOffset(0,0),Size=UDim2.new(.5,-4,1,0),BackgroundColor3=s.Theme.panel2,BackgroundTransparency=.03,BorderSizePixel=0,AutoButtonColor=false,Text="",ZIndex=6},acts);cr(gl,8);stx(gl,s.Theme.edge2,.06,1)
 dc=mk("TextButton",{Position=UDim2.new(.5,4,0,0),Size=UDim2.new(.5,-4,1,0),BackgroundColor3=s.Theme.panel2,BackgroundTransparency=.03,BorderSizePixel=0,AutoButtonColor=false,Text="",ZIndex=6},acts);cr(dc,8);stx(dc,s.Theme.edge2,.06,1)
 local function actionButton(b,kind,text,custom)
  local ii=mk("Frame",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,9,.5,0),Size=UDim2.fromOffset(22,22),BackgroundColor3=s.Theme.panel3,BorderSizePixel=0,ZIndex=7},b);cr(ii,6)
  if custom and tostring(custom)~="" then
   mk("ImageLabel",{BackgroundTransparency=1,AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(12,12),Image=tostring(custom),ImageColor3=s.Theme.sub,ScaleType=Enum.ScaleType.Fit,ZIndex=8},ii)
  else icon(ii,kind,12,s.Theme.sub) end
  mk("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(37,0),Size=UDim2.new(1,-44,1,0),Font=Enum.Font.GothamMedium,Text=text,TextColor3=s.Theme.text,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,ZIndex=7},b)
 end
 actionButton(gl,"link",type(s.Links.GetKey)=="table" and tostring(s.Links.GetKey.Text or "Get key") or "Get key",type(s.Links.GetKey)=="table" and s.Links.GetKey.Icon or nil);actionButton(dc,"discord",type(s.Links.Discord)=="table" and tostring(s.Links.Discord.Text or "Discord") or "Discord",type(s.Links.Discord)=="table" and s.Links.Discord.Icon or nil)
 gl.Visible=tostring((type(s.Links.GetKey)=="table" and (s.Links.GetKey.Url or s.Links.GetKey.Link or s.Links.GetKey[1]) or s.Links.GetKey) or "")~=""
 dc.Visible=tostring((type(s.Links.Discord)=="table" and (s.Links.Discord.Url or s.Links.Discord.Link or s.Links.Discord[1]) or s.Links.Discord) or "")~=""
 if s.Shop.Enabled and tostring(s.Shop.Link or "")~="" then
  buy=mk("TextButton",{Position=UDim2.new(0,0,0,0),Size=UDim2.new(.5,-4,1,0),BackgroundColor3=s.Theme.panel2,BackgroundTransparency=.03,BorderSizePixel=0,AutoButtonColor=false,Text="",ZIndex=6},acts);cr(buy,8);stx(buy,s.Theme.edge2,.06,1);actionButton(buy,"link",s.Shop.ButtonText~="" and s.Shop.ButtonText or "Buy",s.Shop.Icon)
  if gl.Visible then gl.Position=UDim2.new(0,0,0,0);gl.Size=UDim2.new(.333,-5,1,0);dc.Position=UDim2.new(.333,3,0,0);dc.Size=UDim2.new(.333,-5,1,0);buy.Position=UDim2.new(.666,3,0,0);buy.Size=UDim2.new(.334,-3,1,0) elseif dc.Visible then dc.Position=UDim2.new(0,0,0,0);dc.Size=UDim2.new(.5,-4,1,0);buy.Position=UDim2.new(.5,4,0,0);buy.Size=UDim2.new(.5,-4,1,0) end
 else buy=nil end
 if not gl.Visible and not dc.Visible and not buy then acts.Visible=false end
 st.get=gl;st.disc=dc;st.buy=buy
 local close=mk("TextButton",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-10,0,10),Size=UDim2.fromOffset(28,28),BackgroundColor3=s.Theme.panel2,BackgroundTransparency=.04,BorderSizePixel=0,AutoButtonColor=false,Text="",ZIndex=7},inner);cr(close,8);stx(close,s.Theme.edge2,.10,1);icon(close,"x",13,s.Theme.sub);st.close=close
 local busy=false;local spin=nil
 local function busyOn(a)
  busy=a;vb.Active=not a;vb.AutoButtonColor=false
  if a then vt.Text="Checking";vi.Image=ia("loader");if spin then pcall(function() spin:Cancel() end) end;spin=T:Create(vi,TweenInfo.new(.8,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,-1),{Rotation=360});spin:Play()
  else vt.Text="Verify";vi.Rotation=0;vi.Image=ia("shield");if spin then pcall(function() spin:Cancel() end);spin=nil end end
 end
 local function verify(value)
  if st.busy then return end
  if os.clock()<st.until then s:Toast(s:GetCooldownText(),"warning");return end
  value=s:NormalizeKey(value)
  if value=="" then s:Toast("Enter your key","error");return end
  st.busy=true;busyOn(true)
  local valid,reason
  if st.junkie then valid,reason=jcheck(value) else
   local cb=s.Callbacks.OnVerify
   if type(cb)~="function" then valid=false;reason="VERIFIER_MISSING" else local ok,res=pcall(cb,value);if not ok then valid=false;reason="ERROR" else valid,reason=jresult(res) end end
  end
  busyOn(false);st.busy=false
  if valid then success(value) else fail(reason or "KEY_INVALID",value) end
 end
 c(vb.MouseButton1Click:Connect(function() verify(inp.Text) end))
 c(inp.FocusLost:Connect(function(e) if e then verify(inp.Text) end end))
 c(close.MouseButton1Click:Connect(function() s:Destroy() end))
 c(gl.MouseButton1Click:Connect(function()
  if not gl.Visible then return end
  if type(s.Links.GetKey)=="string" and s.Links.GetKey=="" and st.junkie then task.spawn(function() local l,e=jlink();if l then useLink(l,"GetKey") else s:Error(errText(e)) end end) else useLink(s.Links.GetKey,"GetKey") end
 end))
 c(dc.MouseButton1Click:Connect(function() if dc.Visible then useLink(s.Links.Discord,"Discord") end end))
 if buy then c(buy.MouseButton1Click:Connect(function() useLink(s.Shop.Link,"Buy") end)) end
 if s.Options.Draggable then
  local drag=false,sp,si
  c(card.InputBegan:Connect(function(a) if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then local p=a.Position;if a.Position.Y-(card.AbsolutePosition.Y) < 95 then drag=true;si=p;sp=card.Position end end end))
  c(card.InputEnded:Connect(function(a) if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then drag=false end end))
  c(U.InputChanged:Connect(function(a) if drag and (a.UserInputType==Enum.UserInputType.MouseMovement or a.UserInputType==Enum.UserInputType.Touch) then local d=a.Position-si;card.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end))
 end
 st.on=true
 task.defer(function() if st.root and st.root.Parent then loadIcons() end end)
 return st.root
end
function s:Destroy()
 if st.closing then return end
 st.closing=true;st.on=false;st.busy=false
 self:ClearNotifications()
 for i=#con,1,-1 do local x=con[i];pcall(function() x:Disconnect() end);con[i]=nil end
 for i=#objs,1,-1 do local x=objs[i];pcall(function() if x and x.Parent then x:Destroy() end end);objs[i]=nil end
 if st.root then pcall(function() st.root:Destroy() end) end
 st.root=nil;st.card=nil;st.input=nil;st.verify=nil;st.close=nil;st.get=nil;st.disc=nil;st.buy=nil;st.toasth=nil;st.sdk=nil;st.tid=0;st.sdkErr=nil;st.sdkBusy=false;st.junkie=nil
 blur(false)
 st.closing=false
end
function s:Verify(v)
 if st.input then st.input.Text=self:NormalizeKey(v);local ok=pcall(function() st.input:CaptureFocus() end);if ok then task.defer(function() if st.input then st.input:ReleaseFocus(true) end end) end;return end
 if st.junkie then local good,e=jcheck(self:NormalizeKey(v));if good then success(self:NormalizeKey(v)) else fail(e,v) end else local cb=self.Callbacks.OnVerify;if type(cb)=="function" then local ok,r=pcall(cb,self:NormalizeKey(v));local good,e=jresult(r);if ok and good then success(self:NormalizeKey(v)) else fail(ok and e or "ERROR",v) end end end
end
function s:OpenLink(v)
 v=tostring(v or "");if v=="" then return false end
 local ok,w=pcall(game.GetService,game,"WebViewService");if ok and w then local a,b=pcall(w.OpenWindowV2,w,v);if a then return true end end
 return clip(v)
end
function s:Copy(v) return clip(v) end
function s:GetLink(n) if tostring(n)=="Shop" then return tostring(self.Shop.Link or "") end;return tostring(self.Links[tostring(n)] or "") end
function s:HasLink(n) return self:GetLink(n)~="" end
function s:CopyLink(n) local l=self:GetLink(n);return l~="" and clip(l) or false end
function s:OpenGetKey() return self:OpenLink(self:GetLink("GetKey")) end
function s:OpenDiscord() return self:CopyLink("Discord") end
function s:OpenShop() return self:OpenLink(self:GetLink("Shop")) end
function s:SetTheme(v) if type(v)~="table" then return false end;for a,b in pairs(v) do if self.Theme[a] and typeof(b)=="Color3" then self.Theme[a]=b end end;return true end
function s:GetTheme() return self.Theme end
function s:SetAppearance(v) if type(v)~="table" then return end;for a,b in pairs(v) do if self.Appearance[a]~=nil then self.Appearance[a]=b end end end
function s:SetLinks(v) if type(v)~="table" then return end;for a,b in pairs(v) do if self.Links[a]~=nil then self.Links[a]=b end end end
function s:SetLinkActions(v) if type(v)~="table" then return end;for a,b in pairs(v) do if self.LinkActions[a]~=nil and type(b)=="table" then self.LinkActions[a].Clipboard=b.Clipboard==true;self.LinkActions[a].WebView=b.WebView==true end end end
function s:SetStorage(v) if type(v)~="table" then return end;for a,b in pairs(v) do if self.Storage[a]~=nil then self.Storage[a]=b end end end
function s:SetOptions(v) if type(v)~="table" then return end;for a,b in pairs(v) do if self.Options[a]~=nil then self.Options[a]=b end end end
function s:SetShop(v) if type(v)~="table" then return end;for a,b in pairs(v) do if self.Shop[a]~=nil then self.Shop[a]=b end end end
function s:SetCallbacks(v) if type(v)~="table" then return end;for a,b in pairs(v) do if self.Callbacks[a]~=nil and (b=="" or type(b)=="function") then self.Callbacks[a]=b end end end
function s:SetDraggable(v) self.Options.Draggable=v==true end
function s:SetIntro(v) self.Options.Intro=false end
function s:SetToastDuration(v) self.Options.ToastDuration=math.max(.6,tonumber(v) or 3.2) end
function s:SetKeyless(v,show) self.Options.Keyless=v;if show~=nil then self.Options.KeylessUi=show==true end end
function s:GetState() if not st.on then return "Closed" elseif st.busy then return "Checking" elseif self.Options.Keyless==true then return "Keyless" elseif os.clock()<st.until then return "Cooldown" end return "Idle" end
function s:CanVerify() return st.on and not st.busy and os.clock()>=st.until end
function s:Forget() return self:ClearSavedKey() end
function s:Lock() self:Destroy();return true end
function s:IsLocked() return not st.on end
function s:GetEnvironment() return {mobile=self:IsMobile(),touch=U.TouchEnabled,keyboard=U.KeyboardEnabled,clipboard=self:CheckClipboard(),webview=self:CheckWebView(),http=self:CheckHttp(),loadstring=self:CheckLoadstring()} end
function s:HealthCheck() local a=self:Compatibility();local v=type(Instance)=="table" or type(Instance)=="userdata";local verify=(st.junkie and true) or type(self.Callbacks.OnVerify)=="function" or self.Options.Keyless==true;return v and verify,{UI=v,Verification=verify,Compatibility=a} end
function s:Validate()
 local e={};if type(self.Appearance)~="table" then e[#e+1]="Appearance" end;if type(self.Links)~="table" then e[#e+1]="Links" end;if type(self.Storage)~="table" then e[#e+1]="Storage" end;if type(self.Options)~="table" then e[#e+1]="Options" end;if type(self.Callbacks)~="table" then e[#e+1]="Callbacks" end;return #e==0,e
end
function s:ValidateOptions()
 local e={};self.Options.Intro=false;self.Options.ToastDuration=math.max(.6,tonumber(self.Options.ToastDuration) or 3.2);if self.Options.Keyless~="" and self.Options.Keyless~=nil and type(self.Options.Keyless)~="boolean" then self.Options.Keyless=nil;e[#e+1]="Keyless" end;for _,k in ipairs({"KeylessUi","Draggable","Blur"}) do if type(self.Options[k])~="boolean" then self.Options[k]=true;e[#e+1]=k end end;return #e==0,e
end
function s:ValidateCallbacks()
 local e={};for k,v in pairs(self.Callbacks) do if v~="" and v~=nil and type(v)~="function" then e[#e+1]=k end end;return #e==0,e
end
function s:ValidateAll() local a,x=self:Validate();local b,y=self:ValidateOptions();local d,z=self:ValidateCallbacks();local r={};for _,v in ipairs(x) do r[#r+1]=v end;for _,v in ipairs(y) do r[#r+1]=v end;for _,v in ipairs(z) do r[#r+1]=v end;return a and b and d,r end
function s:GetDefaults() local function cp(v) if type(v)~="table" then return v end;local n={};for a,b in pairs(v) do n[a]=cp(b) end;return n end;return cp(self.Defaults) end
function s:Reset() local d=self:GetDefaults();self.Appearance=d.Appearance;self.Links=d.Links;self.LinkActions=d.LinkActions;self.Storage=d.Storage;self.Options=d.Options;self.Shop=d.Shop;self:ResetFailures();return true end
function s:SetColor(k,v) if self.Theme[k] and typeof(v)=="Color3" then self.Theme[k]=v;return true end return false end
function s:GetColor(k) return self.Theme[k] end
function s:UseJunkie(a,b,d,e) return self:LaunchJunkie({Service=a,Identifier=b,Provider=d,Url=e}) end
function s:LaunchJunkie(cfg)
 cfg=type(cfg)=="table" and cfg or {}
 local service=tostring(cfg.Service or cfg.service or "")
 local identifier=tostring(cfg.Identifier or cfg.identifier or "")
 local provider=tostring(cfg.Provider or cfg.provider or "Mixed")
 local url=tostring(cfg.Url or cfg.URL or "")
 if service=="" or identifier=="" then self:Toast("Service or identifier is missing","error");return false end
 if url=="" then self:Toast("Set the JNKIE SDK URL","error");return false end
 st.junkie={service=service,identifier=identifier,provider=provider,url=url}
 self:ValidateAll()
 local root=build()
 task.spawn(function()
  local lib=sdkLoad(st.junkie)
  if not lib then self:Toast(errText(st.sdkErr),"error");return end
  if self.Options.Keyless==nil then
   local ok,why,res=jcheck("KEYLESS")
   if ok and why=="KEYLESS" then
    if self.Options.KeylessUi then
     if st.input then st.input.Visible=false end
     if st.verify then st.verify.Visible=false end
     if st.get then st.get.Visible=false end
     if st.disc then st.disc.Visible=tostring(self.Links.Discord or "")~="" end
     success("KEYLESS")
    else success("KEYLESS") end
    return
   end
  elseif self.Options.Keyless==true then
   success("KEYLESS");return
  end
  local saved=self:GetSavedKey()
  if self.Storage.AutoLoad and saved and saved~="" then
   local ok,why=jcheck(saved)
   if ok then success(saved);return end
   self:ClearSavedKey()
  end
  local ready=self.Callbacks.OnReady;if type(ready)=="function" then task.spawn(function() pcall(ready) end) end
 end)
 return root
end
function s:Launch()
 if self.Options.Keyless==true then local root=build();task.spawn(function() success("KEYLESS") end);return root end
 if type(self.Callbacks.OnVerify)~="function" then self:Toast("Set OnVerify or use LaunchJunkie","error");return false end
 st.junkie=nil;return build()
end
s.IconUrls={Lucide=ICON_L,Solar=ICON_S}
s.IconPacks=packs
s.GetIcon=function(_,n)return ia(n) end
loadIcons()
return s
