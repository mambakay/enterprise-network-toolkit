#!/bin/bash

while true
do
    clear
    echo "================================================"
    echo "     ENTERPRISE NETWORK ENGINEER TOOLKIT"
    echo "================================================"
    echo " 1. IP Configuration"
    echo " 2. Routing Table"
    echo " 3. Network Interfaces"
    echo " 4. DNS Configuration"
    echo " 5. DNS Lookup (dig)"
    echo " 6. Ping Test"
    echo " 7. Continuous Ping"
    echo " 8. Traceroute"
    echo " 9. ARP Table"
    echo "10. Open Ports"
    echo "11. Active Connections"
    echo "12. TCP Dump Capture"
    echo "13. Nmap Quick Scan"
    echo "14. Nmap Full Scan"
    echo "15. Whois Lookup"
    echo "16. Restart Network Manager"
    echo "17. Flush DNS Cache"
    echo "18. System Network Logs"
    echo "19. SSH to Device"
    echo "20. BGP Neighbor Check (FRR)"
    echo "21. OSPF Neighbor Check (FRR)"
    echo "22. Firewall Rules"
    echo "23. Public IP"
    echo "24. Speed Test"
    echo "25. Generate Network Report"
    echo "26. Launch Wireshark"
    echo "27. Exit"
    echo ""

    read -p "Choose option: " choice

    case $choice in

    1) ip addr show ;;
    2) ip route show ;;
    3) ip link show ;;
    4) cat /etc/resolv.conf ;;

    5)
        read -p "Enter hostname: " host
        dig $host
        ;;

    6)
        read -p "Enter host/IP: " host
        ping -c 4 $host
        ;;

    7)
        read -p "Enter host/IP: " host
        ping $host
        ;;

    8)
        read -p "Enter host/IP: " host
        traceroute $host
        ;;

    9) ip neigh show ;;

    10) ss -tulnp ;;

    11) ss -tunap ;;

    12)
        read -p "Interface: " iface
        sudo tcpdump -i $iface
        ;;

    13)
        read -p "Target IP: " target
        sudo nmap -F $target
        ;;

    14)
        read -p "Target IP: " target
        sudo nmap -sV -A $target
        ;;

    15)
        read -p "Domain: " domain
        whois $domain
        ;;

    16)
        sudo systemctl restart NetworkManager
        ;;

    17)
        sudo resolvectl flush-caches
        ;;

    18)
        sudo journalctl -u NetworkManager -n 50
        ;;

    19)
        read -p "Device IP: " device
        read -p "Username: " user
        ssh $user@$device
        ;;

    20)
        sudo vtysh -c "show ip bgp summary"
        ;;

    21)
        sudo vtysh -c "show ip ospf neighbor"
        ;;

    22)
        sudo iptables -L -n -v
        ;;

    23)
        curl ifconfig.me
        echo
        ;;

    24)
        speedtest-cli
        ;;

    25)
        REPORT="network_report_$(date +%F).txt"

        {
            echo "===== NETWORK REPORT ====="
            date
            hostname
            echo
            ip addr
            echo
            ip route
            echo
            ss -tulnp
            echo
            ip neigh
            echo
        } > $REPORT

        echo "Report saved: $REPORT"
        ;;

    26)
        wireshark &
        ;;

    27)
        exit
        ;;

    *)
        echo "Invalid Option"
        ;;
    esac

    echo
    read -p "Press Enter to continue..."
done
