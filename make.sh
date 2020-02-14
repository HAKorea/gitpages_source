#!/bin/sh

OUT_FILE=./source/modified.html
OUT_ALLFILE=./source/modified_all.html
MODIFIED=`cd public && git log --name-only -p -1|grep html`
echo $MODIFIED

ADD_CONT=""

for i in ${MODIFIED[@]}

do
	echo  "[insert] "$i
	if [[ "$i" =~ "html" && ! "$i" == "index.html" && ! "$i" == "modified_all.html" ]];then
		FILENAME=`echo $i|awk -F/ '{print $(NF-1)}'`
		echo "====>"$FILENAME
 		ADD_CONT=$ADD_CONT"<li><a href=\"/${i}\">${FILENAME}</a></li> \n"
	fi
done

echo $ADD_CONT > $OUT_FILE

MOD_DATE=`date "+%Y-%m-%d"`
ADD_CONT="<h2>${MOD_DATE}</h2>\n<ul>\n"$ADD_CONT"</ul>"
L_CNT=0
L_BUFFER=""
while read line
do
	if [ $L_CNT -eq 4 ];then
		L_BUFFER=$L_BUFFER"\n"$ADD_CONT"\n"$line
	else
		if [ $L_CNT -eq 0 ];then
			L_BUFFER=$line
		else
			L_BUFFER=$L_BUFFER"\n"$line
		fi
	fi
	L_CNT=`expr $L_CNT + 1`
done < $OUT_ALLFILE
echo $L_BUFFER > $OUT_ALLFILE
