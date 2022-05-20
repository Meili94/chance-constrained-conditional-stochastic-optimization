%% The projection on the constraint: unit simplex C. 
%alternating projection C = C1 \cap C0
% where C0 is the set of \sum_{i=1}^n x_i = 1, C1 is the set of x_i \geq 0.
function pstar = pro_unitsimplex(p0,m,innermaxiter,threshold)
%normal vector of the set C0
normal = ones(m,1);
for initer = 1:innermaxiter
  %projection on the set C0
  p1 = p0-1/m*(sum(p0)-1)*normal;
  %projection on the set C1
  p1 = max(p1,0);
  %compute error
  error = sum((p1-p0).^2);
  p0 = p1;
  if error < threshold
  end 
end
pstar = p0;
end
