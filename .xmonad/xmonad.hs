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
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.Place
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
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86

tall = ResizableTall 1 (3/100) (1/2) []

myWorkspaces = ["  1  ", "  2  ", "  3  ", "  4  ", "  5  "]
modm = mod4Mask

colorBlue      = "#857da9"
colorGreen     = "#88b986"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

-- Define keys to remove
keysToRemove x =
    [
        -- Unused gmrun binding
          (modm .|. shiftMask, xK_p)
        -- Unused close window binding
        , (modm .|. shiftMask, xK_c)
        , (modm .|. shiftMask, xK_Return)
    ]

-- Delete the keys combinations we want to remove.
strippedKeys x = foldr M.delete (keys defaultConfig x) (keysToRemove x)

main :: IO ()

main = do
    wsbar <- spawnPipe myWsBar
    xmonad $ defaultConfig
       { borderWidth = 2
       , terminal = "urxvt"
       , normalBorderColor = colorGray
       , focusedBorderColor = colorGreen
       , startupHook = myStartupHook
       , manageHook = placeHook myPlacement <+> myManageHookShift <+> myManageHookFloat <+> manageDocks
        -- any time Full mode, avoid xmobar area
       , layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
        -- xmobar setting
       , logHook = myLogHook wsbar
       , handleEventHook = fadeWindowsEventHook
       , workspaces = myWorkspaces
       , modMask = modm }

       `additionalKeys`
       [ ((modm              , xK_f     ), sendMessage ToggleLayout)
       , ((modm              , xK_g     ), sendMessage ToggleGaps)
       , ((modm              , xK_l     ), sendMessage MirrorShrink)
       , ((modm              , xK_h     ), sendMessage MirrorExpand)
       , ((modm              , xK_Right ), nextWS ) -- go to next workspace
       , ((modm              , xK_Left  ), prevWS ) -- go to prev workspace
       , ((modm .|. shiftMask, xK_Right ), shiftToNext)
       , ((modm .|. shiftMask, xK_Left  ), shiftToPrev)
       , ((modm              , xK_comma ), sendMessage MagnifyLess)   -- smaller window
       , ((modm              , xK_period), sendMessage MagnifyMore)  -- bigger window
       , ((modm              , xK_j     ), windows W.focusDown)
       , ((modm              , xK_k     ), windows W.focusUp)
       , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)
       , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)
       , ((modm              , xK_w     ), nextScreen) ]

       `additionalKeys`
       [ ((modm .|. m, k), windows $ f i)
         | (i, k) <- zip myWorkspaces
                     [ xK_exclam, xK_at, xK_numbersign
                     , xK_dollar, xK_percent, xK_asciicircum
                     , xK_ampersand, xK_asterisk, xK_parenleft
                     , xK_parenright
                     ]
       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ]

       `additionalKeys`
       [ ((mod1Mask .|. controlMask, xK_l      ), spawn "xscreensaver-command -lock")
       , ((modm                    , xK_Return ), spawn "urxvt")
       , ((modm                    , xK_c      ), kill) -- %! Close the focused window
       , ((modm                    , xK_p      ), spawn "exe=`dmenu_run -nb '#1a1e1b' -nf '#d3d7cf' -sb '#88b986' -sf '#1a1e1b'` -fn 'TakaoPGothic-9' && exec $exe")
       , ((0                       , 0x1008ff13), spawn "amixer -D pulse set Master 5%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
       , ((0                       , 0x1008ff11), spawn "amixer -D pulse set Master 5%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
       , ((0                       , 0x1008ff12), spawn "amixer -D pulse set Master toggle")
        -- Brightness Keys
       , ((0                       , 0x1008FF02), spawn "xbacklight + 10")
       , ((0                       , 0x1008FF03), spawn "xbacklight - 10")

       ]

-- Handle Window behaveior
myLayout = (spacing 10 $ ResizableTall 1 (3/100) (3/5) [])
            |||  (spacing 10 $ (dragPane Horizontal (1/10) (1/2)))
            |||  (dragPane Vertical   (1/10) (1/2))


-- Start up (at xmonad beggining), like "wallpaper" or so on
myStartupHook = do
        spawn "compton --config ~/.compton.conf -b"
        spawn "nitrogen --restore"
-- some window must created there
myManageHookShift = composeAll
            -- if you want to know className, type "$ xprop|grep CLASS" on shell
            [ className =? "google-chrome"   --> doShift "  browser  "
            , className =? "Mplayer"   --> doShift "  media  "
            ]
--             where viewShift = doF . liftM2 (.) W.view W.shift

-- new window will created in Float mode
myManageHookFloat = composeAll
            [ className =? "MPlayer"          --> doFloat,
              className =? "Gimp"             --> doFloat,
              className =? "Websearch.py"     --> doFloat,
              className =? "Plugin-container" --> doFloat,
              title     =? "Speedbar"         --> doFloat]


myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar ~/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder               = \(ws:l:t:_)   -> [ws,t]
                , ppCurrent             = xmobarColor   colorGreen       colorNormalbg
                , ppUrgent              = xmobarColor   colorWhite       colorNormalbg
                , ppVisible             = xmobarColor   colorWhite       colorNormalbg
                , ppHidden              = xmobarColor   colorWhite       colorNormalbg
                , ppHiddenNoWindows     = xmobarColor   colorGray        colorNormalbg
                , ppTitle               = xmobarColor   colorWhite       colorNormalbg
                , ppWsSep               = ""
                , ppSep                 = "  ::: "
                }

myPlacement = fixed (0.5, 0.5)
