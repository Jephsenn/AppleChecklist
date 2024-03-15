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

installed=1

#Checks if Python3 is installed on machine, else installs python3
if which python3 &>/dev/null; then
    echo "Python 3 is already installed."
else
    echo "Python 3 is not installed. Installing..."
    $installed = 0
    sudo apt-get update
    sudo apt-get install python3
fi

# Run the Python script and capture its output
python_script_output=$(./checklist.py)

# Display the output using Swift's dialogue
osascript <<EOD
tell application "System Events"
    activate
    display dialog "$python_script_output" buttons {"OK"} default button "OK" with title "Mac Deployment Checklist"
end tell
EOD

# Check if Python 3 was installed via script, if so will remove python
if [ $installed == 0 ] && [ "$(which python3)" ]; then
    echo "Python 3 is already installed. Uninstalling..."
    
    # Use apt to remove Python 3
    sudo apt-get remove python3
    
    echo "Python 3 has been uninstalled."
fi
