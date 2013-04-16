if exists('g:did_tagColorscheme')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim




command! -nargs=0 TabColorSchemeDisable :let g:tab_colorscheme_is_disable = 0
command! -nargs=0 TabColorSchemeEnable  :let g:tab_colorscheme_is_disable = 1



augroup tab_colorscheme.vim
    autocmd!
    autocmd TabEnter * call <SID>:executeTabColorScheme()
    autocmd TabLeave * call <SID>:setTabColorScheme()
augroup end


function! s:isDisable()
    return exists('g:tab_colorscheme_is_disable')
    \           && g:tab_colorscheme_is_disable == 1
endfunction




function! <SID>:executeTabColorScheme()
    if s:isDisable()
        return
    endif

    if exists('t:coloschme')
        execute 'colorscheme ' . t:coloschme
    end

    if exists('t:background')
        execute 'set background=' . t:background
    end
endfunction




function! <SID>:setTabColorScheme()
    if s:isDisable()
        reutrn
    endif

    let t:background = &background
    let t:coloschme  = s:getCmdResult('colorscheme')
endfunction




function! s:getCmdResult(cmd)
    redir => l:var
    call s:silentExecute(a:cmd)
    redir end
    return matchstr(l:var, '\n*\zs.*\ze$')
endfunction


function! s:silentExecute(cmd)
    execute 'silent ' . a:cmd
endfunction




let &cpo = s:save_cpo

let g:did_tagColorscheme = 1
