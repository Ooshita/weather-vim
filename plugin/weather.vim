" Vim global plugin for correcting typing mistakes
" Last Change:	2016 August 22
" Maintainer:   Noriaki Oshita <noriaki_oshita@whispon.com>

if exists("g:loaded_typecorr")
  finish
  endif
  let g:loaded_typecorr = 1
 
  let s:save_cpo = &cpo
  set cpo&vim

" デフォルトの土地は北海道の札幌になっています"
" http://weather.livedoor.com/weather_hacks/ にて自分の地域のURL(s:url)を設定してください
" 例:(東京) http://weather.livedoor.com/forecast/rss/area/130010.xml
  let s:url = 'http://weather.livedoor.com/forecast/rss/area/016010.xml'
function Weather()
 let l:cnt = 0
  for item in webapi#feed#parseURL(s:url)
    " 当日だけの情報を出力する
    if l:cnt == 1
      echo "  " item.title
    endif
    " カウント(cnt)として１を足す
    let l:cnt += 1
  endfor
endfunction

function WeatherDetail()
  let l:cnt = 0
  for item in webapi#feed#parseURL(s:url)
    " 最初のitem.titleは天気の情報ではないため除外する。
    if l:cnt != 0
      echo "  " item.title
    endif

    let l:cnt += 1
  endfor
endfunction

command! -nargs=? -range=% -bang -complete=customlist,s:CompleteArgs Weather :call Weather()
command! -nargs=? -range=% -bang -complete=customlist,s:CompleteArgs WeatherDetail :call WeatherDetail()

if !exists(":Correct")
  command -nargs=1  Correct  :call s:Add(<q-args>, 0)
endif

let &cpo = s:save_cpo
