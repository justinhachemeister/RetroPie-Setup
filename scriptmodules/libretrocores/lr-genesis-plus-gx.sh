#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-genesis-plus-gx"
rp_module_desc="Sega 8/16 bit emu - Genesis Plus (enhanced) port for libretro"
rp_module_help="ROM Extensions: .bin .cue .gen .gg .iso .md .sg .smd .sms .zip\nCopy your Game Gear roms to $romdir/gamegear\nMasterSystem roms to $romdir/mastersystem\nMegadrive / Genesis roms to $romdir/megadrive\nSG-1000 roms to $romdir/sg-1000\nSegaCD roms to $romdir/segacd\nThe Sega CD requires the BIOS files bios_CD_U.bin and bios_CD_E.bin and bios_CD_J.bin copied to $biosdir"
rp_module_section="main"

function sources_lr-genesis-plus-gx() {
    gitPullOrClone "$md_build" https://github.com/libretro/Genesis-Plus-GX.git
}

function build_lr-genesis-plus-gx() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro
    md_ret_require="$md_build/genesis_plus_gx_libretro.so"
}

function install_lr-genesis-plus-gx() {
    md_ret_files=(
        'genesis_plus_gx_libretro.so'
        'HISTORY.txt'
        'LICENSE.txt'
        'README.md'
    )
}

function configure_lr-genesis-plus-gx() {
    mkRomDir "gamegear"
    mkRomDir "mastersystem"
    mkRomDir "megadrive"
    mkRomDir "sg-1000"
    mkRomDir "segacd"

    ensureSystemretroconfig "gamegear"
    ensureSystemretroconfig "mastersystem"
    ensureSystemretroconfig "megadrive"
    ensureSystemretroconfig "sg-1000"
    ensureSystemretroconfig "segacd"

    addSystem 1 "$md_id" "gamegear" "$md_inst/genesis_plus_gx_libretro.so"
    addSystem 0 "$md_id" "mastersystem" "$md_inst/genesis_plus_gx_libretro.so"
    addSystem 0 "$md_id" "megadrive" "$md_inst/genesis_plus_gx_libretro.so"
    addSystem 1 "$md_id" "sg-1000" "$md_inst/genesis_plus_gx_libretro.so"
    addSystem 0 "$md_id" "segacd" "$md_inst/genesis_plus_gx_libretro.so"
}
