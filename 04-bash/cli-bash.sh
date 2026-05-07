#! /bin/bash


while [ true ]; do
    echo "══════════════════════════════════════"
    echo "  🔥 DevOps AI Tool"
    echo "══════════════════════════════════════"
    echo ""
    echo "  1) 🖥️  Info del sistema"
    echo "  2) 📁 Crear archivo"
    echo "  3) 🔍 Diagnóstico de error (con IA)"
    echo "  4) 🤖 Generar script con IA"
    echo "  5) 🧹 Limpiar archivos temporales"
    echo "  6) 🏥 Health check de URLs"
    echo "  7) ❌ Salir"
    read -p "Choose an option: " option
    case $option in
        1) 
            echo "++++++++++++++++++++++++++++++++++"
            echo "System Information:"
            echo "++++++++++++++++++++++++++++++++++"
            echo "username: $(whoami)"
            echo "hostname: $(hostname)"
            echo "OS: $(uname -o)"
            echo "Kernel: $(uname -r)"
            echo "Folder: $(pwd)"
            echo "Date: $(date '+%d/%m/%Y %H:%M')"
            echo "Disk Usage: $(df -h / | tail -1 | awk '{print $5}') used"
            ;;
        2) 
            read -p "Enter filename to create: " filename
            if [[ -z "$filename" ]]; then
                echo "Filename cannot be empty!"
            elif [[ -f "$filename" ]]; then 
                read -p "File already exists. Do you want to overwrite it? (y/n): " answer
                if [[ "$answer" == "y" ]]; then
                    touch "$filename"
                    echo "File '$filename' created successfully."
                else
                    echo "File creation cancelled."
                fi
            else 
                touch "$filename"
                echo "File '$filename' created successfully."
            fi
            ;;
        3) 
            read -p "Enter error message to diagnose: " error_message
            if [[ -z "$error_message" ]]; then
                echo "Error message cannot be empty!"
            else
                echo "Please copy this prompt and paste it into your AI tool (like ChatGPT) to get a diagnosis:"
                echo "══════════════════════════════════════"
                echo "Diagnose this error message: $error_message"
                echo "Provide possible causes and solutions."
                echo "══════════════════════════════════════"
            fi
            ;;
        4) 
            read -p "Enter task description for script generation: " task_description
            if [[ -z "$task_description" ]]; then
                echo "Task description cannot be empty!"
            else
                echo "Please copy this prompt and paste it into your AI tool (like ChatGPT) to get a generated script:"
                echo "══════════════════════════════════════"
                echo "Generate a bash script to accomplish this task: $task_description"
                echo "Include comments in the script to explain each step."
                echo "══════════════════════════════════════"
            fi
            ;;
        5) 
            echo "Cleaning temporary files..."
            find . -name "*.tmp" -o -name "*.log" -o -name "*.bak" -type f -delete
            echo "Temporary files cleaned."
            ;;
        6) 
            read -p "Enter URL to check: " url
            if [[ -z "$url" ]]; then
                echo "URL cannot be empty!"
            else
                echo "Checking health of $url..."
                curl -f -s "$url" > /dev/null && echo "✅ URL is healthy." || echo "❌ URL is not accessible."
            fi
            ;;
        7) echo "Exiting..."; exit 0;;
        *) echo "Invalid option, please try again.";;
    esac
done