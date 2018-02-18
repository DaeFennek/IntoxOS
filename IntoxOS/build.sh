###########################################################################
#
# -------------------------------------------------------------------------
#  File name:   build.sh
#  Version:     v1.00
#  Created:     29/3/2014 by Kevin.
#  Description: Call make in cygwin enviroment
# -------------------------------------------------------------------------
#  History:
#
###########################################################################

#!/bin/sh

cd  $1
echo "$PWD"

if [ "$2" = "make" ]; then
	echo make all
	make all
else
	echo make clean	
	make clean	
fi


