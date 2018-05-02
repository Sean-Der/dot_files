if !exists('g:neomake_rust_cargo_maker_loaded')
  function PostprocessCargoMarker(entry)
      let l:lines = split(a:entry.text, ' ')
      if len(l:lines)
          let a:entry.text = join(l:lines[1:])
          let a:entry.length = str2nr(l:lines[0])
      endif
  endfunction

  function MapexprCargoMarker(val)
      if a:val[0] !=# '{'
          return
      endif
      let l:decoded = neomake#utils#JSONdecode(a:val)
      let l:data = get(l:decoded, 'message', -1)
      if type(l:data) == type({}) && len(l:data['spans'])
          let l:code_dict = get(l:data, 'code', -1)

          if l:code_dict is g:neomake#compat#json_null
              if get(l:data, 'level', '') ==# 'warning'
                  let l:code = 'W'
              else
                  let l:code = 'E'
              endif
          else
              let l:code = l:code_dict['code']
          endif
          let l:message = l:data['message']
          let l:span = l:data['spans'][0]
          let l:detail = l:span['label']
          let l:col = l:span['column_start']
          let l:row = l:span['line_start']
          let l:file = l:span['file_name']
          let l:length = l:span['byte_end'] - l:span['byte_start']
          let l:error = '[' . l:code . '] "' . l:file . '" ' .
                      \ l:row . ':' . l:col .  ' ' . l:length . ' ' .
                      \ l:message
          if type(l:detail) == type('') && len(l:detail)
              let l:error = l:error . ': ' . l:detail
          endif
          return l:error
      endif
  endfunction

  let g:neomake_rust_cargo_maker = {
          \ 'args': ['test', '--no-run', '--message-format=json', '--quiet'],
          \ 'append_file': 0,
          \ 'errorformat':
              \ '[%t%n] "%f" %l:%v %m,'.
              \ '[%t] "%f" %l:%v %m',
          \ 'mapexpr': 'MapexprCargoMarker(v:val)',
          \ 'postprocess': function('PostprocessCargoMarker')
          \ }
endif

let g:neomake_rust_cargo_maker_loaded = 1
let g:neomake_rust_enabled_makers = ['cargo']
let g:rustfmt_autosave = 1
