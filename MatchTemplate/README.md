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

<table border=0 cellpadding=0 cellspacing=0 width=775 style='border-collapse:
 collapse;table-layout:fixed;width:581pt'>
 <col width=64 style='width:48pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=175 style='mso-width-source:userset;mso-width-alt:6400;width:131pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=180 span=2 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <tr height=20 style='height:15.0pt'>
  <td colspan=6 height=20 class=xl72 width=775 style='height:15.0pt;width:581pt'>MatchTemplate</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl71 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl72 style='border-left:none'>Linux</td>
  <td colspan=3 class=xl72 style='border-left:none'>Windows</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl71 style='height:15.0pt;border-top:none'>Loop</td>
  <td class=xl76 style='border-top:none;border-left:none'>libopencv-dev</td>
  <td class=xl71 style='border-top:none;border-left:none'>Source code:
  WITH_IPP=ON</td>
  <td class=xl76 style='border-top:none;border-left:none'>exe&#23433;&#35013;</td>
  <td class=xl71 style='border-top:none;border-left:none'>Source code:
  WITH_IPP=OFF</td>
  <td class=xl71 style='border-top:none;border-left:none'>Source code:
  WITH_IPP=ON</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>1</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.955</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.969&nbsp;</span></td>
  <td class=xl75 style='border-top:none;border-left:none'>13.025</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>&nbsp;32.068&nbsp;</span></td>
  <td class=xl73 style='border-top:none;border-left:none'>12.727</td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>2</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>&nbsp;33.096</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>10.572</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.083</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>31.659</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.319</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>3</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.122</span></td>
  <td class=xl73 style='border-top:none;border-left:none'>10.413</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.847</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>31.753</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.297</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>4</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.185</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>10.561</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>12.067&nbsp;</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>&nbsp;31.333</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.595</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>5</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.057</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>10.485</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.203</span></td>
  <td class=xl73 style='border-top:none;border-left:none'>32.464</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.239</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>6</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.058</span></td>
  <td class=xl73 style='border-top:none;border-left:none'>10.574</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.896&nbsp;</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>31.516</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>12.118</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>7</td>
  <td class=xl73 style='border-top:none;border-left:none'>33.074</td>
  <td class=xl73 style='border-top:none;border-left:none'>10.61</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>12.263</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.159</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.787&nbsp;</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>8</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.19</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>10.513&nbsp;</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>12.429</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>31.737</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.843</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>9</td>
  <td class=xl73 style='border-top:none;border-left:none'>33.261</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>10.53</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.097</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.896&nbsp;</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.408</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl74 style='height:17.25pt;border-top:none'>10</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.141</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>10.591</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.662</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>&nbsp;32.580&nbsp;</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>12.206</span></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl71 style='height:17.25pt;border-top:none'>mean</td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>33.214</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>10.682</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.857</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>32.116</span></td>
  <td class=xl73 style='border-top:none;border-left:none'><span
  style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: initial;
  text-decoration-style: initial;text-decoration-color: initial'>11.754</span></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=175 style='width:131pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
 </tr>
 <![endif]>
</table>

## windows exe 
opencv match template took 13.025 milliseconds
opencv match template took 11.083 milliseconds
opencv match template took 11.847 milliseconds
opencv match template took 12.067 milliseconds
opencv match template took 11.203 milliseconds
opencv match template took 11.896 milliseconds
opencv match template took 12.263 milliseconds
opencv match template took 12.429 milliseconds
opencv match template took 11.097 milliseconds
opencv match template took 11.662 milliseconds
opencv     took average 11.857 milliseconds
![image](https://github.com/zhupailiangx/Works/assets/120553507/f8e7857d-4658-473b-984b-9bfc5caf9edd)

## windows souece code WITH_IPP=OFF
opencv match template took 32.068 milliseconds
opencv match template took 31.659 milliseconds
opencv match template took 31.753 milliseconds
opencv match template took 31.333 milliseconds
opencv match template took 32.464 milliseconds
opencv match template took 31.516 milliseconds
opencv match template took 33.159 milliseconds
opencv match template took 31.737 milliseconds
opencv match template took 32.896 milliseconds
opencv match template took 32.580 milliseconds
opencv     took average 32.116 milliseconds
![image](https://github.com/zhupailiangx/Works/assets/120553507/d94cfefe-7c90-4b49-b738-034cab94b260)

## windows souce code WITH_IPP=ON
opencv match template took 12.727 milliseconds
opencv match template took 11.319 milliseconds
opencv match template took 11.297 milliseconds
opencv match template took 11.595 milliseconds
opencv match template took 11.239 milliseconds
opencv match template took 12.118 milliseconds
opencv match template took 11.787 milliseconds
opencv match template took 11.843 milliseconds
opencv match template took 11.408 milliseconds
opencv match template took 12.206 milliseconds
opencv     took average 11.754 milliseconds

![image](https://github.com/zhupailiangx/Works/assets/120553507/559be1b3-65bc-425a-9f0c-cb03aa8bb995)

## Linux WITH_IPP=OFF
opencv match template took 33.821 milliseconds 
opencv match template took 32.687 milliseconds 
opencv match template took 32.656 milliseconds 
opencv match template took 32.632 milliseconds 
opencv match template took 32.690 milliseconds 
opencv match template took 32.626 milliseconds 
opencv match template took 32.507 milliseconds 
opencv match template took 32.732 milliseconds 
opencv match template took 32.554 milliseconds 
opencv match template took 32.514 milliseconds 
opencv     took average 32.742 milliseconds 
## 其他
![image](https://github.com/zhupailiangx/Works/assets/120553507/827c75c1-c88f-4949-9dc5-e9971e9c7bbe)

![Screenshot from 2023-07-13 08-16-21](https:/![Screenshot from 2023-07-14 05-00-43](https://github.com/zhupailiangx/Works/assets/120553507/063a9f7f-2aa7-4b1a-9243-38a7f4e4d3b4)
/github.com/zhupailiangx/Works/assets/120553507/35179a4b-602b-4f0a-891a-c9953257d663)
![image](https://github.com/zhupailiangx/Works/assets/120553507/1529d029-4a8f-4c05-9c49-da1054a4efeb)
