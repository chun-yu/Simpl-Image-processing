                                                                            clc, clear
img = imread('21.jpg');
imwrite(img,'21.bmp');
[height, width] = size(img);

img_double = im2double(img);

while(1)
    
disp('請輸入你想處裡圖片的方法：');
disp('a) mean filter  b) Sobel horizontal  c) Sobel vertical');
str =input('d) Laplacian  e) Laplacian unshape 請輸入abce  :' , 's');

temp = img_double;

switch str
    case 'a'
        disp(str);
        disp('mean filter');
        
        matrix = ones(3);
        for x = 1:height-2
            for y = 1:width-2
                c = img_double(x:x+2 , y:y+2).*matrix;
                s = sum(sum(c));
                temp(x+1 , y+1) = s / 9;
            end
        end
        img2=im2uint8(temp);
        imshow(img2);
        str3=[str '.bmp'];
        imwrite(img2,str3)
        
    case 'b'
        disp(str);
        disp('Sobel horizontal');

        matrix = [-1 -2 -1;0 0 0;1 2 1];
        for x = 1:height-2
            for y = 1:width-2
                c = img_double(x:x+2 , y:y+2).*matrix;
                s = sum(sum(c));
                temp(x+1 , y+1) = s+0.5;
            end
        end
        img2=im2uint8(temp);
        imshow(img2);
        str3=[str '.bmp'];
        imwrite(img2,str3)
        
    case 'c'
        disp(str);
        disp('Sobel vertical');
        
        matrix = [-1 0 1;-2 0 2;-1 0 1];
        for x = 1:height-2
            for y = 1:width-2
                c = img_double(x:x+2 , y:y+2).*matrix;
                s = sum(sum(c));
                temp(x+1 , y+1) = s+0.5;
            end
        end
        img2=im2uint8(temp);
        imshow(img2);
        str3=[str '.bmp'];
        imwrite(img2,str3)
        
    case 'd'
        disp(str);
        disp('Laplacian');
        
        matrix = [-1 -1 -1;-1 8 -1;-1 -1 -1];
        for x = 1:height-2
            for y = 1:width-2
                c = img_double(x:x+2 , y:y+2).*matrix;
                s = sum(sum(c));
                temp(x+1 , y+1) = s+0.5;
            end
        end
        img2=im2uint8(temp);
        imshow(img2);
        str3=[str '.bmp'];
        imwrite(img2,str3)
        
    case 'e'
        disp(str);
        disp('Laplacian 影像銳化');
        
        a=0.5;
        b=[0 0 0;0 1 0;0 0 0];
        c=[-1 -1 -1;-1 8 -1;-1 -1 -1];
        matrix=b+a*c;
        for x = 1:height-2
            for y = 1:width-2
                c = img_double(x:x+2 , y:y+2).*matrix;
                s = sum(sum(c));
                temp(x+1 , y+1) = s;
            end
        end
        img2=im2uint8(temp);
        imshow(img2);
        str3=[str '.bmp'];
        imwrite(img2,str3)
        
    otherwise
        disp('======================');
        disp('Hello !!  Please try again .');
        break;
end
end

        