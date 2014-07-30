function distance = d( x  , y , i1 , i2 )
	distance=zeros(length(x),length(y));
        for j=1:i1-1 
            distance(i1,j) = sqrt( ( x(i1)-x(j) )^2 + ( y(i1) - y(j) )^2 );
        end
        
        for k=1:i2-1
             distance(i2,k) = sqrt( ( x(i2)-x(k) )^2 + ( y(i1) - y(k) )^2 );
        end
end