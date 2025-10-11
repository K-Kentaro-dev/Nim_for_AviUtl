switch("path", "../src")

#Compiler = Visual Studio(x86)
--cc:vcc
--cpu:i386
#Runtime check
--objChecks:off
--fieldChecks:off
--rangeChecks:off
--boundChecks:off
--overflowChecks:off
--floatChecks:off
--nanChecks:off
--infChecks:off
#dll option
--app: lib
--nomain
#memory
--mm:orc