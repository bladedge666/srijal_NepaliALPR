warning off %#ok<WNOFF>
% Clear all
clc, close all, clear all;
% Read image
[FileName, PathName] = uigetfile('*.jpg;*.png','Select the image');
img = imread([PathName, FileName]);
% Show image
imshow(img);

%title('INPUT IMAGE WITH NOISE')
% Convert to gray scale
if size(img,3)==3 %RGB image
    img=rgb2gray(img);
end
% Convert to BW
img = imadjust(img);
threshold = graythresh(img);

% invert '~' the following code for light bg and dark fg
img = im2bw(img,threshold);
if img(1,1) == 1 % will output 1(true) if pixel at 1,1 is white
   img = ~img; 
end
img = im2double(img);
img = imgaussfilt(img,1);
imshow(img);pause(1)
% Remove all object containing fewer than 30 pixels
% img = bwareaopen(img,10);
%Storage matrix word from image
word=[ ];
remaining_lines=img;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
% Compute the number of letters in template file
num_letters=size(templates,2);
while 1
    %Fcn 'lines' separate lines in text
    [first_line, remaining_lines]=lines(remaining_lines);
    imgn=first_line;
    %Uncomment line below to see lines one by one
    imshow(first_line);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L, NofLabels] = bwlabel(imgn);  

    for n=1:NofLabels  % for every label in the current line of imgn
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
 %        imshow(img_r);pause(0.5);
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        
        img_r = ~img_r;
        letter = read_letter(img_r,num_letters);
        % Letter concatenation
        word=[word letter];
    end
    %fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(remaining_lines)  %See variable 're' in Fcn 'lines'
        break
    end    
end
fclose(fid);
%Open 'text.txt' file
winopen('text.txt')

