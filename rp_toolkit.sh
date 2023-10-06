#!/bin/bash

check_programming_languages() {
    # Check for Python3
    python3 --help 1>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] Python3 was already installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "[+] Installing python3!\n"
        apt install python3 python3-pip -y;
        python3 --help 1>/dev/null
        if [[ $? -eq 0 ]]; then
            echo -e "\n\t[+] Python3 - Installed" >> /root/rp_arsenal/installation_report.txt;
        else
            echo -e "\n\t[!] Python3 - Installation Faild" >> /root/rp_arsenal/installation_report.txt;
        fi
    fi
    # Check for NodeJS
    node --version 1>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] NodeJS was already installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "[+] Installing nodejs!\n"
        apt install nodejs npm -y;
        node --version;
         if [[ $? -eq 0 ]]; then
            echo -e "\n\t[+] NodeJS - Installed" >> /root/rp_arsenal/installation_report.txt;
        else
            echo -e "\n\t[!] NodeJS - Installation Faild" >> /root/rp_arsenal/installation_report.txt;
        fi
    fi
    # Check for Go
    go version 1>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "[+] Go was already installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "[+] Installing go!\n"
        apt install golang-go -y;
        go version 1>/dev/null;
        if [[ $? -eq 0 ]]; then
            echo -e "\n\t[+] Go - Installed" >> /root/rp_arsenal/installation_report.txt;
        else
            echo -e "\n\t[!] Go - Installation Faild" >> /root/rp_arsenal/installation_report.txt;
        fi
    fi
}

install_docker() {
    docker --version 1>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] Docker was already installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "[+] Installing Docker!\n"
        apt install install ca-certificates curl gnupg -y
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu" $(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get update
        apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y;
        sleep 3;
        docker --version;
        if [[ $? -eq 0 ]]; then
            echo -e "\n\t[+] Docker - Installed" >> /root/rp_arsenal/installation_report.txt;
        else
            echo -e "\n\t[!] Docker - Installation Faild" >> /root/rp_arsenal/installation_report.txt;
        fi
    fi
}

get_wordlists() {
    mkdir /root/rp_arsenal/wordlists;
    mkdir /root/rp_arsenal/wordlists/web_content;
    mkdir /root/rp_arsenal/wordlists/subdomains;
    mkdir /root/rp_arsenal/wordlists/api;
    mkdir /root/rp_arsenal/wordlists/passwords;

    # Wordlists for web content discovery
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/big.txt -O /root/rp_arsenal/wordlists/web_content/big.txt;
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-big.txt -O /root/rp_arsenal/wordlists/web_content/directory-list-2.3-big.txt;
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt -O /root/rp_arsenal/wordlists/web_content/common.txt;
    wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O /root/rp_arsenal/wordlists/web_content/content_discovery_all.txt
    wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_php_2023_08_28.txt -O /root/rp_arsenal/wordlists/web_content/httparchive_php_2023_08_28.txt;

    # Wordlists for subdomains
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/dns-Jhaddix.txt -O /root/rp_arsenal/wordlists/subdomains/dns-Jhaddix.txt;
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/bug-bounty-program-subdomains-trickest-inventory.txt -O /root/rp_arsenal/wordlists/subdomains/bug-bounty-program-subdomains-trickest-inventory.txt;
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/tlds.txt -O /root/rp_arsenal/wordlists/subdomains/tlds.txt;
    wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_subdomains_2023_08_28.txt -O /root/rp_arsenal/wordlists/subdomains/httparchive_subdomains_2023_08_28.txt;

    #Wordlists for APIs
    wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_apiroutes_2023_08_28.txt -O /root/rp_arsenal/wordlists/api/httparchive_apiroutes_2023_08_28.txt;
    wget https://wordlists-cdn.assetnote.io/data/kiterunner/swagger-wordlist.txt -O /root/rp_arsenal/wordlists/api/swagger-wordlist.txt;
    wget https://raw.githubusercontent.com/chrislockard/api_wordlist/master/api_seen_in_wild.txt -O /root/rp_arsenal/wordlists/api/api_seen_in_wild.txt;

    #Wordlists for passwords
    wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt -O /root/rp_arsenal/wordlists/passwords/10-million-password-list-top-1000000.txt;
    wget https://github.com/danielmiessler/SecLists/raw/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz -O /root/rp_arsenal/wordlists/passwords/rockyou.txt.tar.gz;
    gzip -d /root/rp_arsenal/wordlists/passwords/rockyou.txt.tar.gz;
    cd /root/rp_arsenal/wordlists/passwords/;
    tar -xvf rockyou.txt.tar;
    cd /root;
}

