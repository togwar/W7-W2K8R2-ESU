mkdir "01 - Windows 7 Service Pack 1 (x86)"
wget.exe "https://catalog.s.download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe" -P "01 - Windows 7 Service Pack 1 (x86)"

mkdir "02 - Root Certificate Update (x86)"
wget.exe "https://download.microsoft.com/download/0/4/7/0473DB9B-16DE-41C6-A02A-4CBEEB04E777/Windows6.1-KB3004394-v2-x86.msu" -P "02 - Root Certificate Update (x86)"

mkdir "03 - Servicing Stack Update - March 2019 (x86)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x86_3cdb3df55b9cd7ef7fcb24fc4e237ea287ad0992.msu" -P "03 - Servicing Stack Update - March 2019 (x86)"

mkdir "04 - SHA-2 Code Signing Support Update - September 2019 (x86)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x86_0f687d50402790f340087c576886501b3223bec6.msu" -P "04 - SHA-2 Code Signing Support Update - September 2019 (x86)"

mkdir "05 - Servicing Stack Update (x86)"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x86_f3b49481187651f64f13a0369c86ad7caa83b190.msu" -P "05 - Servicing Stack Update (x86)"

mkdir "06 - Windows Update Agent (x86)"
wget.exe "http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/WindowsUpdateAgent-7.6-x86.exe" -P "06 - Windows Update Agent (x86)"

mkdir "07 - Speedup Patches - Update Rollup (x86)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2016/07/windows6.1-kb3179573-x86_e972000ff6074d1b0530d1912d5f3c7d1b057c4a.msu" -P "07 - Speedup Patches - Update Rollup (x86)"

mkdir "08 - Latest Extended Servicing Stack Update - May 2020 (x86)"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows6.1-kb4555449-x86_36683b4af68408ed268246ee3e89772665572471.msu" -P "08 - Latest Extended Servicing Stack Update - May 2020 (x86)"

mkdir "09 - ESU Licensing Preparation Package (x86)"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/07/windows6.1-kb4575903-x86_5905c774f806205b5d25b04523bb716e1966306d.msu" -P "09 - ESU Licensing Preparation Package (x86)"

echo DESEJA CONTINUAR COM DOWNLOADS OPCIONAIS?
pause

mkdir "11 - (Optional) KB3108210"
wget.exe "https://download.microsoft.com/download/A/0/9/A09BC0FD-747C-4B97-8371-1A7F5AC417E9/Windows6.1-KB3102810-x86.msu" -P "11 - (Optional) KB3108210"

mkdir "12 - (Optional) KB5013637"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/04/windows6.1-kb5013637-x86_38e65611a167a7acb7c692e351b95d374ee75579.msu" -P "12 - (Optional) KB5013637"

mkdir "12 - (Optional) KB5020861"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/11/windows6.1-kb5020861-x86_475b218e81e20dedb69884e7c00d0a8bf36cebf9.msu" -P "12 - (Optional) KB5020861"

mkdir "13 - (Optional) KB5017397"
wget.exe "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/09/windows6.1-kb5017397-x86_96b91eb53575a201d59b1a2b540aa15df0d23b3a.msu" -P "13 - (Optional) KB5017397"

mkdir "14 - (Optional) KB4578952"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/10/windows6.1-kb4578952-x86_7246565d7fec14ad0381deac93faef3024068eb6.msu" -P "14 - (Optional) KB4578952"

mkdir "15 - (Optional) KB5022338"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/01/windows6.1-kb5022338-x86_490dce532d299588e11abf3790ff1600482525cd.msu" -P "15 - (Optional) KB5022338"

mkdir "15 - (Optional) KB5010798"
wget.exe "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows6.1-kb5010798-x86_3c5d6092c9c3f20f3ae0333fa8f5ed12298c4e6a.msu" -P "15 - (Optional) KB5010798"