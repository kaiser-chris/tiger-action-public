#!/bin/bash

# Initialize variables
total_size=0
max_size=$((100 * 1024 * 1024)) # 100 MB in bytes
max_files=100
max_file_size=$((99 * 1024 * 1024)) # 99 MB in bytes
files_to_add=()
commit_count=1

# Loop through all untracked files and add them if they don't exceed the max size, max file count, and max file size
while IFS= read -r -d '' file; do
    file_size=$(stat -c%s "$file")
    if (( file_size > max_file_size )); then
        echo "Skipping $file, it exceeds the 99 MB file size limit."
        continue
    fi
    if (( total_size + file_size <= max_size )) && (( ${#files_to_add[@]} < max_files )); then
        files_to_add+=("$file")
        total_size=$((total_size + file_size))
    else
        # Commit and push the current batch
        if [ ${#files_to_add[@]} -gt 0 ]; then
            git add "${files_to_add[@]}"
            git commit -m "Batch commit $commit_count"
            git push
            commit_count=$((commit_count + 1))
            files_to_add=()
            total_size=0
        fi
        # Add the current file to the new batch
        files_to_add+=("$file")
        total_size=$((file_size))
    fi
done < <(git ls-files --others --exclude-standard -z)

# Commit and push any remaining files
if [ ${#files_to_add[@]} -gt 0 ]; then
    git add "${files_to_add[@]}"
    git commit -m "Batch commit $commit_count"
    git push
fi

echo "All files processed and pushed."
