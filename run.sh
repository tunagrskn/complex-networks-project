#!/bin/bash

# TSN Election Algorithms - OMNeT++ Simulation Runner
# Usage: ./run.sh [gui|cmd] [configuration]

cd "$(dirname "$0")"

# Setup OMNeT++ environment
source /space/jupiter/tools/omnetpp-6.3.0/setenv

# Default values
MODE="gui"
CONFIG="RingNetwork"

# Check if project is built, if not build it
if [ ! -f "build/complex-networks-project" ]; then
    echo "Executable not found. Building project..."
    if [ ! -d "build" ]; then
        source /space/jupiter/tools/omnetpp-6.3.0/setenv
        meson setup build
    fi
    source /space/jupiter/tools/omnetpp-6.3.0/setenv
    meson compile -C build
fi

EXE_PATH="../build/complex-networks-project"

# Parse arguments
if [ $# -ge 1 ]; then
    MODE=$1
fi

if [ $# -ge 2 ]; then
    CONFIG=$2
fi

echo "Starting TSN Election Simulation..."
echo "Mode: $MODE"
echo "Configuration: $CONFIG"
echo "==========================================="

# Change to simulations directory
cd simulations

case $MODE in
    "gui"|"qtenv")
        echo "Starting GUI mode (Qtenv)..."
        DISPLAY=:0 $EXE_PATH -u Qtenv -c $CONFIG
        ;;
    "cmd"|"cmdenv")
        echo "Starting command-line mode (Cmdenv)..."
        $EXE_PATH -u Cmdenv -c $CONFIG
        ;;
    "list")
        echo "Available configurations:"
        echo "- RingNetwork (8 nodes, diameter=4)"
        echo "- MeshNetwork (3x3 grid)" 
        echo "- StarNetwork (7 nodes, diameter=2)"
        echo "- FullyConnectedNetwork (6 nodes)"
        echo "- RandomNetwork (10 nodes)"
        echo "- IndustrialTSN"
        echo "- AutomotiveTSN"
        echo ""
        echo "Usage examples:"
        echo "  ./run.sh gui RingNetwork      # GUI with Ring topology"
        echo "  ./run.sh cmd MeshNetwork      # Command-line with Mesh"
        echo "  ./run.sh list                 # Show this help"
        ;;
    *)
        echo "Invalid mode: $MODE"
        echo "Usage: ./run.sh [gui|cmd|list] [configuration]"
        echo "Run './run.sh list' to see available configurations"
        exit 1
        ;;
esac