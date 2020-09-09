function genHeatExchangers(inputs)
    -- Copy electric furnace
    local itemHeatExchanger = table.deepcopy(data.raw.item["heat-exchanger"])
    local recipeHeatExchanger = table.deepcopy(data.raw.recipe["heat-exchanger"])
    local entityHeatExchanger = table.deepcopy(data.raw["boiler"]["heat-exchanger"])
    local technologyHeatExchanger = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        itemHeatExchanger.name = "5d-heat-exchanger-" .. inputs.number
    end
    -- itemHeatExchanger.icon =
    --     "__5dim_energy__/graphics/icon/heat-exchanger/heat-exchanger-icon-" .. inputs.number .. ".png"
    itemHeatExchanger.subgroup = inputs.subgroup
    itemHeatExchanger.order = inputs.order
    itemHeatExchanger.place_result = itemHeatExchanger.name

    --Recipe
    recipeHeatExchanger.name = itemHeatExchanger.name
    -- recipeHeatExchanger.icon = itemHeatExchanger.icon
    recipeHeatExchanger.result = itemHeatExchanger.name
    recipeHeatExchanger.icon_size = 64
    if inputs.new then
        recipeHeatExchanger.enabled = false
    end
    recipeHeatExchanger.ingredients = inputs.ingredients

    --Entity
    entityHeatExchanger.name = itemHeatExchanger.name
    -- entityHeatExchanger.icon = itemHeatExchanger.icon
    entityHeatExchanger.minable.result = itemHeatExchanger.name
    entityHeatExchanger.energy_consumption = inputs.energyUsage .. "MW"
    entityHeatExchanger.energy_source.max_temperature = inputs.pollution
    entityHeatExchanger.energy_source.max_transfer = inputs.craftingSpeed .. "GW"
    entityHeatExchanger.fast_replaceable_group = "heat-exchanger"

    -- Base
    -- entityHeatExchanger.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/heat-exchanger/heat-exchanger-" .. inputs.number .. ".png"

    data:extend({entityHeatExchanger, recipeHeatExchanger, itemHeatExchanger})

    -- Technology
    if inputs.tech then
        technologyHeatExchanger.name = "5d-heat-exchanger-" .. inputs.tech.number
        technologyHeatExchanger.icon = itemHeatExchanger.icon
        technologyHeatExchanger.icon_size = 64
        technologyHeatExchanger.unit.count = inputs.tech.count
        technologyHeatExchanger.unit.ingredients = inputs.tech.packs
        technologyHeatExchanger.prerequisites = inputs.tech.prerequisites
        technologyHeatExchanger.effects = {
            {
                type = "unlock-recipe",
                recipe = itemHeatExchanger.name
            }
        }
        data:extend({technologyHeatExchanger})
    end
end