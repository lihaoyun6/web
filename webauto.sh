#!/bin/bash
bver=$(sw_vers -buildVersion)
pver=$(sw_vers -productVersion)
pname=$(sw_vers -productName)
index=0
curl -# "https://gfe.nvidia.com/mac-update" > /tmp/mac-update.plist
	if [[ $(test -f /tmp/mac-update.plist && echo 1) ]]
	then
		while [[ $(/usr/libexec/PlistBuddy -c "Print :updates:"$index":OS" /tmp/mac-update.plist 2>/dev/null && echo 1) ]];
		do
			if [[ $(/usr/libexec/PlistBuddy -c "Print :updates:"$index":OS" /tmp/mac-update.plist) == "$bver" ]]
			then
				download_url=$(/usr/libexec/PlistBuddy -c "Print :updates:"$index":downloadURL" /tmp/mac-update.plist)
				download_version=$(/usr/libexec/PlistBuddy -c "Print :updates:"$index":version" /tmp/mac-update.plist)
				break
			else
				let index++
			fi
		done
	fi
if [[ "$download_version" == "" ]] || [[ "$download_url" == "" ]]
	then
		index=0
		curl -# "https://raw.githubusercontent.com/lihaoyun6/web/master/mac-update.plist" > /tmp/mac-update.plist
		if [[ $(test -f /tmp/mac-update.plist && echo 1) ]]
		then
			while [[ $(/usr/libexec/PlistBuddy -c "Print :updates:"$index":OS" /tmp/mac-update.plist 2>/dev/null && echo 1) ]];
			do
				if [[ $(/usr/libexec/PlistBuddy -c "Print :updates:"$index":OS" /tmp/mac-update.plist) == "$bver" ]]
				then
					download_url=$(/usr/libexec/PlistBuddy -c "Print :updates:"$index":downloadURL" /tmp/mac-update.plist)
					download_version=$(/usr/libexec/PlistBuddy -c "Print :updates:"$index":version" /tmp/mac-update.plist)
					break
				else
					let index++
				fi
			done
		fi
		if [[ "$download_version" == "" ]] || [[ "$download_url" == "" ]]
		then
		echo "未能从NVIDIA官方服务器中找到适用于 $(echo $pname|tr -d '\n') $(echo $pver|tr -d '\n') $(echo $bver|tr -d '\n') 系统的WebDriver."
		exit
		fi
fi
curl -# -k -o /tmp/WebDriver-"$download_version".pkg $download_url
pkgutil --expand /tmp/WebDriver-"$download_version".pkg /tmp/expanded.pkg
sed -i '' -E "s/if \(\!validateHardware\(\)\) return false;/\/\/if \(\!validateHardware\(\)\) return false;/g" /tmp/expanded.pkg/Distribution
sed -i '' -E "s/if \(\!validateSoftware\(\)\) return false;/\/\/if \(\!validateSoftware\(\)\) return false;/g" /tmp/expanded.pkg/Distribution
pkgutil --flatten /tmp/expanded.pkg ~/Desktop/WebDriver-"$download_version"-无限制.pkg
rm -rf /tmp/expanded.pkg
rm -rf /tmp/WebDriver-"$download_version".pkg
echo "成功下载并移除 WebDriver 的安装限制，并已复制到桌面。"