
## Houghlines测试结果

<table border=0 cellpadding=0 cellspacing=0 width=507 style='border-collapse:
 collapse;table-layout:fixed;width:380pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=187 style='mso-width-source:userset;mso-width-alt:6838;width:140pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl65 width=128 style='height:15.0pt;width:96pt'>Linux</td>
  <td colspan=2 class=xl65 width=251 style='border-left:none;width:188pt'>Linux
  (add Timestamp)</td>
  <td colspan=2 class=xl66 width=128 style='border-right:.5pt solid black;
  border-left:none;width:96pt'>Windows</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
  <td class=xl65 style='border-top:none;border-left:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
  <td class=xl65 style='border-top:none;border-left:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>0.45 ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>0.44 ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>3.12ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>5.05ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>0.22ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>0.37ms</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

1. Windows 在cvRound 函数中使用了SIMD 所以比Linux快。
2.  Linux 上该算子的负载较低，P 核和E 核上该算子的性能相近，可以看到加入了计时代码，性能就有了差距。

## Windows E core
![image](https://github.com/zhupailiangx/Works/assets/120553507/27507c6b-a4bc-4ab2-8211-3d8ecf2f8a38)

## Windows P core
![image](https://github.com/zhupailiangx/Works/assets/120553507/206bb5b0-16bc-4eb9-a31c-0311c9bce32c)

