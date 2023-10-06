#!/bin/bash

: '
 █████╗ ██████╗ ██████╗ ██╗     ███████╗     ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗██╗     ██╗███████╗████████╗
██╔══██╗██╔══██╗██╔══██╗██║     ██╔════╝    ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██║     ██║██╔════╝╚══██╔══╝
███████║██████╔╝██████╔╝██║     █████╗      ██║     ███████║█████╗  ██║     █████╔╝ ██║     ██║███████╗   ██║   
██╔══██║██╔═══╝ ██╔═══╝ ██║     ██╔══╝      ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ██║     ██║╚════██║   ██║   
██║  ██║██║     ██║     ███████╗███████╗    ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗███████╗██║███████║   ██║   
╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚══════╝     ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝   
                                                                                                                
                                                                                                                
                                                                                                                                                                                                                                                                                                                                 
                                                                                                                
 █████╗ ██╗   ██╗████████╗██╗  ██╗ ██████╗ ██████╗             ██╗ █████╗      ██╗                              
██╔══██╗██║   ██║╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██╗         ██║██╔══██╗     ██║                              
███████║██║   ██║   ██║   ███████║██║   ██║██████╔╝╚═╝         ██║███████║     ██║                              
██╔══██║██║   ██║   ██║   ██╔══██║██║   ██║██╔══██╗██╗    ██   ██║██╔══██║██   ██║                              
██║  ██║╚██████╔╝   ██║   ██║  ██║╚██████╔╝██║  ██║╚═╝    ╚█████╔╝██║  ██║╚█████╔╝                              
╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝        ╚════╝ ╚═╝  ╚═╝ ╚════╝                               
                                                                                                                
██╗   ██╗ ██╗    ██████╗      ██╗ ██████╗     ██╗██████╗     ██╗██████╗ ██████╗                                 
██║   ██║███║   ██╔═████╗    ███║██╔═████╗   ██╔╝╚════██╗   ██╔╝╚════██╗╚════██╗                                
██║   ██║╚██║   ██║██╔██║    ╚██║██║██╔██║  ██╔╝  █████╔╝  ██╔╝  █████╔╝ █████╔╝                                
╚██╗ ██╔╝ ██║   ████╔╝██║     ██║████╔╝██║ ██╔╝  ██╔═══╝  ██╔╝  ██╔═══╝  ╚═══██╗                                
 ╚████╔╝  ██║██╗╚██████╔╝     ██║╚██████╔╝██╔╝   ███████╗██╔╝   ███████╗██████╔╝                                
  ╚═══╝   ╚═╝╚═╝ ╚═════╝      ╚═╝ ╚═════╝ ╚═╝    ╚══════╝╚═╝    ╚══════╝╚═════╝                                 
'

function main (){
    # Array of programs to search computer for
    program_list=("Google Chrome" "Firefox" "Safari" "zoom.us" "Microsoft Word" "Microsoft PowerPoint" "Microsoft Excel" "Microsoft Defender" "Keynote" "Pages" "Numbers" "SOFTWARE CENTER" "Jamf Connect" "VLC")

    # Array of folders to search computer for
    folder_list=("Adobe Creative Cloud" "PaperCut Print Deploy Client")

    # Get computer name
    computer_name=$(hostname)

    # Success/Fail indicators
    SUCCESS="✅"
    FAIL="❌"

    # Grabs, formats, and provides status for all installed applications on current device
    printf $computer_name
    printf "\n\n"
    printf "Application List\n"
    for ((i = 0; i < 40; i++)); do
        printf "_"
    done
    printf "\n\n"

    app_list=$(ls /Applications)

    # Checks every listed app for installation status
    for app_name in "${program_list[@]}"; do
        if [[ $app_list == *$app_name* ]]; then
            printf $SUCCESS 
            echo " "$app_name
        elif [[ $app_list != *$app_name* ]]; then
            printf $FAIL 
            echo " "$app_name
        fi
    done

    # Checks every listed folder for installation status
    for folder_name in "${folder_list[@]}"; do
        if [[ $app_list == *$folder_name* ]]; then
            printf $SUCCESS 
            echo " "$folder_name
        elif [[ $app_list != *$folder_name* ]]; then
            printf $FAIL 
            echo " "$folder_name
        fi
    done

    for ((i = 0; i < 40; i++)); do
        printf "_"
    done
    printf "\n\n"

    # Output current MacOS version
    macos_version=$(sw_vers -productVersion)
    printf "Current macOS version: $macos_version\n\n"

    # Runs fdesetup and grabs current status of Filevault
    FVStatus=$(fdesetup status)
    if [ "$FVStatus" == "FileVault is On." ]; then
        printf "✅ FileVault\n\n"
    elif [ "$FVStatus" == "FileVault is Off." ]; then
        printf "❌ FileVault\n\n"
    fi

    # Gets all storage info for root drive
    HDDinfo=$(df -h / | tr " " "\n")
    i=0
    for part in $HDDinfo; do
        ((i++))
        case $i in
            12) echo "Total space: $part" ;;
            13) echo "Used space: $part" ;;
            14) echo "Free space: $part" ;;
            15) echo "Usage percent: $part" ;;
        esac
    done
}

bash_output=$(main)

osascript <<EOD
tell application "System Events"
    activate
    display dialog "$bash_output" buttons {"OK"} default button "OK" with title "Mac Deployment Checklist"
end tell
EOD