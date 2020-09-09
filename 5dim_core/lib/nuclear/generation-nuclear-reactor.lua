function genNuclearReactors(inputs)
    -- Copy electric furnace
    local itemNuclearReactor = table.deepcopy(data.raw.item["nuclear-reactor"])
    local recipeNuclearReactor = table.deepcopy(data.raw.recipe["nuclear-reactor"])
    local entityNuclearReactor = table.deepcopy(data.raw["reactor"]["nuclear-reactor"])
    local technologyNuclearReactor = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        itemNuclearReactor.name = "5d-nuclear-reactor-" .. inputs.number
    end
    -- itemNuclearReactor.icon =
    --     "__5dim_energy__/graphics/icon/nuclear-reactor/nuclear-reactor-icon-" .. inputs.number .. ".png"
    itemNuclearReactor.subgroup = inputs.subgroup
    itemNuclearReactor.order = inputs.order
    itemNuclearReactor.place_result = itemNuclearReactor.name

    --Recipe
    recipeNuclearReactor.name = itemNuclearReactor.name
    -- recipeNuclearReactor.icon = itemNuclearReactor.icon
    recipeNuclearReactor.result = itemNuclearReactor.name
    recipeNuclearReactor.icon_size = 64
    if inputs.new then
        recipeNuclearReactor.enabled = false
    end
    recipeNuclearReactor.ingredients = inputs.ingredients

    --Entity
    entityNuclearReactor.name = itemNuclearReactor.name
    -- entityNuclearReactor.icon = itemNuclearReactor.icon
    entityNuclearReactor.minable.result = itemNuclearReactor.name
    entityNuclearReactor.energy_source.effectivity = inputs.craftingSpeed
    entityNuclearReactor.consumption = inputs.energyUsage .. "MW"
    entityNuclearReactor.neighbour_bonus = inputs.pollution
    entityNuclearReactor.fast_replaceable_group = "nuclear-reactor"

    -- Base
    -- entityNuclearReactor.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/nuclear-reactor/nuclear-reactor-" .. inputs.number .. ".png"

    data:extend({entityNuclearReactor, recipeNuclearReactor, itemNuclearReactor})

    -- Technology
    if inputs.tech then
        technologyNuclearReactor.name = "5d-nuclear-reactor-" .. inputs.tech.number
        technologyNuclearReactor.icon = itemNuclearReactor.icon
        technologyNuclearReactor.icon_size = 64
        technologyNuclearReactor.unit.count = inputs.tech.count
        technologyNuclearReactor.unit.ingredients = inputs.tech.packs
        technologyNuclearReactor.prerequisites = inputs.tech.prerequisites
        technologyNuclearReactor.effects = {
            {
                type = "unlock-recipe",
                recipe = itemNuclearReactor.name
            }
        }
        data:extend({technologyNuclearReactor})
    end
end