clear;
%read image
% rgb=imread('carplate2.jpg');



rgb=imread('t11.jpg');

% -----------------------------------

rgb=imresize(rgb,[400 NaN]);                   
imshow(rgb);


% ----------------------------------


% imshow(rgb);


%rgb to grascale

% g=rgb

g=rgb2gray(rgb);
% imshow(g);

% g=imadjust(g);
% imshow(g);


%remove noise
Kmedian = medfilt2(g,[3 3]);
imshow(Kmedian);



%calculate global threshold level using otsu's thresholding method
% thresholdlevel = graythresh(Kmedian);

%convert grascale to binary
% binaryImgae = imbinarize(Kmedian,thresholdlevel);
% imshow(binaryImgae);




%**********************************
conc=strel('disk',1);
gi=imdilate(Kmedian,conc);
ge=imerode(Kmedian,conc);            %%%% morphological image processing
gdiff=imsubtract(gi,ge);
gdiff=mat2gray(gdiff);
gdiff=conv2(gdiff,[1 1;1 1]);
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],.1);
B=logical(gdiff);
[a1 b1]=size(B);
figure(2)
imshow(B)
er=imerode(B,strel('line',100,0));
figure(3)
imshow(er)
out1=imsubtract(B,er);
F=imfill(out1,'holes');      %%%filling the object
H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',3,90));
figure(4)
imshow(H)
%%
final=bwareaopen(H,floor((a1/15)*(b1/15)));  
final(1:floor(.9*a1),1:2)=1;
final(a1:-1:(a1-20),b1:-1:(b1-2))=1;
% yyy=template(2.00);

figure(5)
imshow(final)
Iprops=regionprops(final,'BoundingBox','Image');
hold on
for n=1:size(Iprops,1)
    rectangle('Position',Iprops(n).BoundingBox,'EdgeColor','g','LineWidth',2); 
end
hold off
NR=cat(1,Iprops.BoundingBox);   %%Data storage section
[r ttb]=connn(NR);

if ~isempty(r)
    
    
    xlow=floor(min(reshape(ttb(:,1),1,[])));
    xhigh=ceil(max(reshape(ttb(:,1),1,[])));
    xadd=ceil(ttb(size(ttb,1),3));
    ylow=floor(min(reshape(ttb(:,2),1,[])));    %%%%%area selection
    yadd=ceil(max(reshape(ttb(:,4),1,[])));
    final1=H(ylow:(ylow+yadd+(floor(max(reshape(ttb(:,2),1,[])))-ylow)),xlow:(xhigh+xadd));
    [a2 b2]=size(final1);
    final1=bwareaopen(final1,floor((a2/20)*(b2/20)));
    figure(6)
    imshow(final1)
    
   
    Iprops1=regionprops(final1,'BoundingBox','Image');
    NR3=cat(1,Iprops1.BoundingBox);
    I1={Iprops1.Image};
    
    for n=1:size(Iprops1,1)
        
        figure(n+6)
        imshow(I1{1,n});
        
      
    end
    
        

end


