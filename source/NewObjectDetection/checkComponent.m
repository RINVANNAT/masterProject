function trueValue = checkComponent(C, B, A, D)


% ----------contruct vector from each point

 vector_AB = [B - A, 0] ; 
 vector_AD = [D - A, 0];

 vector_BC = [C - D, 0];
 vector_BD = [D - B, 0];
 
 vector_CA = [A - C, 0];
 vector_CD = [D - C, 0];


%-----------end vector contruction


%-----------compute cross product

cros_product1 = cross(vector_AD, vector_AB);
cros_product2 = cross(vector_BD,vector_BC );
cros_product3 = cross(vector_CD,vector_CA );

   
    
    if cros_product1(1,3) >= 0
        
        true1 = 1;
    else
        true1 =-1;
    end
    
    if cros_product2(1,3) >= 0
        
        true2 = 1;
    else
        true2 =-1;
    end
    if cros_product3(1,3) >= 0
        
        true3 = 1;
    else
        true3 =-1;
    end
    
    if (true1 == true2) && (true2 == true3)
        trueValue = 1;
    else
        trueValue = 0;
    end

end
