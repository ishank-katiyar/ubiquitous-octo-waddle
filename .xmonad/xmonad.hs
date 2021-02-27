--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
import XMonad
import System.IO (hPutStrLn)
import XMonad.Layout.Fullscreen
    ( fullscreenEventHook, fullscreenManageHook, fullscreenSupport, fullscreenFull )
-- import Data.Monoid ()
import System.Exit
import XMonad.Util.SpawnOnce ( spawnOnce )
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp, xF86XK_AudioPlay, xF86XK_AudioPrev, xF86XK_AudioNext)
import XMonad.Hooks.EwmhDesktops ( ewmh )
import Control.Monad ( join, when, liftM2 )
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
    -- ( avoidStruts, docks, manageDocks, Direction2D(D, L, R, U) )
-- import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )
-- import XMonad.Actions.Submap
-- import Control.Monad ()
import Data.Tree
-- import XMonad.Actions.TreeSelect
import qualified XMonad.Actions.TreeSelect as TS
import XMonad.Hooks.WorkspaceHistory
import XMonad.Prompt
-- import XMonad.Actions.DynamicWorkspaceGroups
import XMonad.Actions.Commands
import XMonad.Layout.Maximize
import XMonad.Actions.Minimize
import XMonad.Layout.Minimize
import qualified XMonad.Layout.BoringWindows as BW

import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
-- import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
-- import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))


-- import XMonad.Layout.Spacing ( spacingRaw, Border(Border) )
-- import XMonad.Layout.Gaps
--     ( Direction2D(D, L, R, U),
--       gaps,
--       setGaps,
--       GapMessage(DecGap, ToggleGaps, IncGap) )
import XMonad.Actions.CycleWS
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Hooks.ManageHelpers

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Monoid
import Data.Maybe (maybeToList)
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False


myFont :: String
myFont = "xft:Hack:regular:size=9:antialias=true:hinting=true"

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

leftAltMask     = mod1Mask

