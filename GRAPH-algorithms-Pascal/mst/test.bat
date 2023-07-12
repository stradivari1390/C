@echo off
rem prim | sort >1.txt
primlst | sort >2.txt
pripqlst | sort >3.txt
fc /w /n 3.txt 2.txt >diff.txt
