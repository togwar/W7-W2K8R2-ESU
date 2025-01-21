wusa.exe "02 - Root Certificate Update (x64)/Windows6.1-KB3004394-v2-x64.msu" /quiet /norestart
rmdir "02 - Root Certificate Update (x64)" /s /q
wusa.exe "03 - Servicing Stack Update - March 2019 (x64)/windows6.1-kb4490628-x64_d3de52d6987f7c8bdc2c015dca69eac96047c76e.msu" /quiet /norestart
rmdir "03 - Servicing Stack Update - March 2019 (x64)" /s /q
wusa.exe "04 - SHA-2 Code Signing Support Update - September 2019 (x64)/windows6.1-kb4474419-v3-x64_b5614c6cea5cb4e198717789633dca16308ef79c.msu" /quiet /norestart
rmdir "04 - SHA-2 Code Signing Support Update - September 2019 (x64)" /s /q
wusa.exe "05 - Servicing Stack Update (x64)/windows6.1-kb4536952-x64_87f81056110003107fa0e0ec35a3b600ef300a14.msu" /quiet /norestart
rmdir "05 - Servicing Stack Update (x64)" /s /q
"06 - Windows Update Agent (x64)/windowsupdateagent-7.6-x64.exe" /quiet
rmdir "06 - Windows Update Agent (x64)" /s /q
wusa.exe "07 - Speedup Patches - Update Rollup (x64)/windows6.1-kb3179573-x64_0ec541490b3f7b02e41f26cb2c444cbd9e13df4d.msu" /quiet /norestart
rmdir "07 - Speedup Patches - Update Rollup (x64)" /s /q
wusa.exe "08 - Latest Extended Servicing Stack Update - May 2020 (x64)/windows6.1-kb4555449-x64_92202202c3dee2f713f67adf6622851b998c6780.msu" /quiet /norestart
rmdir "08 - Latest Extended Servicing Stack Update - May 2020 (x64)" /s /q
wusa.exe "09 - ESU Licensing Preparation Package (x64)/windows6.1-kb3138612-x64_f7b1de8ea7cf8faf57b0138c4068d2e899e2b266.msu" /quiet /norestart
rmdir "09 - ESU Licensing Preparation Package (x64)" /s /q
wusa.exe "09 - ESU Licensing Preparation Package (x64)/windows6.1-kb4575903-x64_b4d5cf045a03034201ff108c2802fa6ac79459a1.msu" /quiet /norestart
rmdir "09 - ESU Licensing Preparation Package (x64)" /s /q