general_tools() {
    apt install nmap -y;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] Nmap - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] Nmap - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    apt install sqlmap -y;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] SQLMap - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] SQLMap - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    apt install mysql-client -y;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] MySQL-Client - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] MySQL-Client - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    # Download GitTools
    cd /root/rp_arsenal/;
    git clone https://github.com/internetwache/GitTools.git;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] GitTools - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] GitTools - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    # Download DS_Store dumper
    cd /root/rp_arsenal/;
    git clone https://github.com/lijiejie/ds_store_exp.git;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] DS_Store - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] DS_Store - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    # Download&Install Trufflehog
    cd /root/rp_arsenal/;
    curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b /usr/local/bin;
    trufflehog --help 1>/dev/null;
    if [[ $? -eq 0 ]]; then
        echo -e "[+] Trufflehog installed!\n"
        echo -e "\n\t[+] Trufflehog - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "[+] Downloading Trufflehog docker image!\n"
        docker pull trufflesecurity/trufflehog;
        echo -e "\n\t[+] Trufflehog - Installed (docker)" >> /root/rp_arsenal/installation_report.txt;
    fi
}

install_recon_tools() {
    # Download&Install Sublist3r
    cd /root/rp_arsenal/;
    git clone https://github.com/aboul3la/Sublist3r.git;
    pip3 install -r Sublist3r/requirements.txt
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] Sublist3r - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        docker pull trickest/sublist3r;
        if [[ $? -eq 0 ]]; then
            echo -e "\n\t[+] Sublist3r - Installed" >> /root/rp_arsenal/installation_report.txt;
        else
            echo -e "\n\t[!] Sublist3r - Installation failed" >> /root/rp_arsenal/installation_report.txt;
        fi
    fi

    #Download Amass docker image on Ubuntu, if it doesn't work with snap it tries with apt (in case of Kali/ParrotOS)
    snap install amass;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] Amass - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        apt install amass -y;
        if [[ $? -eq 0 ]]; then
            echo -e "\n\t[+] Amass - Installed" >> /root/rp_arsenal/installation_report.txt;
        else
            echo -e "\n\t[!] Amass - Installation failed" >> /root/rp_arsenal/installation_report.txt;
        fi
    fi

    # Download httpx - binary & docker image in case of unavailable binary download in GitHub
    mkdir /root/rp_arsenal/httpx;
    wget https://github.com/projectdiscovery/httpx/releases/download/v1.3.5/httpx_1.3.5_linux_amd64.zip -O /root/rp_arsenal/httpx/httpx_1.3.5_linux_amd64.zip;
    if [[ $? -eq 0 ]]; then
        unzip /root/rp_arsenal/httpx/httpx_1.3.5_linux_amd64.zip;
        echo -e "\n\t[+] httpx - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        docker pull projectdiscovery/httpx:latest
        echo -e "\n\t[+] httpx - Installed (docker)" >> /root/rp_arsenal/installation_report.txt;
    fi

    # Download gau
    cd /root/rp_arsenal/;
    git clone https://github.com/lc/gau.git;
    cd gau/cmd/gau;
    go build;
    cp gau /usr/local/bin/;
    gau -h 1>/dev/null;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] gau - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] gau - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi
    cd /root;

    # Download CloudFlair
    cd /root/rp_arsenal/;
    git clone https://github.com/christophetd/CloudFlair.git;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] CloudFlair - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] CloudFlair - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    # Download WPScan docker image
    docker pull wpscanteam/wpscan
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] WPScan - Installed (docker)" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] WPScan - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi
}

