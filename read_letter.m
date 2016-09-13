function letter=read_letter(imagn,num_letters)
% Computes the correlation between template and input image
% and its output is a string containing the letter.
% Size of 'imagn' must be 42 x 24 pixels
% Example:
% imagn=imread('D.bmp');
% letter=read_letter(imagn)
global templates
comp=[ ];
for n=1:num_letters
    sem=corr2(templates{1,n},imagn);
    comp=[comp sem];
end
vd=find(comp==max(comp)); %index of highest corr value in comp array
%*-*-*-*-*-*-*-*-*-*-*-*-*-

letters = {'BAA ' 'BHE ' 'DHAU ' 'GA ' 'JA ' 'KA ' 'MEY ' 'MA ' 'KO ' 'NAA ' 'RAA ' 'LU ' 'SA ' 'SEY ' 'YNA ' ' CHA ' ' PA ' ' YA ' ' GHA ' ' BA ' ' KHA ' ' JA ' '1' '2' '3' '4' '5' '6' '7' '8' '9' '0'};
letters = cellstr(letters);
letter = letters{vd}

