#!/bin/bash

myIP=$(bash IPAddress.bash)

function helpmenu() {

echo "HELP MENU "
echo "-------------------------"
echo "-n: Add -n as an argument for this script to use nmap"
echo "  -n external: External NMAP scan"
echo "  -n internal: Internal NMAP scan"
echo "-s: Add -s as an argument for this script to use ss"
echo "  -s external: External ss(Netstat) scan"
echo "  -s internal: Internal ss(Netstat) scan"
echo ""
echo "Usage: bash networkchecker.bash -n/-s external/internal"
echo "-------------------------"

}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){

# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
elpo=$(ss -lpt | awk -F"[[:space:]]+" '{print $4,$6} | tr -d "\"" | \
grep -E "[0-9]{1,3}\." | grep -v "127.0.0" | \
awk -F"[[:space:]:(),]+" '{print $2,$4}' | tr -d "\"")

}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
}



# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu

if ["$#" -ne 2]; then
    helpmenu
fi

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
while getopts  "n:s" opt; do
    case $opt in

        n) 
            if [[ "$OPTARG" != "internal" && "$OPTARG" != "external" ]]; then
                echo "Invalid argument for -n"
                helpmenu
            fi

            if [[ "$OPTARG" == "internal" ]]; then
                echo "Running NMAP internally..."
                InternalNmap
                echo "$rin"
            else
                echo "Running NMAP externally..."
                External Nmap
                echo "$rex"
            fi
            ;;
            
        s)
            if [[ "$OPTARG" != "internal" && "$OPTARG" != "external" ]]; then
                echo "Invalid argument for -s"
                helpmenu
            fi

            if [[ "$OPTARG" == "internal" ]]; then
                echo "Running Netstat locally..."
                InternalListeningPorts
                echo "$ilpo"
            else
                echo "Running Netstat externally..."
                ExternalListeningPorts
                echo "$elpo"
            fi
            ;;
            
        *)
            helpmenu
            ;;
    esac
done

# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)
    