rightAltMask    = mod3Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
-- myWorkspaces    = ["\63083", "\63288", "\63306", "\61723", "\63107", "\63601", "\63391", "\61713", "\61884"]
-- myWorkspaces = ["web ", "con ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "ent "]
myWorkspaces = [" web ", " terminals ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " CP ", " entertainment "]

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myClickableWorkspaces :: [String]
myClickableWorkspaces = clickable . (map xmobarEscape)
               -- $ [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
               $ ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 "]
               -- $ [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
  where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..9] l,
                      let n = i ]

-- Border colors for unfocused and focused windows, respectively.
--
-- myNormalBorderColor  = "#3b4252"
-- myFocusedBorderColor = "#bc96da"
myNormColor :: String
myNormColor   = "#282c34"  -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#46d9ff"  -- Border color of focused windows

commands :: X [(String, X ())]
commands = defaultCommands


myNormalBorderColor  = "#444488"
myFocusedBorderColor = "#ee9999"

myBgColor= "#001070"
myFgColor = "#bbbbdd"
myBgHLight= "#4444aa"
myFgHLight= "#ddddff"

-- myXPConfig :: XPConfig
-- myXPConfig = defaultXPConfig
--               { font        = "xft:Terminus:pixelsize=16"
--           , bgColor     = myBgColor
--           , fgColor     = myFgColor
--           , bgHLight    = myBgHLight
--           , fgHLight    = myFgHLight
--               , borderColor = myNormalBorderColor
--               }

-- treeselectAction myTreeConf
treeselectAction :: TS.TSConfig (X ()) -> X ()
treeselectAction a = TS.treeselectAction a
   [ 
     Node (TS.TSNode "restart xmonad" "recompile & restart xmonad" (spawn "~/.xmonad/restartXmonad.sh")) []
   , Node (TS.TSNode "open config file" "open config file" (return ())) 
   [
     Node (TS.TSNode "xmonad" "xmonad config file" (spawn (myTerminal ++ " -e nvim ~/.xmonad/xmonad.hs"))) []
   , Node (TS.TSNode "xmobar" "xmobar config file" (spawn (myTerminal ++ " -e nvim ~/.config/xmobar/xmobarrc2"))) []
   , Node (TS.TSNode "nvim" "nvim config file" (spawn (myTerminal ++ " -e nvim ~/.config/nvim/init.vim"))) []
   , Node (TS.TSNode "deadd" "deadd config file" (spawn (myTerminal ++ " -e nvim ~/.config/deadd/deadd.conf"))) 
   [
     Node (TS.TSNode "deadd" "deadd config file" (spawn (myTerminal ++ " -e nvim ~/.config/deadd/deadd.conf"))) []
   , Node (TS.TSNode "deadd" "deadd css file" (spawn (myTerminal ++ " -e nvim ~/.config/deadd/deadd.css"))) []
   ]
   , Node (TS.TSNode "neofetch" "neofetch config file" (spawn (myTerminal ++ " -e nvim ~/.config/neofetch/config.conf"))) []
   ]
   , Node (TS.TSNode "open Layout" "open Layout" (return ())) 
   [
     Node (TS.TSNode "CP" "competitve programming" (spawn "~/.xmonad/layoutconfigscripts/CP.sh")) 
     [
       Node (TS.TSNode "Codeforces" "open codeforces" (spawn "~/.xmonad/layoutconfigscripts/CP.sh www.codeforces.com")) []
     , Node (TS.TSNode "Codechef" "open codechef" (spawn "~/.xmonad/layoutconfigscripts/CP.sh www.codechef.com")) []
     ]
   ]
     , Node (TS.TSNode "Scripts" "some scripts" (return ())) 
     [
       Node (TS.TSNode "powermenu" "show powermenu with rofi" (spawn "~/.config/rofi/powermenu.sh")) []
     , Node (TS.TSNode "app launcher" "app launcher with rofi" (spawn "~/.config/rofi/application_launcher.sh")) []
     , Node (TS.TSNode "executable launcher" "executable launcher with rofi" (spawn "~/.config/rofi/executable_launcher.sh")) []
     , Node (TS.TSNode "change wallpaper" "change wallpaper" (spawn "python3 ~/.config/i3/wallpaper/change_wallpaper.py")) 
     [
       Node (TS.TSNode "next wallpaper" "nex wallpaper" (spawn "python3 ~/.config/i3/wallpaper/change_wallpaper.py")) []
     , Node (TS.TSNode "previous wallpaper" "previous wallpaper" (spawn "python3 ~/.config/i3/wallpaper/change_wallpaper.py reverse")) []
     , Node (TS.TSNode "toggle perm wallpaper" "make wallpaper permenent" (spawn "python3 ~/.config/i3/wallpaper/change_wallpaper.py toggleperm")) []
     ]
     , Node (TS.TSNode "Layout conf" "Layout configutation scripts" (return ())) 
     [
       Node (TS.TSNode "CP" "competitve programming conf" (spawn (myTerminal ++ " -e nvim ~/.xmonad/layoutconfigscripts/CP.sh"))) []
     ]
     ]
     , Node (TS.TSNode "program restart" "restart program" (return ())) 
     [
       Node (TS.TSNode "compositor" "picom" (spawn "killall picom && sleep 1s && picom --experimental-backends &")) []
     , Node (TS.TSNode "notication panel" "deadd notification" (spawn "killall deadd-notification-center && sleep 1s && deadd-notification-center &")) []
     , Node (TS.TSNode "clipboard" "copyq" (spawn "killall copyq && sleep 1s && copyq &")) []
     ]
   , Node (TS.TSNode "alacritty theme" "change alacritty theme" (spawn ("alacritty " ++ " -e npx alacritty-themes"))) []
   ]


tsDefaultConfig :: TS.TSConfig a
tsDefaultConfig = TS.TSConfig { TS.ts_hidechildren = True
                              , TS.ts_background   = 0xdd282c34
                              , TS.ts_font         = "xft:Hack:bold:size=11:antialias=true:hinting=true"
                              , TS.ts_node         = (0xffd0d0d0, 0xff1c1f24)
                              , TS.ts_nodealt      = (0xffd0d0d0, 0xff282c34)
                              , TS.ts_highlight    = (0xffffffff, 0xff755999)
                              , TS.ts_extra        = 0xffd0d0d0
                              , TS.ts_node_width   = 200
                              , TS.ts_node_height  = 25
                              , TS.ts_originX      = 100
                              , TS.ts_originY      = 100
                              , TS.ts_indent       = 80
                              , TS.ts_navigate     = myTreeNavigation
                              }

myTreeNavigation = M.fromList
    [ ((0, xK_Escape),   TS.cancel)
    , ((0, xK_Return),   TS.select)
    -- , ((0, xK_space),    TS.select)
    , ((0, xK_Up),       TS.movePrev)
    , ((0, xK_Down),     TS.moveNext)
    , ((0, xK_Left),     TS.moveParent)
    , ((0, xK_Right),    TS.moveChild)
    , ((0, xK_k),        TS.movePrev)
    , ((0, xK_j),        TS.moveNext)
    , ((0, xK_h),        TS.moveParent)
    , ((0, xK_l),        TS.moveChild)
    , ((0, xK_o),        TS.moveHistBack)
    , ((0, xK_i),        TS.moveHistForward)
    -- , ((0, xK_a),        TS.moveTo ["+ Accessories"])
    -- , ((0, xK_e),        TS.moveTo ["+ Games"])
    -- , ((0, xK_g),        TS.moveTo ["+ Graphics"])
    -- , ((0, xK_i),        TS.moveTo ["+ Internet"])
    -- , ((0, xK_m),        TS.moveTo ["+ Multimedia"])
    -- , ((0, xK_o),        TS.moveTo ["+ Office"])
    -- , ((0, xK_p),        TS.moveTo ["+ Programming"])
    -- , ((0, xK_s),        TS.moveTo ["+ System"])
    -- , ((0, xK_b),        TS.moveTo ["+ Bookmarks"])
    -- , ((0, xK_c),        TS.moveTo ["+ Config Files"])
    -- , ((0, xK_r),        TS.moveTo ["+ Screenshots"])
    -- , ((mod4Mask, xK_l), TS.moveTo ["+ Bookmarks", "+ Linux"])
    -- , ((mod4Mask, xK_e), TS.moveTo ["+ Bookmarks", "+ Emacs"])
    -- , ((mod4Mask, xK_s), TS.moveTo ["+ Bookmarks", "+ Search and Reference"])
    -- , ((mod4Mask, xK_p), TS.moveTo ["+ Bookmarks", "+ Programming"])
    -- , ((mod4Mask, xK_v), TS.moveTo ["+ Bookmarks", "+ Vim"])
    -- , ((mod4Mask .|. altMask, xK_a), TS.moveTo ["+ Bookmarks", "+ Linux", "+ Arch Linux"])
    -- , ((mod4Mask .|. altMask, xK_n), TS.moveTo ["+ Bookmarks", "+ Linux", "+ Linux News"])
    -- , ((mod4Mask .|. altMask, xK_w), TS.moveTo ["+ Bookmarks", "+ Linux", "+ Window Managers"])
    ]



addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Swap the focused window and the master window
    [ ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
    -- , ((modm, xK_y), submap . M.fromList $
    --    [ ((0, xK_n),    promptWSGroupAdd myXPConfig "Name this group: " )
    --    , ((0, xK_g),    promptWSGroupView myXPConfig "Go to group: " )
    --    , ((0, xK_d),    promptWSGroupForget myXPConfig "Forget group: " )
    --    ])   
    , ((modm,               xK_s     ), treeselectAction tsDefaultConfig)

    -- launch rofi and dashboard
    , ((modm,               xK_p     ), spawn "dmenu_run -h 30 -fn 'Hack:bold:pixelsize=13' -p 'prompt' -nf '#bbc5ff' -nb '#282a36' -sb '#82aaff' -sf '#282a36'")
    , ((modm .|. controlMask, xK_y), commands >>= runCommand)
    -- , ((modm,               xK_p), spawn "~/.config/rofi/application_launcher.sh")
    -- , ((modm .|. leftAltMask,  xK_p), spawn "~/.config/rofi/executable_launcher.sh")

    -- Audio keys
    , ((0,                    xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0,                    xF86XK_AudioPrev), spawn "playerctl previous")
    , ((0,                    xF86XK_AudioNext), spawn "playerctl next")
    -- , ((0,                    xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%")
    -- , ((0,                    xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%")
    -- , ((0,                    xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
    , ((0,                    xF86XK_AudioRaiseVolume), spawn "bash ~/.config/deadd/volume.sh inc")
    , ((0,                    xF86XK_AudioLowerVolume), spawn "bash ~/.config/deadd/volume.sh dec")
    , ((0,                    xF86XK_AudioMute), spawn "bash ~/.config/deadd/volume.sh mute")

    -- Brightness keys
    -- , ((0,                    xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%")
    -- , ((0,                    xF86XK_MonBrightnessDown), spawn "brightnessctl s 10-%")
    , ((0,                    xF86XK_MonBrightnessUp), spawn "bash ~/.config/deadd/brightness.sh inc")
    , ((0,                    xF86XK_MonBrightnessDown), spawn "bash ~/.config/deadd/brightness.sh dec")
 
    -- Screenshot
    , ((0,                    xK_Print), spawn "scrot /home/ishank/Pictures/Screenshot/Screenshot-$(date +'%F_%T').jpg")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- -- GAPS!!!
    -- , ((modm .|. controlMask, xK_g), sendMessage $ ToggleGaps)               -- toggle all gaps
    -- , ((modm .|. shiftMask, xK_g), sendMessage $ setGaps [(L,30), (R,30), (U,40), (D,60)]) -- reset the GapSpec
    -- 
    -- , ((modm .|. controlMask, xK_t), sendMessage $ IncGap 10 L)              -- increment the left-hand gap
    -- , ((modm .|. shiftMask, xK_t     ), sendMessage $ DecGap 10 L)           -- decrement the left-hand gap
    -- 
    -- , ((modm .|. controlMask, xK_y), sendMessage $ IncGap 10 U)              -- increment the top gap
    -- , ((modm .|. shiftMask, xK_y     ), sendMessage $ DecGap 10 U)           -- decrement the top gap
    -- 
    -- , ((modm .|. controlMask, xK_u), sendMessage $ IncGap 10 D)              -- increment the bottom gap
    -- , ((modm .|. shiftMask, xK_u     ), sendMessage $ DecGap 10 D)           -- decrement the bottom gap
    -- 
    -- , ((modm .|. controlMask, xK_i), sendMessage $ IncGap 10 R)              -- increment the right-hand gap
    -- , ((modm .|. shiftMask, xK_i     ), sendMessage $ DecGap 10 R)           -- decrement the right-hand gap

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    -- , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    -- , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    -- , ((modm,               xK_m     ), windows W.focusMaster  )

    -- launch a terminal
    , ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- cycle worksace
    -- , ((modm .|. leftAltMask,               xK_Down), nextWS)
    -- , ((modm .|. leftAltMask,               xK_Up),    prevWS)
    , ((modm .|. leftAltMask,               xK_l), moveTo Next NonEmptyWS)
    , ((modm .|. leftAltMask,               xK_h),   moveTo Prev NonEmptyWS)

    -- clipboard manager
    , ((modm, xK_F9), spawn "exec copyq toggle")
    -- , ((controlMask, xK_F9), spawn "copyq eval 'if (visible()) hide(); else show()'")

    -- Minimize a window 
    -- , ((modm, xK_m ), withFocused minimizeWindow )
    -- , ((modm .|. shiftMask, xK_m ), withLastMinimized maximizeWindow)

    -- notification center
    , ((modm, xK_a), spawn "kill -s USR1 $(pidof deadd-notification-center)")
    , ((modm, xK_Delete),  spawn "notify-send.py a --hint boolean:deadd-notification-center:true string:type:clearPopups")

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- make focused window full screen (do full float)
    -- , ((modm, xK_f), withFocused $ windows . (flip W.float $ W.RationalRect 0 0 1 1))
    -- , ((modm, xK_f), withFocused (sendMessage . maximizeRestore))
    , ((modm, xK_f), (sendMessage $ MT.Toggle FULL))

    -- powermenu.sh
    , ((modm .|. shiftMask, xK_q     ), spawn "bash ~/.config/rofi/powermenu.sh")

    -- Quit xmonad
    , ((modm .|. leftAltMask .|. shiftMask .|. controlMask , xK_e     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    -- , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    -- , ((modm .|. shiftMask, xK_slash ), spawn ("notify-send $(echo '" ++ help ++ "')"))
    , ((modm .|. shiftMask, xK_slash ), spawn ("notify-send '" ++ help ++ "'"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = smartBorders 
           $ mkToggle (NOBORDERS ?? NBFULL ?? EOT)
           $ mkToggle (single FULL)
           $ mkToggle (single MIRROR)
           $ avoidStruts $ maximizeWithPadding 100 (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100



-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
-- myManageHook = fullscreenManageHook <+> manageDocks <+> composeAll
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = (composeAll . concat $
    [ [className =? c                         --> doFloat                                | c <- dofloatwindow]
    , [resource  =? c                         --> doIgnore                               | c <- doignoredwindowresource]
    , [className =? c                         --> doShiftAndGo ( myWorkspaces !! 8 )     | c <- entertainment]
    , [className =? c                         --> doShiftAndGo ( myWorkspaces !! 0 )     | c <- browsers]
    , [isDialog                               --> doCenterFloat]
    -- , isFullscreen --> doFullFloat
    ])
    where
        doShiftAndGo ws = doF (W.greedyView ws) <+> doShift ws
        entertainment   = ["Spotify", "qtwebflix", "Whatsapp-for-linux", "vlc"]
        browsers        = ["firefox", "Google-chrome"]
        doignoredwindowresource = ["desktop_window", "kdesktop"]
        dofloatwindow           = ["MPlayer", "Gimp", "copyq", "conky"]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawn "python3 /home/ishank/.config/i3/wallpaper/change_wallpaper.py"
  -- spawn "feh --bg-fill ~/Pictures/Wallpaper/49.jpg"
  spawnOnce "exec nm-applet &"
  spawnOnce "exec deadd-notification-center &"
  spawnOnce "exec picom --experimental-backends &"
  spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34  --height 25 &"
  spawnOnce "exec copyq &"
  spawnOnce "exec lxpolkit &" -- polkit https://wiki.archlinux.org/index.php/Polkit
  -- spawnOnce "bash ~/.conky/conky-startup.sh"


------------------------------------------------------------------------
-- Command to launch the bar.
-- myBar = "xmobar ~/.config/xmobar/xmobarrc2"

------------------------------------------------------------------------
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- main = xmonad $ fullscreenSupport $ docks $ ewmh defaults
main = do
        xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc2"
        -- xmonad $ fullscreenSupport $ docks $ ewmh defaults
        xmonad $ fullscreenSupport $ docks $ ewmh defaults { logHook = dynamicLogWithPP $ def { 
              ppOutput = hPutStrLn xmproc 
            , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]" -- Current workspace in xmobar
            , ppVisible = xmobarColor "#98be65" ""                -- Visible but not current workspace
            , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
            , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
            , ppTitle = xmobarColor "#b3afc2" "" . shorten 50     -- Title of active window in xmobar
            , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"          -- Separators in xmobar
            , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
            , ppExtras  = [windowCount]                           -- # of windows current workspace
            , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
            } }
--         xmonad $ fullscreenSupport $ docks $ ewmh def {
--       -- simple stuff
--         terminal           = myTerminal,
--         focusFollowsMouse  = myFocusFollowsMouse,
--         clickJustFocuses   = myClickJustFocuses,
--         borderWidth        = myBorderWidth,
--         modMask            = myModMask,
--         workspaces         = myWorkspaces,
--         normalBorderColor  = myNormalBorderColor,
--         focusedBorderColor = myFocusedBorderColor,
-- 
--       -- key bindings
--         keys               = myKeys,
--         mouseBindings      = myMouseBindings,
-- 
--       -- hooks, layouts
--         manageHook = myManageHook, 
--         -- layoutHook = gaps [(L,10), (R,10), (U,10), (D,10)] $ spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True $ smartBorders $ myLayout,
--         layoutHook         = myLayout,
--         handleEventHook    = myEventHook <+> handleEventHook defaultConfig <+> docksEventHook,
--         logHook            = myLogHook <+> dynamicLogWithPP xmobarPP
--                         { ppOutput = hPutStrLn xmproc0
--                         , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]" -- Current workspace in xmobar
--                         , ppVisible = xmobarColor "#98be65" ""                -- Visible but not current workspace
--                         , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
--                         , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
--                         , ppTitle = xmobarColor "#b3afc2" "" . shorten 60     -- Title of active window in xmobar
--                         , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"          -- Separators in xmobar
--                         , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
--                         , ppExtras  = [windowCount]                           -- # of windows current workspace
--                         , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
--                         },
--         startupHook        = myStartupHook >> addEWMHFullscreen
--     }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormColor,
        focusedBorderColor = myFocusColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        manageHook = myManageHook, 
        -- manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig,
        -- layoutHook = gaps [(L,5), (R,5), (U,5), (D,5)] $ spacingRaw False (Border 0 0 0 0) True (Border 3 3 3 3) True $ smartBorders $ myLayout,
        -- layoutHook = gaps [(L,5), (R,5), (U,35), (D,5)] $ spacingRaw True (Border 0 0 0 0) True (Border 5 5 5 5) True $ smartBorders $ myLayout,
        -- layoutHook = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True $ smartBorders $ myLayout,
        layoutHook         = minimize . BW.boringWindows $ showWName' myShowWNameTheme $ smartBorders $ myLayout,
        handleEventHook    = myEventHook,
        -- logHook            = dynamicLogWithPP $ def { ppOutput = hPutStrLn xmproc },
        startupHook        = myStartupHook >> addEWMHFullscreen
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'super'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
