#!/bin/zsh

# This zsh script moves all given files to ~/dotfiles,
# and then creates a symlink to that moved file.
# It is recommended to place this file in your ~/bin.

# This is where the files are backed up to:
DOTFILES_DIR="${HOME}/dotfiles"

# Check for arguments
if [ $# -eq ]; then
    echo "Usage: $(basename "$0") <file_or_dir_1> [<file_or_dir_2> ...]"
    echo "Moves the specified item to ${DOTFILES_DIR} and creates a symlink in its place."
    exit 1
fi

# Ensure dir exists
mkdir -p "$DOTFILES_DIR"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Could not create dotfiles directory at ${DOTFILES_DIR}" >&2
    exit 1
fi

# Process arguments
for source_path in "$@"; do
    echo "Moving '${source_path}'..."

    if [ ! -e "$source_path" ] && [ ! -L "$source_path" ]; then
        echo "Error: Source '${source_path}' not found. Skipping." >&2
        continue
    fi

    if [ -L "$source_path" ]; then
        echo "Info: '${source_path}' is already a symlink. Skipping."
        continue
    fi

    base_name=$(basename "$source_path")
    echo $base_name
    destination_path="${DOTFILES_DIR}/${base_name}"
    echo $destination_path

    if [ -e "$destination_path" ]; then
        echo "Warning: '${destination_path}' already exists. Skipping '${source_path}' to avoid overwriting." >&2
        continue
    fi

    echo "... to '${destination_path}'"

    mv -- "$source_path" "$destination_path"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to move '${source_path}'. Aborting for this item." >&2
        continue
    fi

    echo "Creating symlink at '${source_path}'..."

    ln -s "$destination_path" "$source_path"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to create symlink at '${source_path}'." >&2
        echo "CRITICAL: Attempting to restore by moving file back." >&2

        mv -- "$destination_path" "$source_path"
    else
        echo "Success: '${source_path}' is now linked."
    fi
done

echo "All operations complete."
