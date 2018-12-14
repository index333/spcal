import System.IO
import ShowButton
import Graphics.UI.Gtk
readSample = do
    r <- getContents
    return $ lines r
main = do
    a:b:c:d:e:[] <- readSample
    print $ a:b:c:d:e:[] 
    initGUI
    window  <- windowNew
    hbox <- hBoxNew False 0
    vbox <- vBoxNew False 0
    boxPackStart vbox hbox PackNatural 0
    mkShowButton hbox "erd(mm)" $ read a
    e <- entryNew
    e `on` entryActivate $ end a e
    
    containerAdd vbox e
    containerAdd window vbox
    widgetShowAll window
    window `on` unrealize $ mainQuit
    mainGUI
end a e = do
    hPutStr stderr a
    hPutStr stderr $ " "
    e' <- e `get` entryText
    hPutStrLn stderr e'
    mainQuit
