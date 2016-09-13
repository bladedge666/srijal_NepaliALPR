function [fl, re] = lines(im_text) % function ret_val = fun_name(ip_args)
% Divide text in lines
% im_texto->input image; fl->first line; re->remain line
% Example:
% im_texto=imread('TEST_3.jpg');
% [fl re]=lines(im_texto);
% subplot(3,1,1);imshow(im_texto);title('INPUT IMAGE')
% subplot(3,1,2);imshow(fl);title('FIRST LINE')
% subplot(3,1,3);imshow(re);title('REMAIN LINES')

% black bg, white fg
im_text = clip(im_text); % after the crop *** do imshow(im_texto) during debugging
num_rows = size(im_text,1);

for curr_row = 1:num_rows       %for each row in the cropped image
    if sum(im_text(curr_row,:)) == 0    %sum of pixels in the current_row, all columns of that row. i.e horizontal projection **0 means black**
        nm = im_text(1:curr_row-1, :); % First line matrix
        rm = im_text(curr_row:end, :); % Remain line matrix **includes the extra blacks after first line**
        fl = clip(nm);
        re = clip(rm);
        %*-*-*Uncomment lines below to see the result*-*-*-*-
%              subplot(2,1,1);imshow(fl);
%              subplot(2,1,2);imshow(re);
        break
    else % sum is greater than 0. i.e number of white pixels present
        fl = im_text;%Only one line.
        re = [ ];
    end
end

function img_out=clip(img_in) 
[f, c]=find(img_in); % find returns indices of each nonzero element i.e. 1 for bw image -> means indices of white pixels
img_out=img_in(min(f):max(f), min(c):max(c));%Crops image
% slicing -> from minimum pixel coordinate where white or '1' pixel
% occurs to max white pixel in the row coordinate 'f' part