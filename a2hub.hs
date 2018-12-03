import System.IO
import Graphics.UI.Gtk
readSample = do
    r <- getContents
    return $ words r
main = do
    a:b:c:d:e:[] <- readSample
    print $ a:b:c:d:e:[] 
    let l = "2.6":b:c:d:e:[]
    putStrLn $ unwords l
    initGUI
    window  <- windowNew
    hbox <- hBoxNew False 0
    vbox <- vBoxNew False 0
    boxPackStart vbox hbox PackNatural 0
    ls <- mapM (\x -> labelNew (Just x)) l
    e <- entryNew
    e `on` entryActivate $ end l e
    
    mapM_ (containerAdd hbox) ls
    containerAdd vbox e
    containerAdd window vbox
    widgetShowAll window
    window `on` unrealize $ mainQuit
    mainGUI
end l e = do
    hPutStr stderr $ unwords l
    hPutStr stderr $ " "
    e' <- e `get` entryText
    hPutStrLn stderr e'
    mainQuit
