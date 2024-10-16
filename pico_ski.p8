pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- slalom to victory
-- inspired by taito's alpine ski
#include main.lua
#include misc.lua
#include player.lua
#include menu.lua
#include transition.lua
#include level_1.lua
#include level_2.lua
#include game_over.lua
__gfx__
00000000000000000000000000003333333330000000000000000000000000033330000000007770000000000000000000000000000000000000000000000000
00000000000000000000000000333337337333300000007777700000003000777770000000007777777700000000000000000000000000000000000000000000
00000000000000000000000000337333333333300000007773770000003300077730000000737733337770000000000000000000000000000000000000000000
00000000000000000000000033333333333373300000077443340000000333033330730007737733733377000000000000000000000000000000000000000000
00000000000000000000000037333344433733330000077444330000077003333733770007337733373737700000000000000000000000000000000000000000
00000000000000000000000033337334433333330000777444430000037777333770333077333337333733000000000000000000000000000000000000000000
00000000000000000000000033333444444443330000744444433000003333304373303303377333733373300000000000000000000000000000000000000000
00000000000000000000000033334444444447330000744444447700000773344333333003773333777773300000000000000000000000000000000000000000
08000080000000000000000033334444444403330007744444443770077773343377773333333333377773330000000000000000000000000000000000000000
08000080000000000000000000004444444000330077334774444370037733044377000033337733333333330000000000000000000000000000000000000000
080aa080000000000000000000000444440000330773347777777777333033344337773003377337733377700000000000000000000000000000000000000000
087bb780000000000000000000000044440000337773477757774777033330344033377033773777737777300000000000000000000000000000000000000000
040aa040000000000000000000000044440000007444477744445777000003344300333033733334403373300000000000000000000000000000000000000000
48a00a84000000000000000000000044440000004433335444445544000330044330000033333304400333000000000000000000000000000000000000000000
08000080000000000000000000000044440000004444445444445534003300044003300000330004400003000000000000000000000000000000000000000000
08000080000000000000000000000044440000004444445444445433000000044000000000000004400000000000000000000000000000000000000000000000
00000000000400000000400000000000000000000000000000000000000800000000800008000000000800000000000800000000000000000000000000000000
00000000004400000000440000000000000000000000000000000000008800000000880088000000008800000800000880000000000000000000000000000000
00000000004400eeee00440000000000000000000000000000000000008800aaaa00880008800aaaa008000008800aaaa8000000000000000000000000000000
00000000004400eeee00440000000000000000000000000000000000008800aaaa00880008800aaaa008800000800aaaa8800000000000000000000000000000
00000000004400eeee00440000000000000000000000000000000000008800aaaa00880000880aaaa008800000880aaaa0800000000000000000000000000000
0000000000477888888774000000000000000000000000000000000000877bbbbbb77800008877bbbb778800000877bbb7780000000000000000000000000000
00000000044400888800440000000000000000000000000000000000004800bbbb008400008400bbbb004800000480bbb0048000000000000000000000000000
00000000404400bbbb00444000000000000000000000000000000000048800aaaa008840004800aaaa0084000048800aaa084800000000000000000000000000
0000000000440bbbbbb044040000000000000000000000000000000040880aaaaaa08804040880aaaaa008400400880aaaaad400000000000000000000000000
00000000004d0b0000b0d40000000000000000000000000000000000008d0a0000a0d8004008d0a000aa0d844000080aa000d840000000000000000000000000
00000000004db000000bd40000000000000000000000000000000000008da000000ad8000008da00000aad8000000dda00000884000000000000000000000000
00000000004400000000440000000000000000000000000000000000008800000000880000088000000008800000088000000080000000000000000000000000
00000000004400000000440000000000000000000000000000000000008800000000880000088000000008800000008800000080000000000000000000000000
00000000004400000000440000000000000000000000000000000000008800000000880000008800000000880000000800000088000000000000000000000000
00000000004400000000440000000000000000000000000000000000008800000000880000008800000000880000000880000008000000000000000000000000
00000000004400000000440000000000000000000000000000000000008800000000880000008800000000880000000080000008000000000000000000000000
00000000077777777777700000000000440000000000000044000000000000000000000000000000000000000000000000000000000000000000000000000000
00000007777777777777777777000000448800000000000044110000000000000000000000000000000000000000000000000000000000000000000000000000
000007777777777dddddd77777770000448888000000000044111100000000000000000000000000000000000000000000000000000000000000000000000000
000777777777777ddddddddddd777000448888880000000044111111000000000000000000000000000000000000000000000000000000000000000000000000
0077777777777ddddddaddddddd77700448888888800000044111111110000000000000000000000000000000000000000000000000000000000000000000000
007777777777ddddddadddddddd77700448888888888000044111111111100000000000000000000000000000000000000000000000000000000000000000000
0077777777dddddddaddddddddd77700448888888888800044111111111110000000000000000000000000000000000000000000000000000000000000000000
007777777dddddddadddddddddd77700448888888888000044111111111100000000000000000000000000000000000000000000000000000000000000000000
0777777ddddddddadddddddadddd7700448888888800000044111111110000000000000000000000000000000000000000000000000000000000000000000000
077777ddddddddadddddddaddddd7700448888880000000044111111000000000000000000000000000000000000000000000000000000000000000000000000
07777ddddddddadddddddadddddd7700448888000000000044111100000000000000000000000000000000000000000000000000000000000000000000000000
0777ddddddddadddddddaddddddd7700448800000000000044110000000000000000000000000000000000000000000000000000000000000000000000000000
0777dddddddadddddddaddddddd77700440000000000000044000000000000000000000000000000000000000000000000000000000000000000000000000000
077dddddddadddddddaddddddd777700440000000000000044000000000000000000000000000000000000000000000000000000000000000000000000000000
777ddddddddddddddadddddddd777700440000000000000044000000000000000000000000000000000000000000000000000000000000000000000000000000
777dddddddddddddadddddddddd77700440000000000000044000000000000000000000000000000000000000000000000000000000000000000000000000000
777ddddddddddddaddddddddddddd700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
777dddddddddddadddddddddddddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
777ddddddddddaddddddddddddddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
777dddddddddadddddddddddddddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
777ddddddddaddddddddddddddadd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77ddddddddaddddddddddddddaddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77dddddddaddddddddddddddadddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77ddddddaddddddddddddddaddddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07dddddaddddddddddddddadddddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
077dddaddddddddddddddadddddd7777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0777ddddddddddddddddaddddd777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777ddddddddddddddadddddd777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0077777dddddddddddaddd7777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000777777777777ddadddd7777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000777777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000101000000000000000000000000000001010000000000000000000000000808000000000808000000000000000008080000000008080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000000000000003805035050310502f0502c05029050260502405022050210501e0501c05019050170501405012050100500e0500b0500805006050030500105000000000000000000000000000000000000
