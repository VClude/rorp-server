resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
  'incl.lua',
  'config.lua',
  'utils.lua',
	'client.lua',

    -- NativeUI (Customized, don't attempt to use the standard version)
  "NativeUILua-Reloaded/Wrapper/Utility.lua",

  "NativeUILua-Reloaded/UIElements/UIVisual.lua",
  "NativeUILua-Reloaded/UIElements/UIResRectangle.lua",
  "NativeUILua-Reloaded/UIElements/UIResText.lua",
  "NativeUILua-Reloaded/UIElements/Sprite.lua",

  "NativeUILua-Reloaded/UIMenu/elements/Badge.lua",
  "NativeUILua-Reloaded/UIMenu/elements/Colours.lua",
  "NativeUILua-Reloaded/UIMenu/elements/ColoursPanel.lua",
  "NativeUILua-Reloaded/UIMenu/elements/StringMeasurer.lua",

  "NativeUILua-Reloaded/UIMenu/items/UIMenuItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuCheckboxItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuListItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuSliderItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuSliderHeritageItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuColouredItem.lua",

  "NativeUILua-Reloaded/UIMenu/items/UIMenuProgressItem.lua",
  "NativeUILua-Reloaded/UIMenu/items/UIMenuSliderProgressItem.lua",

  "NativeUILua-Reloaded/UIMenu/windows/UIMenuHeritageWindow.lua",

  "NativeUILua-Reloaded/UIMenu/panels/UIMenuGridPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuColourPanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuPercentagePanel.lua",
  "NativeUILua-Reloaded/UIMenu/panels/UIMenuStatisticsPanel.lua",

  "NativeUILua-Reloaded/UIMenu/UIMenu.lua",
  "NativeUILua-Reloaded/UIMenu/MenuPool.lua",

  "NativeUILua-Reloaded/UITimerBar/UITimerBarPool.lua",

  "NativeUILua-Reloaded/UITimerBar/items/UITimerBarItem.lua",
  "NativeUILua-Reloaded/UITimerBar/items/UITimerBarProgressItem.lua",
  "NativeUILua-Reloaded/UITimerBar/items/UITimerBarProgressWithIconItem.lua",

  "NativeUILua-Reloaded/UIProgressBar/UIProgressBarPool.lua",
  "NativeUILua-Reloaded/UIProgressBar/items/UIProgressBarItem.lua",

  "NativeUILua-Reloaded/NativeUI.lua",
}

server_scripts {	
  'incl.lua',
	'config.lua',
  'utils.lua',
	'server.lua',
	'@mysql-async/lib/MySQL.lua',
}

files {
  'OTHER_Base.png',
  'SKELLY_Base.png',
  'SKELLY_Head.png',
  'SKELLY_Body.png',
  'SKELLY_LeftLeg.png',
  'SKELLY_RightLeg.png',
  'SKELLY_LeftArm.png',
  'SKELLY_RightArm.png',
}

dependencies {
  'progressBars'
}