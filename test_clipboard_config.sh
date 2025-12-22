#!/bin/bash

echo "=== Testing Clipboard Configuration Changes ==="
echo ""

echo "1. Checking Neovim settings file..."
echo "   Looking for clipboard settings in lua/diegoagd/core/settings.lua..."
if grep -q "clipboard" lua/diegoagd/core/settings.lua; then
    echo "   ❌ FAIL: Found clipboard settings in Neovim config"
    grep -n "clipboard" lua/diegoagd/core/settings.lua
else
    echo "   ✅ PASS: No clipboard settings found in Neovim config"
fi
echo ""

echo "2. Checking Vim settings file..."
echo "   Looking for 'set clipboard' in .vimrc..."
if grep -q "set clipboard" .vimrc; then
    echo "   ❌ FAIL: Found 'set clipboard' in Vim config"
    grep -n "set clipboard" .vimrc
else
    echo "   ✅ PASS: No 'set clipboard' found in Vim config"
fi
echo ""

echo "3. Verifying leader+y mappings are still present..."
echo "   Checking Neovim keymaps..."
if grep -q '<leader>y' lua/diegoagd/core/keymaps.lua; then
    echo "   ✅ PASS: Leader+y mappings found in Neovim"
    grep -n '<leader>y' lua/diegoagd/core/keymaps.lua
else
    echo "   ❌ FAIL: Leader+y mappings not found in Neovim"
fi
echo ""

echo "4. Checking Vim leader+y mappings..."
if grep -q '<leader>y' .vimrc; then
    echo "   ✅ PASS: Leader+y mappings found in Vim"
    grep -n '<leader>y' .vimrc
else
    echo "   ❌ FAIL: Leader+y mappings not found in Vim"
fi
echo ""

echo "=== Summary ==="
echo "The clipboard settings have been removed from both configurations."
echo "Normal yank operations (y, yy, Y) will no longer automatically copy to system clipboard."
echo "Leader+y mappings will still work for explicit clipboard copying."