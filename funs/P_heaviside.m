%% The projection on Heaviside set \|u_+\|_0 <= s
 function [T] = P_heaviside(z,s)
   supp_p = find(z>0); 
   supp_0 = find(z==0);
   if s >= size(supp_p)
       T = supp_0;
   elseif s==0
       T = union(supp_p,supp_0);
   else
    zp = sort(z,'descend');  
    sz = zp(s);
   supps =  find(z>=sz);
   supp_s = supps(1:s);
   Ts = setdiff(supp_p,supp_s);
   T = union(Ts,supp_0);
   end
end