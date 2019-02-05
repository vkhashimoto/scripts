# find in current directory every item that has 'ok' or 'error' in the name 
# and then move the files found to the trashbin folder. The -I flag (xargs) 
# changes the '{}' on mv command for the filename
find . | grep 'ok\|error' | xargs -I{} mv {} trashbin/
