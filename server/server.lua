ESX = exports["es_extended"]:getSharedObject()

local ox_inventory = exports.ox_inventory
local ox_target = exports.ox_target
local drawZones = true
lib.locale()
  

RegisterNetEvent("Tonykd:removeddd")
AddEventHandler("Tonykd:removeddd", function(itemCount, itemName)
    local src = source
    
    -- 通过统一配置验证
    local itemConfig = Config.PawnShop.Items[itemName]
    print(Config.PawnShop.Items[itemName])
    if not itemConfig then
        print(('非法物品: %s (来自玩家 %s)'):format(itemName, src))
        return
    end

    -- 使用配置中的价格
    local total = itemCount * itemConfig.price
    if exports.ox_inventory:RemoveItem(src, itemName, itemCount) then
        exports.ox_inventory:AddItem(src, 'money', total)
        print(('玩家 %s 成功出售 %s 个 %s，获得 $%s'):format(src, itemCount, itemName, total))
    end
end)