#!/bin/bash

# ==============================================================================
# Enhanced Resume Agent - Automated Setup Script (v3 - Final)
# ==============================================================================
# This script prepares your local environment for developing the Enhanced
# Resume Agent by checking dependencies and installing packages for both the
# backend and frontend.
#
# Usage:
#   Run this script from the root of the monorepo: ./setup.sh
# ==============================================================================

# --- Configuration & Helpers ---
set -e # Exit immediately if a command exits with a non-zero status.

# Color codes for beautiful output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function to check for command existence
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: Required command '$1' is not found.${NC}"
        echo -e "${YELLOW}Please install it and ensure it's in your system's PATH before running this script.${NC}"
        exit 1
    fi
}

# --- Main Script ---
echo -e "${GREEN}🚀 Starting setup for the Enhanced Resume Agent...${NC}"

# 1. Dependency Checks
echo -e "\n[Step 1/4] Checking for required dependencies..."
check_command "python3"
check_command "pip3"
check_command "flutter"
echo -e "${GREEN}✅ All dependencies found.${NC}"

# 2. Backend Setup
echo -e "\n[Step 2/4] Setting up the Python backend..."
if [ ! -d "backend" ]; then
    echo -e "${RED}Error: 'backend' directory not found. Please run this script from the project root.${NC}"
    exit 1
fi
cd backend

echo "  - Creating Python virtual environment in 'backend/venv'..."
python3 -m venv venv

echo "  - Activating virtual environment and installing dependencies from requirements.txt..."
echo "  - This now includes PDF generation libraries, so it may take a moment."
source venv/bin/activate
pip3 install -r requirements.txt
deactivate
echo -e "${GREEN}  - Backend dependencies installed successfully.${NC}"

echo "  - Creating backend .env file..."
if [ -f ".env" ]; then
    echo -e "${YELLOW}  - INFO: 'backend/.env' file already exists. Skipping creation.${NC}"
else
    cp .env.example .env
    echo -e "${GREEN}  - Created 'backend/.env'. You must edit this file with your secrets.${NC}"
fi
cd ..

# 3. Frontend Setup
echo -e "\n[Step 3/4] Setting up the Flutter frontend..."
if [ ! -d "frontend" ]; then
    echo -e "${RED}Error: 'frontend' directory not found. Please run this script from the project root.${NC}"
    exit 1
fi
cd frontend

echo "  - Fetching Flutter dependencies with 'flutter pub get'..."
flutter pub get
echo -e "${GREEN}  - Frontend dependencies installed successfully.${NC}"
cd ..

# 4. Final Instructions & Project Overview
echo -e "\n[Step 4/4] Finalizing setup..."
echo -e "\n${BLUE}-----------------------------------------------------${NC}"
echo -e "${BLUE}Project Knowledge Base Information${NC}"
echo -e "${BLUE}-----------------------------------------------------${NC}"
echo "A 'knowledge_base' directory has been included in this project."
echo "It contains:"
echo "  - Sector-specific glossaries, skills, and action verbs."
echo "  - Document templates and PDF theme definitions."
echo "This information is used by the AI to generate high-quality, relevant, and"
echo "beautifully styled documents tailored to your industry."
echo -e "${BLUE}-----------------------------------------------------${NC}"


echo -e "\n\n${GREEN}=====================================================${NC}"
echo -e "${GREEN}✅  Local Development Environment Setup Complete!  ✅${NC}"
echo -e "${GREEN}=====================================================${NC}"

echo -e "\nYour new AI Career Toolkit is ready to run!"
echo -e "The application now includes PDF theme selection and a sector-specific knowledge base."

echo -e "\n${YELLOW}🚨 IMPORTANT: ACTION REQUIRED 🚨${NC}"
echo "1.  You MUST edit the backend configuration file with your credentials:"
echo -e "    ➡️  ${YELLOW}backend/.env${NC}"
echo "2.  You MUST edit the frontend configuration file with your deployed backend URL:"
echo -e "    ➡️  ${YELLOW}frontend/lib/core/api_client.dart${NC}"

echo -e "\n${GREEN}--- How to Run the Application ---${NC}"

echo -e "\n${GREEN}To run the BACKEND server (in Terminal 1):${NC}"
echo "   cd backend"
echo "   source venv/bin/activate"
echo "   uvicorn src.main:app --reload --port 8000"

echo -e "\n${GREEN}To run the FRONTEND app (in Terminal 2):${NC}"
echo "   cd frontend"
echo "   flutter run -d chrome"

echo -e "\nHappy coding! ✨\n"
