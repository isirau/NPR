clear;
%read image
% rgb=imread('carplate2.jpg');
rgb=imread('t2.jpg');
figure(1)
imshow(rgb);


%rgb to grascale
g=rgb2gray(rgb);
figure(2)
imshow(g);

g=imadjust(g);
figure(3)
imshow(g);


%remove noise
Kmedian = medfilt2(g,[3 3]);
figure(4)
imshow(Kmedian);



%calculate global threshold level using otsu's thresholding method
thresholdlevel = graythresh(Kmedian);

%convert grascale to binary
binaryImgae = imbinarize(Kmedian,thresholdlevel);
figure(5)
imshow(binaryImgae);


labeledImage = bwlabel(binaryImgae);
figure(6)
imshow(labeledImage);
measurements=regionprops(labeledImage,'BoundingBox','Image');

if ~isempty(measurements)
    for n=1:size(measurements,1)
    rectangle('Position',measurements(n).BoundingBox,'EdgeColor','r','LineWidth',2);
    figure()
    imshow(measurements(n).Image);
    end

end
% figure(7)
imshow(labeledImage);










