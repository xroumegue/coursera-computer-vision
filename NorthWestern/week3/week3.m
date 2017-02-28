pkg load image;
ex6 = [ 1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16];
printf("ex6 answer is %d\n", fft2(ex6, size(ex6))(1,1));

ex7 = [ 2 1 0 1; 1 0 0 0; 1 0 0 0];
printf("ex7 FFT:");
fft2(ex7, size(ex7))


printf("------ ex8----------:\n");

subplot(1, 3, 1);
img_raw = imread('pic.jpg');
imshow(img_raw);

img = double(img_raw);

f = ones(3, 3)/9;
img_f = imfilter(img, f, 'replicate');

subplot(1, 3, 2);
imshow(uint8(img_f));

% scale down
img_down= img_f(1:2:end, 1:2:end);
%size(img_down)

% scale up
img_up = zeros(359, 479);
%size(img_up(1:2:end, 1:2:end))
img_up(1:2:end, 1:2:end) = img_down;
f_low = [0.25 0.5 0.25; 0.5 1 0.5; 0.25 0.5 0.25];
img_up_filtered = imfilter(img_up, f_low);
subplot(1, 3, 3);
imshow(uint8(img_up_filtered));

function out = mse(x, y)
	out = sum(((x  - y).^2)(:)) / (length(x(:)));
endfunction

function out = psnr(x, y, d)
	out = (20 * log10(d)) - (10 * log10(mse(x, y)));
endfunction

psnr = psnr(img_up_filtered, img, 255);

printf("PSNR is %d\n", psnr);
