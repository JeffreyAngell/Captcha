num=1
while [ $num -lt 1001 ]
do 
mv `ls Images/captcha-* | shuf -n 1` Images/captcha+$num.png 
num=`expr $num + 1`
done
