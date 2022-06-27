1. Change owner of log file to your current user using chown

admon@pop-os:~/Downloads/log20170630$ chown admon log20170630.csv
admon@pop-os:~/Downloads/log20170630$ ls -l
итого 2662616
-rw------- 1 admon admon 2726513049 Jan  9  2018 log20170630.csv

2. Change set executive bit to a random.sh script using chmod

chmod +x script.sh

3. Execute the random.sh script

./script.sh 

4. Find the file using find

admon@pop-os:~/Downloads/log20170630$ find . -name log20170630.csv
./log20170630.csv


5. Try to look for errors using your favorite editor
admon@pop-os:~/Downloads/log20170630$ grep 'user' log20170630.csv
66.249.66.chj,2017-06-30,00:13:25,0.0,1140467.0,0001019155-09-000741,f6postamendanheuserinbev.htm,304.0,248.0,0.0,0.0,0.0,10.0,0.0,66.249.66.jjh,2017-06-30,00:20:24,0.0,310569.0,0001068800-07-000086,anheuser-8k.htm,304.0,248.0,0.0,0.0,0.0,10.0,0.0,
54.165.81.gbi,2017-06-30,00:32:23,0.0,1021635.0,0001021635-17-000061,powerofattorney-hauserplai.txt,200.0,2087.0,0.0,0.0,0.0,10.0,0.0,

6. Try to find errors using grep
admon@pop-os:~/Downloads/log20170630$ grep 'user' log20170630.csv
66.249.66.chj,2017-06-30,00:13:25,0.0,1140467.0,0001019155-09-000741,f6postamendanheuserinbev.htm,304.0,248.0,0.0,0.0,0.0,10.0,0.0,66.249.66.jjh,2017-06-30,00:20:24,0.0,310569.0,0001068800-07-000086,anheuser-8k.htm,304.0,248.0,0.0,0.0,0.0,10.0,0.0,
54.165.81.gbi,2017-06-30,00:32:23,0.0,1021635.0,0001021635-17-000061,powerofattorney-hauserplai.txt,200.0,2087.0,0.0,0.0,0.0,10.0,0.0,

7. Tail last 500 lines of file

 tail  +500 log20170630.csv


8. Find how many index.htm hits were at 30.06.2017 14:00
stat 
 find . -newer

9. Find how many index.htm hits were at 30.06.2017 17:00-18:00

10. Show the number of times each IP shows up in the log – using sort and uniq utilities..

netstat -a -l -t -n | sort -n


11. Count all 13.94.212.jdf IP hits us