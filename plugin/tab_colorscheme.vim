if exists('g:did_tab_colorscheme')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim




command! -nargs=0 TabColorSchemeDisable :let g:tab_colorscheme_is_disable = 1
command! -nargs=0 TabColorSchemeEnable  :let g:tab_colorscheme_is_disable = 0



augroup tab_colorscheme.vim
    autocmd!
    autocmd TabEnter * call <SID>:setColorscheme()
    autocmd TabLeave * call <SID>:memorizeColorscheme()
augroup end


function! s:isDisable()
    return exists('g:tab_colorscheme_is_disable')
    \           && g:tab_colorscheme_is_disable == 1
endfunction




function! <SID>:setColorscheme()
    if s:isDisable()
        return
    endif


    if exists('t:background')
        let &background = t:background
    end

    if exists('t:coloschme')
        execute 'colorscheme ' . t:coloschme
    end
    doautocmd ColorScheme
endfunction




function! <SID>:memorizeColorscheme()
    if s:isDisable()
        return
    endif

    let t:background = &background
    let t:coloschme  = s:getCmdResult('colorscheme')
endfunction




function! s:getCmdResult(cmd)
    redir => l:var
    call s:silentExecute(a:cmd)
    redir end
    return matchstr(l:var, '\n\zs.*\ze$')
endfunction


function! s:silentExecute(cmd)
    execute 'silent ' . a:cmd
endfunction




let &cpo = s:save_cpo
let g:did_tab_colorscheme = 1
