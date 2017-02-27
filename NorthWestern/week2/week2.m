pkg load image;

function out = mse(x, y)
	out = sum(((x  - y).^2)(:)) / (length(x(:)));
endfunction

function out = psnr(x, y, d)
	out = (20 * log10(d)) - (10 * log10(mse(x, y)));
endfunction

function [psnr, img_f ] = cv_filter(order, img_file)
	img = double(imread(img_file));
	f = ones(order, order) * 1/(order^2);
	img_f = imfilter(img, f, 'replicate');
	psnr = psnr(img_f, img, 255);	
endfunction

subplot(1, 3, 1);
imshow(imread('pic.gif'));

subplot(1, 3, 2);
title('3x3 filter');
[ psnr_3, image] = cv_filter(3, 'pic.gif');
printf('PSNR(3x3) is %.3f dB\n', psnr_3);
imshow(uint8(image));

subplot(1, 3, 3);
title('5x5 filter');
[ psnr_5, image] = cv_filter(5, 'pic.gif');
printf('PSNR(5x5) is %.3f dB\n', psnr_5);
imshow(uint8(image));
