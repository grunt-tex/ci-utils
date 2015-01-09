#!/bin/sh

set -e

# Set up variables
BUILD_DIR=$PWD/build
TARGET_DIR=$BUILD_DIR/texlive
EXTRAS_DIR=$PWD/extras
DIST_DIR=$PWD/dist

# Clean build directory
rm -rf $BUILD_DIR
mkdir $BUILD_DIR

# Download and unpack distribution
wget -P $BUILD_DIR http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xf $BUILD_DIR/install-tl-unx.tar.gz -C $BUILD_DIR

# Create install profile
cat > $BUILD_DIR/texlive.profile <<END_CAT
# texlive.profile written on Mon Mar 31 09:11:02 2014 UTC
# It will NOT be updated and reflects only the
# installation profile at installation time.
selected_scheme scheme-custom
TEXDIR $TARGET_DIR
TEXMFCONFIG $TEXMFSYSCONFIG
TEXMFHOME $TEXMFLOCAL
TEXMFLOCAL $TARGET_DIR/texmf-local
TEXMFSYSCONFIG $TARGET_DIR/texmf-config
TEXMFSYSVAR $TARGET_DIR/texmf-var
TEXMFVAR $TEXMFSYSVAR
binary_x86_64-linux 1
collection-basic 1
collection-latex 1
collection-latexrecommended 1
portable 1
option_adjustrepo 1
option_autobackup 1
option_backupdir tlpkg/backups
option_desktop_integration 
option_doc 1
option_file_assocs 
option_fmt 1
option_letter 0
option_menu_integration 
option_path 0
option_post_code 1
option_src 1
option_sys_bin /usr/local/bin
option_sys_info /usr/local/share/info
option_sys_man /usr/local/share/man
option_w32_multi_user 0
option_write18_restricted 1
END_CAT

# Run installer
$BUILD_DIR/install-tl-*/install-tl -profile $BUILD_DIR/texlive.profile

# Remove docs to save space
rm -rf $TARGET_DIR/texmf-dist/doc

# Clean dist folder and move build into it
rm -rf $DIST_DIR
mkdir $DIST_DIR
mv $TARGET_DIR/* $DIST_DIR

# Remove build directory
rm -rf $BUILD_DIR