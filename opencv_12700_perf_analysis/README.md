# 12700 Linux E core and P core 
分析OpenCV perf 测试在12700 linux 上 Houghlines 和 Warpaffine 相关算子E 核速度比P 核速度快的原因,存在异常的算子包括Houghlines (640x480, 1, 0.1)， Warpaffine (1920x1080, 32FC3, INTER_LINEAR) 和 Warpaffine (3840x2160, 32FC3, INTER_LINEAR)
## Houghlines ()
### Houghlines (640x480, 1, 0.1)测试结果

<body link="#0563C1" vlink="#954F72">

<table border=0 cellpadding=0 cellspacing=0 width=283 style='border-collapse:
 collapse;table-layout:fixed;width:213pt'>
 <col width=64 style='width:48pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=64 style='width:48pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl65 width=117 style='height:15.0pt;width:88pt'>Linux</td>
  <td colspan=2 class=xl65 width=166 style='border-left:none;width:125pt'>Linux
  (add Timestamp)</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
  <td class=xl65 style='border-top:none;border-left:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>0.45 ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>0.44 ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>3.12ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>5.05ms</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=102 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>
### 增加负载
通过在‪opencv-4.8.0\modules\imgproc\src\hough.cpp 187行for 循环加入时间戳增加负载，见下面**add** 注释
```
for( i = 0; i < height; i++ )
        for( j = 0; j < width; j++ )
        {
            if( image[i * step + j] != 0 )
                for(int n = 0; n < numangle; n++ )
                {
                    
                    int r = cvRound( j * tabCos[n] + i * tabSin[n] );
                    
                    r += (numrho - 1) / 2;

                    auto start6 = std::chrono::high_resolution_clock::now();//add

                    accum[(n+1) * (numrho+2) + r+1]++;

                    auto end6 = std::chrono::high_resolution_clock::now();//add
                    std::chrono::duration<double, std::milli> tm6 = end6 - start6; //add
                    tt += tm6.count(); //add
                }
        }

```

## Warpaffine

<body link="#0563C1" vlink="#954F72">
<span style='font-variant-ligatures: normal;font-variant-caps: normal;
orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: 0px;
text-decoration-thickness: initial;text-decoration-style: initial;text-decoration-color: initial'>

<table border=0 cellpadding=0 cellspacing=0 width=845 style='border-collapse:
 collapse;table-layout:fixed;width:634pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=164 style='mso-width-source:userset;mso-width-alt:5997;width:123pt'>
 <col width=264 style='mso-width-source:userset;mso-width-alt:9654;width:198pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=64 style='width:48pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <tr height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl68 width=356 style='height:17.25pt;
  width:267pt'>(1920x1080, 32FC3, INTER_LINEAR)</span></td>
  <td colspan=4 class=xl68 width=489 style='border-left:none;width:367pt'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>(3840x2160,
  32FC3, INTER_LINEAR)</span></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl65 style='height:15.0pt'>Linux</td>
  <td colspan=2 class=xl65 style='border-left:none'>Linux (add Timestamp)</td>
  <td colspan=2 class=xl65 style='border-left:none'>Linux</td>
  <td colspan=2 class=xl65 style='border-left:none'>Linux (add Timestamp)</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
  <td class=xl65 style='border-top:none;border-left:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
  <td class=xl65 style='border-top:none;border-left:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
  <td class=xl65 style='border-top:none;border-left:none'>P</td>
  <td class=xl65 style='border-top:none;border-left:none'>E</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>20.18ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>20.06ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>27ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>31ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>90ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>83ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>118ms</td>
  <td class=xl65 style='border-top:none;border-left:none'>128ms</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=164 style='width:123pt'></td>
  <td width=264 style='width:198pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=108 style='width:81pt'></td>
 </tr>
 <![endif]>
</table>
</body>

### 增加负载
通过在‪opencv-4.8.0\modules\imgproc\src\imgwarp.cpp 1200行加时间戳增加负载，见下面**add** 注释
```
  #if CV_SIMD128
                        {
                            v_uint16x8 v_scale = v_setall_u16(INTER_TAB_SIZE2 - 1);
                            int span = v_uint16x8::nlanes;
                            for (; x1 <= bcols - span; x1 += span) {
                                auto start0 = std::chrono::high_resolution_clock::now();//add
                                v_store((unsigned short*)(A + x1), v_load(sA + x1) & v_scale);
                                auto end0 = std::chrono::high_resolution_clock::now();//add
                                std::chrono::duration<double, std::nano> tm123 = end0 - start0;//add
                                t_remap += tm123.count();//add

                                //count_remapinvoker += 1;
                                //std::cout << "count_remapinvoker :" << count_remapinvoker << std::endl;
                            }
                        }
                        #endif
```
## 总结
12700 Linux 上算子的负载较低，P核不能发挥出比E核性能好的优势



