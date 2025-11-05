#!/bin/sh

MainMenu() {
    while true
    do
        clear
        echo "======================================"
        echo "   CPS510 A5 - E-Commerce Database   "
        echo "======================================"
        echo "1) Drop Tables"
        echo "2) Create Tables"
        echo "3) Populate Tables"
        echo "4) Run Advanced Queries"
        echo "E) Exit"
        echo "--------------------------------------"
        echo -n "Choose an option: "
        read CHOICE

        case $CHOICE in
            1) bash drop_tables.sh ;;
            2) bash create_tables.sh ;;
            3) bash populate_tables.sh ;;
            4) bash query_tables.sh ;;
            E|e) exit ;;
            *) echo "Invalid choice. Press Enter to continue."; read ;;
        esac
    done
}

MainMenu
