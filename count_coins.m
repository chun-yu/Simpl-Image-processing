clc;
clear;
str = 'Select a color image';
[filename, pathname, filterindex]  = uigetfile({'*.jpg';'*.bmp';'*.png'},str);
ORI = imread([pathname filename]);
%��Sobel=============[height, width]
A=ORI;
A=rgb2gray(A);
img3 = edge(A,'Sobel');
str3=['sobel' '.bmp'];
imwrite(img3,str3)
[height,width] = size(img3);
Min = 10;
Max = 30;
% ���ꪺ�Ѽ�  ===============
step_r=0.5;
step_angle = 1;
r_level = round((Max-Min)/step_r)+1;  
hough_space = zeros(height,width,r_level);
[rows,cols] = find(img3);
ecount = size(rows);
angle = 360;
rate =110; %�H��
% ��ꪺ����  ===============
for i=1:ecount  
    for r=1:r_level  
        for k=1:angle  
            a = round(rows(i) - (Min+(r-1)*step_r)*cos(k*pi/180));
            b = round(cols(i) - (Min+(r-1)*step_r)*sin(k*pi/180));
            if(a>0 && a<=height && b>0 && b<=width)
                hough_space(a,b,r) = hough_space(a,b,r)+1;  
            end
        end  
    end  
end
% ���ꪺ���  ===============
hough_circle = false(height,width);  
max_para = max(max(max(hough_space)));
% �����ߪ��I�аO  =============== 
for i=1:height  
    for j=1:width
        maxr = 0;
        for r=1:r_level  
            if(hough_space(i,j,r) >= rate)
                if maxr < r
                    maxr = r;
                end
            end  
        end
        if maxr > 0
            hough_circle(i,j) = true;   %??��? 
        end
    end  
end
% �䰪���ƶ�߼ƶq�P��ߥb�|  ===============
imshow(hough_circle);
[point_row,point_col] = find(hough_circle);
point_count = size(point_row);
point_r = zeros(point_count);
for i=1:point_count
    maxr=0;
    for r=1:r_level
        if(hough_space(point_row(i),point_col(i),r) >= rate)
            if maxr < r
                maxr = r;
            end
        end  
    end
    if maxr > 0
        point_r(i) = maxr;
    end
end
% �q�C�Ӷ�ߪ��b�|�d�򤺥h�W�@ ����ư��B�b�|�̤j������I  ===============
Max_r_index = zeros(point_count);
for i=1:point_count
    rr =Min+(point_r(i)-1)*step_r;
    maxrr = rr;
    maxr_index = i;
    maxspace=hough_space(point_row(i),point_col(i),point_r(i));
    for ii=1:size(Max_r_index)
        r_index = Max_r_index(ii);
        if r_index>0
            a=[point_row(i) point_col(i)];
            b=[point_row(r_index) point_col(r_index)];
            if norm(a-b) <= rr+(Min+(point_r(r_index)-1)*step_r)-1
                    space = hough_space(b(1),b(2),point_r(r_index));
                    if space >= maxspace
                        maxrr = Min+(point_r(r_index)-1)*step_r;
                        maxr_index = r_index;
                        maxspace=space;
                    else 
                        r_index = maxr_index;
                    end
            end
        end
        Max_r_index(ii)=r_index;
    end
    Max_r_index(i) = maxr_index;
end
% �έp��߯u�����Ӽ�  ===============
circle_count = numel(unique(Max_r_index));
Max_r_index = unique(Max_r_index);
[height,width] = size(img3);
hough_circle2 = false(height,width);
point_r2 = zeros(size(Max_r_index));
point_row2 = zeros(size(Max_r_index));
point_col2 = zeros(size(Max_r_index));
% ���u����ߪ��е�  ===============
for w = 1:size(Max_r_index)
    index = Max_r_index(w);
    point_r2(w) = point_r(index);
    point_row2(w) = point_row(index);
    point_col2(w) = point_col(index);
    hough_circle2(point_row(index),point_col(index)) = true;
end
imshow(hough_circle2);
% �N��X����߻P�b�| �h�e���òέp�w���j�p  ===============
outimg = ORI;
one =0;five =0;ten =0;fifty =0;
for i=1:size(Max_r_index)  
    r =  Min+(point_r2(i)-1)*step_r;
    % ���X�Ӷ�ߪ��b�|�h�����w������  ===============
    if r < 18 
         R = 238;
         G = 130;
         B = 238;
         one =one+1;
    elseif r >= 18 && r < 20 
         R = 102;
         G = 255;
         B = 89;
         five =five+1;
    elseif r >= 20 && r < 23.5
         R = 51;
         G = 230;
         B = 204;
         ten =ten+1;
    else
         R = 255;
         G = 191;
         B = 0;
         fifty =fifty+1;
    end
    % �h�аO360����b�Ϥ��W �õe�e�׬�5 �H������
    for k=1:angle  
        for ii=1:5
            a = round(point_row2(i) - (r+ii-1)*cos(k*pi/180));
            b = round(point_col2(i) - (r+ii-1)*sin(k*pi/180));
            if(a>0 && a<=height && b>0 && b<=width)
                 outimg(a,b,1) = R;
                 outimg(a,b,2) = G;
                 outimg(a,b,3) = B;
            end
        end
    end   
end
% ��X�Ϥ���
imshow(outimg);
name = filename(1:find(filename=='.')-1);
str3=string(name)+'_output'+'.bmp';
imwrite(outimg,str3)
[count c] = size(Max_r_index);
money = fifty*50+ten*10+five*5+one*1;
fprintf('�`�w���ƶq :  %d  �� \n',count);
fprintf('�`�� :  %d  �� \n',money);
