pkg load image;

function out = mse(x, y)
	out = sum(((x  - y).^2)(:)) / (length(x(:)));
endfunction

function out = psnr(x, y, d)
	out = (20 * log10(d)) - (10 * log10(mse(x, y)));
endfunction

% Read the noisy and clean images
Inoisy=double(imread("pic_noisy.gif"));
Ioriginal=double(imread("pic_original.jpg"));


Ifiltered1 = medfilt2(Inoisy);
Ifiltered2 = medfilt2(Ifiltered1);


% Plot the pics
subplot(2, 2, 1);
imshow(uint8(Inoisy));

subplot(2, 2, 2);
imshow(uint8(Ioriginal));

subplot(2, 2, 3);
imshow(uint8(Ifiltered1));

subplot(2, 2, 4);
imshow(uint8(Ifiltered2));

% compute psnr
printf("PSNR between clean and noisy images: %.2f\n", psnr(Inoisy, Ioriginal, 255));
printf("PSNR between clean and 1st pass filtered images: %.2f\n", psnr(Ifiltered1, Ioriginal, 255));
printf("PSNR between clean and 2nd pass filtered images: %.2f\n", psnr(Ifiltered2, Ioriginal, 255));
