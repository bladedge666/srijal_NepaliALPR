%creating a "videoinput" abject 'v'
v=videoinput('winvideo', 1, 'MJPG_1280x720');
%storing the image in 'im' variable
im=getsnapshot(v);
%displaying the captured image
imshow(im);
%writing/storing the captured image in the hard-disk
%imwrite(im, 'capture.jpg');
%deleting the "videoinput" object to avoid filling up of memory
delete(v);