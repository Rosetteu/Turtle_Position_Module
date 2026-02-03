local TurtleSettings = {
    wirelessDebug = true,

    blacklistedBlocks = {
        "minecraft:bedrock"
    },
    whitelistedBlocks = {
        "minecraft:deepslate_diamond_ore",
        "minecraft:diamond_ore"
    },
    autoEjectItems = {
        "minecraft:cobbeled_deepslate",
        "minecraft:tuff"
    },
    coordinates = {
        chest = {
            x = 1,
            y = -56,
            z = 0
        },
        home = {
            x = 0,
            y = -56,
            z = 0
        }
    }
}
return TurtleSettings
