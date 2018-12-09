import Graphics.UI.Gtk
import System.IO
import MySpinBox
import Round
import Control.Monad
main = do
    initGUI
    window  <- windowNew
    hbox <- hBoxNew False 0
    vbox <- vBoxNew False 0
    boxPackStart vbox hbox PackNatural 0
    let names = ["リム外径(mm)", 
                    "デプス計の値(mm)",
                    "直定規の厚み(0.5mm固定)"]
    adjs <- mkAdjustments [(600,200, 700, 1,10),
                            (10,0,30,0.1,1),
                            (0.5,0.5,0.5,0,0)]
    s0:s1:s2:[] <- myAddSpinButtons hbox names adjs
    s0 `set` [spinButtonDigits := 0] 
    s1 `set` [spinButtonDigits := 1] 
    s2 `set` [spinButtonDigits := 1] 
    l <- labelNew $ Just "rim name"
    e <- entryNew
    e `on` entryActivate $ end adjs e
    containerAdd vbox l
    containerAdd vbox e

    containerAdd window vbox
    widgetShowAll window
    window `on` unrealize $ mainQuit
    mainGUI
end adjs e = do
    v0:v1:v2:[] <- mapM (`get` adjustmentValue) adjs
    let r = v0 - (v1 - v2) * 2
    hPutStr stderr $ show r
    hPutStr stderr $ " "
    e' <- e `get` entryText
    hPutStrLn stderr e'
    mainQuit
