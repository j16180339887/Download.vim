function! DownloadFile(url)
  if has("gui_running") && (has("win32") || has("win64"))
    set shell=powershell.exe
    set shellcmdflag=-command
    exe "!Invoke-WebRequest -uri ".a:url." -outfile $(split-path -path ".a:url." -leaf)"
  elseif executable("python2")
    let flname = fnamemodify(a:url, ":t")
    exe "!python2 -c \"import urllib; urllib.urlretrieve('".a:url."', './".flname."')\""
  elseif executable("python3")
    let flname = fnamemodify(a:url, ":t")
    exe "!python3 -c \"import urllib.request; urllib.request.urlretrieve('".a:url."', './".flname."')\""
  elseif executable("curl")
    exe "!curl -sLOC - ".a:url
  elseif executable("wget")
    exe "!wget ".a:url
  elseif executable("axel")
    exe "!axel ".a:url
  elseif executable("aria2c")
    exe "!aria2c ".a:url
  else
    echom "Please install a downloader first, ex. curl, wget or aria2"
  endif
endfunction
command! -nargs=1 Download call DownloadFile(<f-args>)
