import qualified Data.Map as M
import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift

import Control.Monad (liftM2)          -- myManageHookShift
import System.IO                       -- for xmobar

import XMonad.Actions.WindowGo
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks        -- avoid xmobar area import XMonad.Hooks.Place
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Gaps
import XMonad.Layout.IM
import XMonad.Layout.Magnifier         -- this makes window bigger
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns      -- for many windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.TwoPane
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Accordion
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86

myWorkspaces = ["  1  ", "  2  ", "  3  ", "  4  ", "  5  ", "  6  ", "  7  ", "  8  ", "  9  "]
modm = mod1Mask

colorOrange    = "#ffa81e"
colorBlue      = "#857da9"
colorGreen     = "#88b986"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#0a0a0a"

main :: IO ()

main = do
    wsbar <- spawnPipe myWsBar
    xmonad $ defaultConfig
       { borderWidth = 3
       , terminal = "alacritty"
       , normalBorderColor = colorGray
       , focusedBorderColor = colorWhite
       , startupHook = myStartupHook
       , manageHook = myManageHookShift <+> myManageHookFloat <+> manageDocks
        -- any time Full mode, avoid xmobar area
       , layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
        -- xmobar setting
       , logHook = myLogHook wsbar
       , handleEventHook = fullscreenEventHook
       , workspaces = myWorkspaces
       , modMask = modm }

       `additionalKeys`
       [ ((modm  , xK_p      ), spawn "rofi -show run -font 'MigMix 1M 10'")
       , ((modm  , xK_i      ), spawn "gnome-screensaver-command --lock")
       , ((0     , 0x1008ff13), spawn "amixer -D pulse set Master 5%+")
       , ((0     , 0x1008ff11), spawn "amixer -D pulse set Master 5%-")
       , ((0     , 0x1008ff12), spawn "amixer -D pulse set Master toggle")
       , ((0     , 0x1008FF02), spawn "xbacklight + 10")
       , ((0     , 0x1008FF03), spawn "xbacklight - 10")

       ]

-- Handle Window behaveior
myLayout = gaps [(U, 30)] $ (spacing 10 $ ResizableTall 1 (3/100) (1/2) [])
            |||  (spacing 10 $ (dragPane Horizontal (1/10) (1/2)))
            |||  (spacing 10 $ (ThreeColMid 1 (3/100) (1/2)))
            |||  Simplest

-- Start up (at xmonad beggining), like "wallpaper" or so on
myStartupHook = do
        spawn "google-chrome-stable"
        spawn "alacritty"

-- some window must created there
myManageHookShift = composeAll
            -- if you want to know className, type "$ xprop|grep CLASS" on shell
            [ className =? "google-chrome"   --> doShift "  browser  "
            , className =? "Mplayer"   --> doShift "  media  "
            ]
--             where viewShift = doF . liftM2 (.) W.view W.shift

-- new window will created in Float mode
myManageHookFloat = composeAll
            [ className =? "MPlayer"          --> doCenterFloat ]


myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar ~/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder               = \(ws:l:t:_)   -> [ws,t]
                , ppCurrent             = xmobarColor   colorOrange      colorNormalbg
                , ppUrgent              = xmobarColor   colorWhite       colorNormalbg
                , ppVisible             = xmobarColor   colorWhite       colorNormalbg
                , ppHidden              = xmobarColor   colorWhite       colorNormalbg
                , ppHiddenNoWindows     = xmobarColor   colorGray        colorNormalbg
                , ppTitle               = xmobarColor   colorWhite       colorNormalbg
                , ppWsSep               = ""
                , ppSep                 = "  ::: "
                }