install_fuzzing_tools() {
    # Download nuclei docker image
    docker pull projectdiscovery/nuclei:latest
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] nuclei - Installed (docker)" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] nuclei - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    # Download ffuf
    cd /root/rp_arsenal/;
    git clone https://github.com/ffuf/ffuf;
    cd ffuf;
    go get;
    go build;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] ffuf - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        docker pull trickest/ffuf
        if [[ $? -eq 0 ]]; then
            echo -e "\n\t[+] ffuf - Installed (docker)" >> /root/rp_arsenal/installation_report.txt;
        else
            echo -e "\n\t[!] ffuf - Installation failed" >> /root/rp_arsenal/installation_report.txt;
        fi
    fi

    # Install GoBuster
    apt install gobuster -y;
    gobuster --help 1>/dev/null;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] GoBuster - Installed" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] GoBuster - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi

    # Download Metasploit docker image
    docker pull metasploitframework/metasploit-framework
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] Metasploit - Installed (docker)" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] Metasploit - Installation failed" >> /root/rp_arsenal/installation_report.txt;
    fi
}

install_webproxy_tools() {
    # Download Postman
    cd /root/rp_arsenal/;
    wget https://dl.pstmn.io/download/latest/linux_64 -O postman.tar.gz;
    if [[ $? -eq 0 ]]; then
        echo -e "\n\t[+] Postman - Downloaded" >> /root/rp_arsenal/installation_report.txt;
    else
        echo -e "\n\t[!] Postman - Download failed" >> /root/rp_arsenal/installation_report.txt;
    fi
    gzip -d postman.tar.gz;
    tar -xvf postman.tar;
}

start_installations() {
    echo -e "[+] Starting installations...";
    apt-get update
    apt install wget git curl -y;
    check_programming_languages
    install_docker
    get_wordlists
    install_recon_tools
    install_fuzzing_tools
    install_webproxy_tools
}

# Check if the script is running as root or with sudo privileges
init_install() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "\n[INFO] Running with root/sudo privileges\n";
        echo -e "\n[INFO] Working Directoty would be in /root/rp_arsenal\n";
        mkdir /root/rp_arsenal;
        echo -e "### Installation Report ###\n" > /root/rp_arsenal/installation_report.txt;
        # start_installations
        installation_menu
    else
        echo "[!] This script must be run as root or with sudo privileges to create the file."
    fi
}

installation_menu() {
    echo -e "\n[!] Select what tools to install (0-6):\n";
    echo -e "\t0 - Install everything in the list\n";
    echo -e "\t1 - Install only programming languages (python3, go, nodejs)\n";
    echo -e "\t2 - Install only docker\n";
    echo -e "\t3 - Download wordlists (for content discovery, APIs, passwords and subdomains)\n";
    echo -e "\t4 - Install recon tools (Sublist3r, Amass, gau, httpx, WPScan, CloudFlair) - requires Docker installed\n";
    echo -e "\t5 - Install fuzzing tools (GoBuster, ffuf, nuclei, Metasploit) - requires Docker installed\n";
    echo -e "\t6 - Install only Web Proxy (Postman)\n";
    read selection;

    case $selection in
        0)
            start_installations
            ;;
        1)
            apt-get update
            check_programming_languages
            ;;
        2)
            apt-get update
            install_docker
            ;;
        3)
            apt-get update
            get_wordlists
            ;;
        4)
            apt-get upadte
            install_recon_tools
            ;;
        5)
            apt-get update
            install_fuzzing_tools
            ;;
        6)
            apt-get update
            install_webproxy_tools
            ;;
        *)
            echo "No valid option was selected"
            ;;
        esac
}

init_install
