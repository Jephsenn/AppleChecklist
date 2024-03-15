#!/usr/bin/python3

"""
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
"""                                                                                                                
                                                     
import os
import platform
import subprocess
import socket

# Get computer name
computer_name = socket.gethostname()

# List all installed programs in Applications directory
app_dir = "/Applications"
installed_programs = set(os.listdir(app_dir))

# Grabs current MacOS Version tuple and format to string
macos_version = platform.mac_ver()
macos_version_string, _, _ = macos_version

# Success/Fail indicators
SUCCESS = "✅"
FAIL = "🚫"

# List of programs to search computer for
program_list = [
    "Google Chrome",
    "Firefox",
    "Safari",
    "zoom.us",
    "Microsoft Word",
    "Microsoft PowerPoint",
    "Microsoft Excel",
    "Microsoft Defender",
    "Keynote",
    "Pages",
    "Numbers",
    "SOFTWARE CENTER",
    "Jamf Connect",
    "VLC",
]

# List of folders to search computer for
folder_list = [
    "Adobe Creative Cloud",
    "PaperCut Print Deploy Client",
]

# Grabs, formats, and provides status for all installed applications on current device
def list_installed_apps():
    output = ""
    output += computer_name + "\n\n"
    output += "Application List\n"
    output += "_" * 40 + "\n\n"

    # Checks every listed app for installation status
    for app_name in program_list:
        status = "✅" if f"{app_name}.app" in installed_programs else "🚫"
        output += f"{status} {app_name}\n"

    # Checks every listed folder for installation status
    for folder_name in folder_list:
        status = "✅" if f"{folder_name}" in installed_programs else "🚫"
        output += f"{status} {folder_name}\n"

    output += "_" * 40 + "\n"

    # Also outputs current MacOS Version
    output += "\n" + "Current MacOS Version: " + macos_version_string + "\n\n"
    return output

# Runs fdesetup and grabs current status of Filevault
def check_filevault_status():
    try:
        # Run the shell command to check FileVault status
        result = subprocess.run(["fdesetup", "status"], capture_output=True, text=True, check=True)

        # Get the output of the command
        output = result.stdout.strip()

        # Check the output to determine the FileVault status
        if "FileVault is On" in output:
            return "✅ FileVault\n\n"
        elif "FileVault is Off" in output:
            return "🚫 FileVault\n\n"
        else:
            return "FileVault status is unknown\n"
    except subprocess.CalledProcessError as e:
        return f"Error: {e}\n"
    except Exception as e:
        return f"An error occurred: {str(e)}\n"

# Gets all storage info for root drive
def get_storage_info():
    root_partition = os.popen("df -h /").readlines()[-1].split()

    total_space = root_partition[1]
    used_space = root_partition[2]
    free_space = root_partition[3]
    usage_percent = root_partition[4]

    output = "Total space: " + total_space + "\n"
    output += "Used space: " + used_space + "\n"
    output += "Free space: " + free_space + "\n"
    output += "Usage percent: " + usage_percent + "\n"

    return output

# Runs all functions (checks apps first, filevault second, and storage 3rd)
def main():
    output = list_installed_apps()
    output += check_filevault_status()
    output += get_storage_info()
    print(output)

# Old [>10/2] (Would show output in terminal rather than SwiftDialogue)
"""
def main():
    # Create a temporary file to capture the output
    with tempfile.NamedTemporaryFile(mode="w+", delete=False) as temp_file:
        output = list_installed_apps()
        temp_file.write(output)
    
    # Create an AppleScript command to activate Terminal, open a new window, and display the output
    applescript_code = f'''
        tell application "Terminal"
            activate
            do script ""
            delay 0.5
            do script "cd '{os.getcwd()}'; cat '{temp_file.name}'" in front window
        end tell
    '''
    
    # Save the AppleScript to a file
    applescript_file = tempfile.NamedTemporaryFile(mode="w", delete=False)
    applescript_file.write(applescript_code)
    applescript_file.close()
    
    # Use the 'osascript' command to execute the AppleScript
    os.system(f"osascript '{applescript_file.name}'")
    
"""

if __name__ == "__main__":
    main()
