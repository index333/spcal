import System.IO
import Control.Monad
import Graphics.UI.Gtk
import ShowButton
readSample = do
    r <- getContents
    return $ lines r
main = do
    a:b:c:d:e:[] <- readSample
    let l = b:c:d:e:[]
    let ts = ["pcd(mm)",
                "flange2center(mm)",
                "pcd(mm)",
                "flange2center(mm)"]
    print l
    initGUI
    window  <- windowNew
    hbox <- hBoxNew False 0
    vbox <- vBoxNew False 0
    boxPackStart vbox hbox PackNatural 0
    zipWithM (\x y -> mkShowButton hbox "erd(mm)" (read x)) l ts
    e <- entryNew
    containerAdd vbox e
    e `on` entryActivate $ end l e
    containerAdd window vbox
    widgetShowAll window
    window `on` unrealize $ mainQuit
    mainGUI
end l e = do
    mapM_ (\x -> do hPutStr stderr x
                    hPutStr stderr $ " "
                    ) l
    e' <- e `get` entryText
    hPutStrLn stderr e'
    mainQuit
