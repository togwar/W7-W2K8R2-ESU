mkdir "01 - Windows 7 Service Pack 1 (x64)"
wget.exe "https://catalog.s.download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe" -P "01 - Windows 7 Service Pack 1 (x64)",

mkdir "02 - Root Certificate Update (x64)"
wget.exe "https://download.microsoft.com/download/7/5/0/750698D5-74F3-48B5-A2BE-8564F68890CC/Windows6.1-KB3004394-v2-x64.msu" -P "02 - Root Certificate Update (x64)",

mkdir "03 - Servicing Stack Update - March 2019 (x64)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x64_d3de52d6987f7c8bdc2c015dca69eac96047c76e.msu" -P "03 - Servicing Stack Update - March 2019 (x64)"

mkdir "04 - SHA-2 Code Signing Support Update - September 2019 (x64)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x64_b5614c6cea5cb4e198717789633dca16308ef79c.msu" -P "04 - SHA-2 Code Signing Support Update - September 2019 (x64)"

mkdir "05 - Servicing Stack Update (x64)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x64_87f81056110003107fa0e0ec35a3b600ef300a14.msu" -P "05 - Servicing Stack Update (x64)"

mkdir "06 - Windows Update Agent (x64)"
wget.exe "http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/windowsupdateagent-7.6-x64.exe" -P "06 - Windows Update Agent (x64)"

mkdir "07 - Speedup Patches - Update Rollup (x64)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2016/07/windows6.1-kb3179573-x64_0ec541490b3f7b02e41f26cb2c444cbd9e13df4d.msu" -P "07 - Speedup Patches - Update Rollup (x64)"

mkdir "08 - Latest Extended Servicing Stack Update - May 2020 (x64)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows6.1-kb4555449-x64_92202202c3dee2f713f67adf6622851b998c6780.msu" -P "08 - Latest Extended Servicing Stack Update - May 2020 (x64)"

mkdir "09 - ESU Licensing Preparation Package (x64)"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/07/windows6.1-kb4575903-x64_b4d5cf045a03034201ff108c2802fa6ac79459a1.msu" -P "09 - ESU Licensing Preparation Package (x64)"

echo DESEJA CONTINUAR COM DOWNLOADS OPCIONAIS?
pause

mkdir "11 - (Optional) KB3108210"
wget.exe "https://download.microsoft.com/download/F/A/A/FAABD5C2-4600-45F8-96F1-B25B137E3C87/Windows6.1-KB3102810-x64.msu" -P "11 - (Optional) KB3108210"

mkdir "12 - (Optional) KB5013637"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/04/windows6.1-kb5013637-x64_9adc2154ff84511c2dd3aeebab9594999b5c7297.msu" -P "12 - (Optional) KB5013637"

mkdir "12 - (Optional) KB5020861"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/11/windows6.1-kb5020861-x64_9df527e79d8854a4ed1b8fe26c2a66bca7d6b8da.msu" -P "12 - (Optional) KB5020861"

mkdir "13 - (Optional) KB5017397"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/09/windows6.1-kb5017397-x64_2a9999bd20cb964869c59bb16841a76e14030a29.msu" -P "13 - (Optional) KB5017397"

mkdir "14 - (Optional) KB4578952"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/10/windows6.1-kb4578952-x64_30ac0df8554c2647017f3b36cc02e833a3187364.msu" -P "14 - (Optional) KB4578952"

mkdir "15 - (Optional) KB5022338"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/01/windows6.1-kb5022338-x64_75d100c03bcaee4b62d08004cc382337ed09d327.msu" -P "15 - (Optional) KB5022338"

mkdir "15 - (Optional) KB5010798"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2022/01/windows6.1-kb5010798-x64_6f690ddb42ab85d3dcac7e6b34e16eb70df6e477.msu" -P "15 - (Optional) KB5010798"
