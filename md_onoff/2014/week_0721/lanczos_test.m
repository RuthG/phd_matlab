%play with lanczos filter functions; do you understand??? NO!

s = [0,0,0,1,1,1];
x = 1:6;
a=2;
lanczos = sinc(x).*sinc(x./a);
