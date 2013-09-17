if exists('g:loded_tab_colorscheme')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim




command! -nargs=0 TabColorSchemeDisable :let g:tab_colorscheme_is_disable = 1
command! -nargs=0 TabColorSchemeEnable  :let g:tab_colorscheme_is_disable = 0




augroup tab_colorscheme.vim
    autocmd!
    autocmd TabEnter * call <SID>:setColorscheme()
    autocmd TabLeave * call <SID>:saveColorscheme()
augroup end




function! s:setColorscheme()
    if s:isDisable()
        return
    endif


    if exists('t:background')
        let &background = t:background
    end

    if exists('t:coloschme')
        execute 'colorscheme ' . t:coloschme
    end

    if get(g:, 'tab_colorscheme_transparency', 1) == 1
    \       && exists('t:transparency')
        let &transparency = t:transparency
    endif

    doautocmd ColorScheme
endfunction


function! s:saveColorscheme()
    if s:isDisable()
        return
    endif

    let t:background = &background
    let t:coloschme  = s:getCmdResult('colorscheme')
    let t:transparency = &transparency
endfunction




function! s:isDisable()
    return get(g:, 'tab_colorscheme_is_disable', 0) == 1
endfunction


function! s:getCmdResult(cmd)
    redir => l:var
    call s:silentExecute(a:cmd)
    redir end
    return l:var[1:-1]
endfunction


function! s:silentExecute(cmd)
    execute 'silent ' . a:cmd
endfunction




let &cpo = s:save_cpo
let g:loded_tab_colorscheme = 1
