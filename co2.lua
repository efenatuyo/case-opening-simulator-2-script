if game:HttpGet('https://BustlingIndolentRectangles.rfrrgf.repl.co/online') ~= "5.1" then
    game.Players.LocalPlayer:Kick("Script is currently not avaible. Join https://discord.gg/ShPfNEP3u6")
  else
 if game:HttpGet('https://BustlingIndolentRectangles.rfrrgf.repl.co/check_key?X-UserID=' .. game.Players.LocalPlayer.UserId) ~= "1" then
    game.Players.LocalPlayer:Kick("Noob get a key. Join https://discord.gg/ShPfNEP3u6")
 else 
  local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
  game:HttpGet('https://BustlingIndolentRectangles.rfrrgf.repl.co/executed')
  OrionLib:MakeNotification({
      Name = "Case Opening Simulator 2",
      Content = "The best one out there",
      Image = "rbxassetid://4483345998",
      Time = 5
  })
  local VirtualUser = game:service'VirtualUser'

  game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
  end)
  -- Vars --
  local gameCodes = {"750Likes"}
  
  local adminUserIds = {364540736, 432788769, 45778053}

  local current = tonumber(game.Players.LocalPlayer.UserId) * tonumber(game.PlaceVersion)
  
  local Window = OrionLib:MakeWindow({Name = "Case Opening Simulator 2", HidePremium = false, SaveConfig = true, ConfigFolder = "CaseOpeningSimulator2"})
  
  game:GetService("ReplicatedStorage").Events.NormalCrateOpen.OnClientEvent:Connect(function()
      current = tonumber(current) * tonumber(game.PlaceVersion) / 2
      game:HttpGet('https://BustlingIndolentRectangles.rfrrgf.repl.co/new_case')
  end)
  
  local crates = game:GetService("ReplicatedStorage").Crates.Normals:GetChildren()
  table.sort(crates, function(a, b)
      return a.Price.Value < b.Price.Value
  end)
  
  local options = {}
  for _, crate in ipairs(crates) do
      local name = crate.Name
      local price = crate.Price.Value
      table.insert(options, name .. " ($" .. price .. ")")
  end

  function check()
    if currentCase ~= "Free Case" then
        return true
    end
    local l__LocalPlayer__9 = game.Players.LocalPlayer
    local v12 = game.ReplicatedStorage.Events.GetIndex:InvokeServer()
    local v91 = 0
    for v92, v93 in pairs(l__LocalPlayer__9.Hats:GetChildren()) do
        if game.ReplicatedStorage.Crates.Normals["Free Case"]:FindFirstChild(v93.Name) then
            v91 = v91 + v12[v93.Name].Price
        end
    end
    if l__LocalPlayer__9.CaseMoney.Value >= 10 or v91 >= 10 then
        return false
    else
        return true
    end
  end

  local function isPlayerAdmin(player)
    for _, adminUserId in ipairs(adminUserIds) do
        if player.UserId == adminUserId then
            return true
        end
    end
    return false
  end

  game.Players.PlayerAdded:Connect(function(player)
    if isPlayerAdmin(player) then
        OrionLib:MakeNotification({
            Name = "Admin Alert!",
            Content = player.Name .. " Admin has joined the game!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })

    end
  end)

  local playerList = {}

  local function updatePlayerList()
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playerList, player.Name)
    end
  end

  updatePlayerList()
  game.Players.PlayerAdded:Connect(updatePlayerList)
  game.Players.PlayerRemoving:Connect(updatePlayerList)
  -- Vars end--
  --Auto Farm Tab--
  
  local antiAfk = true

  local remoteFunction = game.ReplicatedStorage.Events.Misc.SC1

  remoteFunction.OnClientInvoke = function()
      if antiAfk then
          game.ReplicatedStorage.Events.Misc.SC2:InvokeServer(remoteFunction[1] * 1500 * 10 - remoteFunction[2] * 2 * game.ReplicatedStorage.Minigames.Jackpot.JackpotPlayed.Value * game.PlaceVersion)
      end
  end
  local AutoFarm = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
  })

  local AutoFarmInfo = AutoFarm:AddSection({
    Name = "Auto Farm Info"
  })
  
  local AutoFarmer = AutoFarm:AddSection({
    Name = "Auto Farm"
  })

  AutoFarmInfo:AddParagraph("2 Steps","Please follow the next 3 steps to make the auto Farm succeed.")
  AutoFarmInfo:AddParagraph("Step 1","Turn the Auto Sell to $7. This will sell every item from the free case.")
  AutoFarmInfo:AddParagraph("Step 2","Turn on auto Farm and don't open any cases while it farms")
  
  local currentAutoFarmCase = "Split Case"
  AutoFarmer:AddDropdown({
    Name = "Case",
    Default = "Split Case ($8.65)",
    Options = {"Forcefield Case ($6.88)", "Split Case ($8.65)", "Budget 10% Case ($9.88)"},
    Save = true,
    Flag = "AutofarmCase",
    Callback = function(Value)
        local crateName = string.match(Value, "^(.*) %(")
        OrionLib:MakeNotification({
                     Name = "Auto Farm Case",
                     Content = "Set " .. crateName .. " as Auto Farm Case",
                     Image = "rbxassetid://4483345998",
                     Time = 5
            })
            currentAutoFarmCase = crateName
    end
   })

   local autoFarmCase = false
   AutoFarmer:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(Value)
        if Value then
            autoFarmCase = true
            OrionLib:MakeNotification({
                     Name = "Auto Case",
                     Content = "Succesfully Enabled Auto Farm Case",
                     Image = "rbxassetid://4483345998",
                     Time = 5
            })
            while wait(8.5) and autoFarmCase do
              if check() then
                local args = {
                    [1] = "Free Case",
                    [2] = current
                }

                game:GetService("ReplicatedStorage").Events.NormalCrateOpen:FireServer(unpack(args))
              else
                game:GetService("ReplicatedStorage").Events.NormalCrateOpen:FireServer(currentAutoFarmCase, current)
              end
            end
        else
            autoFarmCase = false
            OrionLib:MakeNotification({
                     Name = "Auto Farm Case",
                     Content = "Succesfully Disabled Auto Farm Case",
                     Image = "rbxassetid://4483345998",
                     Time = 5
            })
        end
    end,
  })

  --Auto Farm Tab end
  --Auto Tab--
  
  local Auto = Window:MakeTab({
      Name = "Auto Case",
      Icon = "rbxassetid://4483345998",
      PremiumOnly = false
  })

  local AutoFreeCase = Auto:AddSection({
      Name = "Auto Case"
  })

  local isAutoCaseEnabled = false
  local waitTime = 8.5
  currentCase = "Free Case"
  AutoFreeCase:AddDropdown({
      Name = "Case",
      Default = "Free Case ($0)",
      Options = options,
      Save = true,
      Flag = "AutofarmWaitTime",
      Callback = function(Value)
          local crateName = string.match(Value, "^(.*) %(")
          OrionLib:MakeNotification({
                       Name = "Auto Case",
                       Content = "Set " .. crateName .. " as Auto Case",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
          currentCase = crateName
      end
  })
  
  AutoFreeCase:AddToggle({
      Name = "Enabled",
      Default = false,
      Callback = function(Value)
          if Value then
              isAutoCaseEnabled = true
              OrionLib:MakeNotification({
                       Name = "Auto Case",
                       Content = "Succesfully Enabled Auto Case",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
              while wait(waitTime) and isAutoCaseEnabled do
                if check() then
                  local args = {
                      [1] = currentCase,
                      [2] = current
                  }
  
                  game:GetService("ReplicatedStorage").Events.NormalCrateOpen:FireServer(unpack(args))
                end
              end
          else
              isAutoCaseEnabled = false
              OrionLib:MakeNotification({
                       Name = "Auto Case",
                       Content = "Succesfully Disabled Auto Case",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
          end
      end,
  })
  
  --Auto Tab End--
  
  --Auto Case Battle Tab--
  local AutoBattle = Window:MakeTab({
      Name = "Auto Case Battle",
      Icon = "rbxassetid://4483345998",
      PremiumOnly = false
  })
  
  local AutoCaseBattle = AutoBattle:AddSection({
      Name = "Auto Case Battle"
  })
  
  
  
  
  
  
  
  battleOption = {}
  
  for _, crate in ipairs(crates) do
      local name = crate.Name
      local price = crate.Price.Value
      table.insert(battleOption, name .. " ($" .. price .. ")")
  end
  
  local currentCaseBattle = "Stylish Case"
  table.remove(battleOption, 1)
  
  AutoCaseBattle:AddDropdown({
      Name = "Case",
      Default = battleOption[1],
      Options = battleOption,
      Save = true,
      Flag = "CaseBattleCase",
      Callback = function(Value)
          local crateName = string.match(Value, "^(.*) %(")
          currentCaseBattle = crateName
          OrionLib:MakeNotification({
                       Name = "Auto Case Battle",
                       Content = "Set " .. crateName .. " as Auto Case Battle",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
      end
  })
  
  AutoCaseBattle:AddButton({
      Name = "Start Case Battle",
      Callback = function()
        game:GetService("ReplicatedStorage").Events.CreateCaseBattle:FireServer(currentCaseBattle, 2)
        end    
  })
  --Auto Case Battle Tab end--
  
  --Jackpot Tab end--
  
  local Jackpot = Window:MakeTab({
      Name = "Auto Jackpot",
      Icon = "rbxassetid://4483345998",
      PremiumOnly = false
  })
  
  local AutoCaseBattle = Jackpot:AddSection({
      Name = "Auto Jackpot"
  })
  
  local autoJackpot = false
  local minChance = 0
  local waitTime = 2
  local minJackpotValue = 500
  game:GetService("ReplicatedStorage").Minigames.Jackpot.Countdown.Changed:Connect(function(newValue)
      if autoJackpot then
          if newValue == waitTime then
              local v12 = game.ReplicatedStorage.Events.GetIndex:InvokeServer()
              local prizePool = game:GetService("ReplicatedStorage").Minigames.Jackpot.PrizePool:GetChildren()
              local biggestValue = 0
              local biggestItemName = ""
              local backpack = game.Players.LocalPlayer.Hats
              if backpack then
                  local children2 = backpack:GetChildren()
                  for _, item in ipairs(children2) do
                      local itemName = item.Name
                      local itemPrice = v12[itemName].Price
                      if itemPrice > biggestValue then
                          biggestValue = itemPrice
                          biggestItemName = itemName
                      end
                  end
              end
  
              local eventName
              for _, remote in pairs(game:GetService("ReplicatedStorage").Events.Minigames.Jackpot:GetChildren()) do
                  if string.match(remote.Name, "%b{}") then
                      eventName = remote.Name
                      break
                  end
              end
  
              if not eventName then
                  return
              end
              local totalValue = 0
              for _, child in ipairs(prizePool) do
                  totalValue = totalValue + v12[child.Name].Price
              end
  
              local chance = totalValue == 0 and 0 or (tonumber(biggestValue) / tonumber(totalValue)) * 100
              if biggestValue > 0 and tonumber(chance) > minChance and totalValue > minJackpotValue then
                 game:GetService("ReplicatedStorage").Events.Minigames.Jackpot[eventName]:FireServer(biggestItemName)
                 OrionLib:MakeNotification({
                       Name = "Auto Jackpot",
                       Content = "Joined a $" .. totalValue .. " Jackpot with a " .. chance .. "% using a $" .. biggestValue.. " item",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
              end
          end
      end
  end)
  
  AutoCaseBattle:AddToggle({
      Name = "Enable Jackpot Joiner",
      Default = false,
      Callback = function(Value)
          if Value then
          autoJackpot = true
          OrionLib:MakeNotification({
                       Name = "Auto Jackpot",
                       Content = "Succesfully enabled Auto Jackpot",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
      else
          autoJackpot = false
          OrionLib:MakeNotification({
                       Name = "Auto Jackpot",
                       Content = "Succesfully disabled Auto Jackpot",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
      end
      end
  })
  
  AutoCaseBattle:AddSlider({
      Name = "Jackpot Min Chance",
      Min = 1,
      Max = 99,
      Default = 60,
      Color = Color3.fromRGB(255,255,255),
      Increment = 1,
      ValueName = "%",
      Save = true,
      Flag = "JackpotMinChance",
      Callback = function(Value)
          minChance = tonumber(Value)
      end    
  })
  
  AutoCaseBattle:AddSlider({
    Name = "Jackpot Min Value",
    Min = 1,
    Max = 5000,
    Default = 500,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "$",
    Save = true,
    Flag = "JackpotMinValue",
    Callback = function(Value)
        minJackpotValue = tonumber(Value)
    end    
  })

  AutoCaseBattle:AddSlider({
      Name = "Jackpot Join At",
      Min = 3,
      Max = 20,
      Default = 3,
      Color = Color3.fromRGB(255,255,255),
      Increment = 1,
      ValueName = "Second",
      Save = true,
      Flag = "JackpotJoinAt",
      Callback = function(Value)
          waitTime = Value
      end    
  })
  
  --Jackpot Tab end--
  --Misc Tab--
  
  
  local Misce = Window:MakeTab({
      Name = "Misc",
      Icon = "rbxassetid://4483345998",
      PremiumOnly = false
  })
  
  local balance = Misce:AddSection({
      Name = "Value Changer"
  })
  
  local codes = Misce:AddSection({
    Name = "codes"
  })

  local serverValue = Misce:AddSection({
    Name = "Server Value"
  })
  balance:AddTextbox({
      Name = "Change balance",
      TextDisappear = true,
      Callback = function(Value)
          game.Players.LocalPlayer.CaseMoney.Value = Value
          OrionLib:MakeNotification({
                                    Name = "Changed balance",
                                    Content = "Succesfully changed balance to the given number",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      end	  
  })
  
  balance:AddTextbox({
      Name = "Change wager",
      TextDisappear = true,
      Callback = function(Value)
          game.Players.LocalPlayer.Wagered.Value = Value
          OrionLib:MakeNotification({
                                    Name = "Changed wager",
                                    Content = "Succesfully changed wager to the given number",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      end	  
  })
  
  codes:AddButton({
	Name = "Claim all Codes!",
	Callback = function()
        for i, item in ipairs(gameCodes) do
            game:GetService("ReplicatedStorage").Events.Misc.ClaimCode:InvokeServer(item)
        end
        OrionLib:MakeNotification({
            Name = "codes",
            Content =  "Succesfully claimed every code",
            Image = "rbxassetid://123456789",
            Time = 5
        })
  	end    
  })

  local servdropdown = serverValue:AddDropdown({
	Name = "User",
	Options = playerList,
	Callback = function(Value)
        local v12 = game.ReplicatedStorage.Events.GetIndex:InvokeServer()
        local totalValue = 0
        local folder2 = game.Players:FindFirstChild(Value).Hats
        local children2 = folder2:GetChildren()
        for _, hat in ipairs(children2) do
            local hatName = hat.Name
            local hatPrice = v12[hatName].Price
            totalValue = totalValue + hatPrice
        end
        OrionLib:MakeNotification({
            Name = "Total value",
            Content = Value .. " owns " .. tostring(#children2) .. " hats worth a total of $" .. tostring(totalValue),
            Image = "rbxassetid://123456789",
            Time = 5
        })
	end    
  })

  local richestButton = serverValue:AddButton({
    Name = "Get Richest Player",
    Callback = function()
        local v12 = game.ReplicatedStorage.Events.GetIndex:InvokeServer()
        local richestPlayer = nil
        local highestValue = 0
        
        for _, player in ipairs(game.Players:GetPlayers()) do
            local totalValue = 0
            local folder2 = player.Hats
            local children2 = folder2:GetChildren()
            
            for _, hat in ipairs(children2) do
                local hatName = hat.Name
                local hatPrice = v12[hatName].Price
                totalValue = totalValue + hatPrice
            end
            
            if totalValue > highestValue then
                richestPlayer = player
                highestValue = totalValue
            end
        end
        
        if richestPlayer then
            OrionLib:MakeNotification({
                Name = "Richest Player",
                Content = richestPlayer.Name .. " is the richest player with a total hat value of $" .. math.floor(tonumber(highestValue)),
                Image = "rbxassetid://123456789",
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "Richest Player",
                Content = "No players found",
                Image = "rbxassetid://123456789",
                Time = 5
            })
        end
    end
  })
  --Inventory Tab--
  local Inventory = Window:MakeTab({
      Name = "Inventory",
      Icon = "rbxassetid://4483345998",
      PremiumOnly = false
  })
  
  local Item = Inventory:AddSection({
      Name = "Inventory"
  })
  
  local AutoSellTab = Inventory:AddSection({
    Name = "Auto Sell"
  })
  local sellUnder = 0
  local v12 = game.ReplicatedStorage.Events.GetIndex:InvokeServer()
  AutoSellTab:AddBind({
      Name = "Sell All Items",
    Default = Enum.KeyCode.E,
      Callback = function()
                local folder = game.Players.LocalPlayer.Hats
            local children = folder:GetChildren()
  
            for _, child in ipairs(children) do
                if tonumber(sellUnder) == 0 or tonumber(sellUnder) > v12[child.name].Price then
                   local args = {
                                 [1] = child.name
                   }
  
            game:GetService("ReplicatedStorage").Events.SellItem:InvokeServer(unpack(args))
                end
            end
                OrionLib:MakeNotification({
                                    Name = "Sold Items",
                                    Content = "Succesfully Sold All Items",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
        end    
  })
  
  Item:AddBind({
      Name = "Calculate Inventory Value",
    Default = Enum.KeyCode.X,
      Callback = function()
          local v12 = game.ReplicatedStorage.Events.GetIndex:InvokeServer()
          local totalValue = 0
          local folder2 = game.Players.LocalPlayer.Hats
          local children2 = folder2:GetChildren()
          for _, hat in ipairs(children2) do
              local hatName = hat.Name
              local hatPrice = v12[hatName].Price
              totalValue = totalValue + hatPrice
          end
        
          OrionLib:MakeNotification({
              Name = "Total value",
              Content = "You own " .. tostring(#children2) .. " hats worth a total of $" .. tostring(totalValue),
              Image = "rbxassetid://123456789",
              Time = 5
          })
      end    
  })
  
  
  local AutoSell = false
  AutoSellTab:AddToggle({
      Name = "Auto Sell Item",
      Default = false,
      Callback = function(Value)
          if Value then
         AutoSell = true
         local folder = game.Players.LocalPlayer.Hats
         local children = folder:GetChildren()
  
         for _, child in ipairs(children) do
            if tonumber(sellUnder) == 0 or tonumber(sellUnder) > v12[child.name].Price then
                   local args = {
                                 [1] = child.name
                   }
  
         game:GetService("ReplicatedStorage").Events.SellItem:InvokeServer(unpack(args))
            end
         end
         OrionLib:MakeNotification({
                                    Name = "Auto Seller",
                                    Content = "Succesfully Enabled Auto Seller",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      else
         AutoSell = false
         OrionLib:MakeNotification({
                                    Name = "Auto Seller",
                                    Content = "Succesfully Disabled Auto Seller",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      end 
      end  
  })
  AutoSellTab:AddSlider({
	Name = "Sell Under (0 = all)",
	Min = 0,
	Max = 1000,
	Default = 100,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "$",
    Save = true,
    Flag = "SellUnder",
	Callback = function(Value)
		sellUnder = tonumber(Value)
	end    
  })

  local folder = game.Players.LocalPlayer.Hats
  local children = folder:GetChildren()
  local notify = false
  folder.ChildAdded:Connect(function(child)
      if notify then
               OrionLib:MakeNotification({
                                    Name = "New Item  ",
                                    Content = child.Name .. ": " .. v12[child.Name].Price,
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      end
      if AutoSell then
        if tonumber(sellUnder) == 0 or tonumber(sellUnder) > tonumber(v12[child.Name].Price) then
         local args = {
                                 [1] = child.name
                   }
         game:GetService("ReplicatedStorage").Events.SellItem:InvokeServer(unpack(args))
        end
      end
  end)
  
  Item:AddToggle({
      Name = "Item Notify",
      Default = false,
      Callback = function(Value)
          if Value then
                 notify = true
                 OrionLib:MakeNotification({
                                    Name = "Item Notifier",
                                    Content = "Succesfully Enabled Item Notifier",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      else
                         notify = false
                         OrionLib:MakeNotification({
                                    Name = "Item Notifier",
                                    Content = "Succesfully Disabled Item Notifier",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      end
      end    
  })

  --Inventory Tab end--
  --Chat Spam Tab--
  
  local chat = Window:MakeTab({
      Name = "Chat Spammer",
      Icon = "rbxassetid://4483345998",
      PremiumOnly = false
  })
  local chatSpam = chat:AddSection({
      Name = "Chat Spammer"
  })
  
  local message = "hey"
  local isAutoSpamEnabled = false
  local spamSpeed = 3
  chatSpam:AddToggle({
      Name = "Enabled",
      Default = false,
      Callback = function(Value)
          if Value then
              isAutoSpamEnabled = true
              OrionLib:MakeNotification({
                       Name = "Chat spam",
                       Content = "Succesfully Enabled Chat Spammer",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
              while wait(spamSpeed) and isAutoSpamEnabled do
                  local args = {
                               [1] = message
                  }
  
              local eventName
              for _, remote in pairs(game:GetService("ReplicatedStorage").Events:GetChildren()) do
                  if string.match(remote.Name, "%b{}") then
                      eventName = remote.Name
                      break
                  end
              end
  
              if not eventName then
                  return
              end
            game:GetService("ReplicatedStorage").Events:FindFirstChild(eventName):InvokeServer(message)
  
  
              end
          else
              isAutoSpamEnabled = false
              OrionLib:MakeNotification({
                       Name = "Chat spam",
                       Content = "Succesfully Disabled Chat Spammer",
                       Image = "rbxassetid://4483345998",
                       Time = 5
              })
          end
      end,
  })
  
  chatSpam:AddTextbox({
      Name = "spam text",
      TextDisappear = false,
      Callback = function(Value)
      message = Value
          game.Players.LocalPlayer.CaseMoney.Value = Value
          OrionLib:MakeNotification({
                                    Name = "Changed spam message",
                                    Content = "Succesfully changed spam message to the given value",
                                    Image = "rbxassetid://4483345998",
                                    Time = 5
         })
      end	  
  })
  
  chatSpam:AddSlider({
      Name = "Spam Speed",
      Min = 1,
      Max = 120,
      Default = 3,
      Color = Color3.fromRGB(255,255,255),
      Increment = 1,
      ValueName = "seconds",
      Save = true,
      Flag = "SpamSpeed",
      Callback = function(Value)
          spamSpeed = Value
      end    
  })
  
  
  --Chat Spam Tab End--
  --Settings Tab--
  
  local SettingsTab = Window:MakeTab({
      Name = "Settings",
      Icon = "rbxassetid://4483345998",
      PremiumOnly = false
  })
  
  local SettingsSection = SettingsTab:AddSection({
      Name = "Settings"
  })
  
  SettingsSection:AddButton({
      Name = "Destroy UI",
      Callback = function()
          OrionLib:Destroy()
        end    
  })
  
  --Settings End--
  
  
 OrionLib:Init()
 end
end