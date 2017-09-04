cd src
csc -c *.scm
rm main.o
csc main.scm *.o
rm *.o
mv main ../
