%this function outputs a Nx2 Matrix, carrying the indeces of all matrix
%entries (in the format (y coordinate, xcoordinate)
%surrounding the circle of radius R within the distance delta
%
%input arguments are
%                   SizeOfImageData is a 1,2 vector the size of the imageData (prbbly
%                   for best results it should be a nxn matrix, because
%                   anything else implies rectangular pixels)
%
%                   centerPoint a vector of the form (y coordinate, x
%                   coordinate) which is the center of the circle
%
%                   Radius (the radius of the circle), unit of distance is
%                   in pixel (array indices)
%
%                   delta the maximal distance that a pixel can be from the
%                   circumference to qualify
%                   

function outputMatrix = findCirclePixels( SizeOfImageData, centerPoint, radius, delta)

%[yyMax xxMax] = size(ImageData);
    
index =0;



outputMatrix=NaN(ceil(4*delta*delta),2);

for (xx=1:SizeOfImageData(1,1))
    for (yy= 1:SizeOfImageData(1,2))
        
        currentPos = [yy, xx];
        
        if ( abs((norm(currentPos - centerPoint) -radius )) <= delta )
            % if the pixel is within the distance delta of the
            % circumference
            index = 1+ index;
            outputMatrix(index,:) = currentPos; 
         
            
        end
    end
end
end




