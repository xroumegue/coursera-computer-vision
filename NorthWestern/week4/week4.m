pkg load image;

function out = mse(x, y)
	out = sum(((x  - y).^2)(:)) / (length(x(:)));
endfunction

function out = mae(x, y)
	out = sum(abs(x - y)(:)) / length(x(:));
endfunction


printf('------Ex3------\n')

a = [1 1 2 2;1 1 2 2;2 2 3 4;2 2 5 6];
b = [2 2 1 1;2 2 2 2;2 2 6 4;2 2 5 3];
mse(a, b)

printf('------Ex4------\n')

x = [10 20 10 10; 20 40 10 10; 30 40 20 20; 50 60 20 20];
a = [10 20 10 10; 20 40 10 10; 20 20 30 40; 20 20 50 60];
b = [20 30 20 20; 30 50 20 20; 40 50 30 30; 60 70 30 30];
c = [10 20 30 40; 20 40 50 60; 10 10 20 20; 10 10 20 20];
d = [1 2 1 1; 2 4 1 1; 3 4 2 2; 5 6 2 2];

printf('MAE(x,a): %.2f\n', mae(x, a));
printf('MAE(x,b): %.2f\n', mae(x, b));
printf('MAE(x,c): %.2f\n', mae(x, c));
printf('MAE(x,d): %.2f\n', mae(x, d));

printf('------Ex8------\n')

I1=double(imread("frame_1.jpg"));
I2=double(imread("frame_2.jpg"));

Bt=I2(65:96,81:112);


subplot(2, 2, 1);
imshow(uint8(I1));
subplot(2, 2, 2);
imshow(uint8(I2));
subplot(2, 2, 3);
imshow(uint8(Bt));


best = [ 255 * length(Bt(:)), 0, 0 ];

for x = 1:1:(size(I1, 1) - size(Bt, 1) + 1)
	for y = 1:1:(size(I1, 2) - size(Bt, 2) + 1)
		Bx = I1(x: x + size(Bt, 1) - 1, y: y + size(Bt, 2) - 1);
		err = mae(Bx, Bt);
		if err < best(1)
			best = [ err, x, y ];
		endif
	endfor
endfor

subplot(2, 2, 4);
imshow(uint8(I1(best(2): best(2) + size(Bt, 1) - 1, best(3): best(3) + size(Bt, 2) - 1)));

printf("best block matching at (%d, %d - %d), mae: %2.f\n", best(2), best(3), best(2) + best(3), best(1) );
