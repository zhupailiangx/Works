# OpenCV MatchTemplate 算子Linux和Windows性能差异分析
分析方式:安装方式和Vtune

## Windows 安装
(1) https://github.com/opencv/opencv/releases/tag/4.5.5 中下载exe文件安装

(2)
```
download source code
open cmd
cd <opencv code dir>
mkdir build
cd build
cmake -D WITH_IPP=ON/OFF ..
open OpenCV.sln with Visual Studio 
Select install and build
```
## Linux 安装
(1) sudo apt install libopencv-dev

(2)
```
cd <opencv souce code dir>
mkdir build
cd build
cmake -D WITH_IPP=NO/OFF ..
make -j8
sudo make install
```
### MatchTemplate测试结果
<body link="#0563C1" vlink="#954F72">

<table border=0 cellpadding=0 cellspacing=0 width=966 style='border-collapse:
 collapse;table-layout:fixed;width:725pt'>
 <col width=64 style='width:48pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=184 style='mso-width-source:userset;mso-width-alt:6729;width:138pt'>
 <col width=180 style='mso-width-source:userset;mso-width-alt:6582;width:135pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=180 span=2 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <tr height=20 style='height:15.0pt'>
  <td colspan=7 height=20 class=xl76 width=966 style='height:15.0pt;width:725pt'>MatchTemplate</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl68 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl76 style='border-left:none'>Linux</td>
  <td colspan=3 class=xl76 style='border-left:none'>Windows</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl68 style='height:15.0pt;border-top:none'>Loop</td>
  <td class=xl72 style='border-top:none;border-left:none'>libopencv-dev</td>
  <td class=xl68 style='border-top:none;border-left:none'>Source code:
  WITH_IPP=OFF</td>
  <td class=xl68 style='border-top:none;border-left:none'>Source code:
  WITH_IPP=ON</td>
  <td class=xl72 style='border-top:none;border-left:none'>exe&#23433;&#35013;</td>
  <td class=xl68 style='border-top:none;border-left:none'>Source code:
  WITH_IPP=OFF</td>
  <td class=xl68 style='border-top:none;border-left:none'>Source code:
  WITH_IPP=ON</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>1</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.955</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>&nbsp;33.821&nbsp;</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>11.969&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>13.025</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;32.068&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>12.727</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>2</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;33.096</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.687&nbsp;</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.572</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.083</td>
  <td class=xl69 style='border-top:none;border-left:none'>31.659</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.319</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>3</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.122</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.656</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.413</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.847</td>
  <td class=xl69 style='border-top:none;border-left:none'>31.753</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.297</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>4</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.185</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.632</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.561</td>
  <td class=xl69 style='border-top:none;border-left:none'>12.067&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;31.333</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.595</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>5</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.057</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.69</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.485</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.203</td>
  <td class=xl69 style='border-top:none;border-left:none'>32.464</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.239</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>6</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.058</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.626</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.574</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.896&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>31.516</td>
  <td class=xl69 style='border-top:none;border-left:none'>12.118</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>7</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.074</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.507</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.61</td>
  <td class=xl69 style='border-top:none;border-left:none'>12.263</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.159</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.787&nbsp;</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>8</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.19</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.732</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.513&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>12.429</td>
  <td class=xl69 style='border-top:none;border-left:none'>31.737</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.843</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>9</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.261</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.554</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.53</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.097</td>
  <td class=xl69 style='border-top:none;border-left:none'>32.896&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.408</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt;border-top:none'>10</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.141</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.514</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.591</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.662</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;32.580&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>12.206</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl68 style='height:17.25pt;border-top:none'>mean</td>
  <td class=xl69 style='border-top:none;border-left:none'>33.214</td>
  <td class=xl69 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.742</span></td>
  <td class=xl69 style='border-top:none;border-left:none'>10.682</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.857</td>
  <td class=xl69 style='border-top:none;border-left:none'>32.116</td>
  <td class=xl69 style='border-top:none;border-left:none'>11.754</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=184 style='width:138pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
 </tr>
 <![endif]>
</table>

</body>

## Vtune 分析
### windows exe 

![image](https://github.com/zhupailiangx/Works/assets/120553507/f8e7857d-4658-473b-984b-9bfc5caf9edd)

### windows souece code WITH_IPP=OFF

![image](https://github.com/zhupailiangx/Works/assets/120553507/d94cfefe-7c90-4b49-b738-034cab94b260)

### windows souce code WITH_IPP=ON


![image](https://github.com/zhupailiangx/Works/assets/120553507/559be1b3-65bc-425a-9f0c-cb03aa8bb995)

### Linux WITH_IPP=OFF/ON
![Screenshot from 2023-07-13 08-16-21](https:/![Screenshot from 2023-07-14 05-00-43](https://github.com/zhupailiangx/Works/assets/120553507/063a9f7f-2aa7-4b1a-9243-38a7f4e4d3b4)
## 其他

https://www.cnblogs.com/tt2015-sz/p/4654470.html#:~:text=%E6%B3%A8%E6%84%8F%EF%BC%9A%E8%BF%99%E9%87%8Cipp,%E5%90%8E%E9%9D%A2%E4%B8%8D%E5%B8%A6d%E5%93%A6~~

### Windows exe安装opencv_world455.dll PE Sections

![image](https://github.com/zhupailiangx/Works/assets/120553507/1529d029-4a8f-4c05-9c49-da1054a4efeb)

### windwos 源码安装报错
![image](https://github.com/zhupailiangx/Works/assets/120553507/827c75c1-c88f-4949-9dc5-e9971e9c7bbe)
