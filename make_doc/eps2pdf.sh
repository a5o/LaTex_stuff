#! /bin/sh
echo -en "\\033[1m"
echo "Converting eps images to pdf..."
echo -en "\\033[0m"
for image in `ls *.eps 2>/dev/null`;
do
	if [ -e `echo $image|sed "s/\.eps$//"`.pdf ]; then
		echo -n ""
	else
		echo -en "\\033[1mconverting\\033[0m $image \\033[1mto\\033[0m `echo $image|sed "s/\.eps$//"`.pdf...";
		epstopdf $image;
		echo -e " \\033[1;32m done \\033[0m"
	fi
done
