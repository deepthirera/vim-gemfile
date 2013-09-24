let s:plugin_path = expand("<sfile>:p:h:h")

if !exists("g:gem_open_command")
  let s:cmd = "bundle open {gem_source_filename}"

  if has("gui_running") && has("gui_macvim")
    let g:gem_open_command = "silent !" . s:plugin_path . "/bin/run_in_os_x_terminal '" . s:cmd . "'"
  else
    let g:gem_open_command = "!echo " . s:cmd . " && " . s:cmd
  endif
endif

function! InGemfile()
  return match(expand("%"), "Gemfile") != -1
endfunction

function! OpenTerminal(gem_filename)
  write
  execute substitute(g:gem_open_command, "{gem_source_filename}", a:gem_filename, "g")
endfunction

function! OpenGemFile()
  if InGemfile()
    let l:gem_filename = expand("<cword>")   
    call OpenTerminal(gem_filename)
  endif 
endfunction
