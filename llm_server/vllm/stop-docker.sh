# Source - https://stackoverflow.com/a/20909045
#!/bin/sh



unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)


