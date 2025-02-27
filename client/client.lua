ESX = exports["es_extended"]:getSharedObject()

local ox_inventory = exports.ox_inventory
local ox_target = exports.ox_target
local drawZones = true
lib.locale()


ox_target:addBoxZone({
    coords = vec3(-163.5740, 158.0585, 89.7020),
    size = vec3(2, 2, 2),
    rotation = 335.6484,
    debug = false,
    drawSprite = true,
    options = {
        {
            name = 'Tonykd_showmenu',
            icon = 'fa-solid fa-bars',
            event = "Tonykd:pwanmenu",
            label = '当铺',
        }
    }
})

RegisterNetEvent("Tonykd:pwanmenu")
AddEventHandler("Tonykd:pwanmenu", function()
  
    local options = {}
    
    for itemId, itemData in pairs(Config.PawnShop.Items) do
        options[#options+1] = {
            label = itemData.label,
            value = itemId,
        }
       
    end
 
    local input = lib.inputDialog('当铺', {
        {
            type = 'select',
            label = '选择出售的物品',
            options = options,
            required = true,
            icon = 'hand-holding-dollar'
        }
    })
    if not input then return end

    local itemName = input[1]
    local itemCount = exports.ox_inventory:Search('count', itemName)
    
    if itemCount  >= 1 then
        anim()
        TriggerServerEvent("Tonykd:removeddd", itemCount, itemName)
    else
        amounterror()
    end

end)


function anim()

lib.progressBar({
  duration = 5000,
  label = '出售中',
  useWhileDead = false,
  canCancel = false,
  disable = { car = true, move = true, combat = true },
  anim = {
    dict = 'anim@heists@box_carry@',
    clip = 'idle'
  },
  prop = {
    model = `ex_office_swag_jewelwatch2`,
    bone = 28422,
    pos = vec3(0.0,-0.1,-0.2),
    rot = vec3(0.0,0.0,0.0)
  },
})

end  

function amounterror()
lib.notify({
  id = 'pawn_no',
  title = '当铺',
  description = '没有足够的物品',
  showDuration = 1000,
  position = 'top',
  style = {
    backgroundColor = '#080808',
    color = '#dedcdc',
    ['.description'] = {
    color = '#dedcdc'
    }
  },
  icon = 'fa-dollar-sign',
  iconColor = '#dedcdc'
})
end  