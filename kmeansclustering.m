function C = kmeansclustering(X,K,mu,tol,maxIter)
    D = size(X,1);
    N = size(X,2);
    C = zeros(1,N);
    change = tol + 1;
    it=0;
    temp = X';
    
    while change>tol && it < maxIter

     % ===== Assign points to current centers ===== 
     % ===== Recalculate centers =====
     
        for i = 1:N
           m = 1;
           min_distance = norm(X(:,i) - mu(:,1));
           for j = 2:K
              distance = norm(X(:,i) - mu(:,j));
              g = distance - min_distance;
              if min_distance > distance
                  min_distance = distance;
                  m = j;
              end
           end
           C(i) = m;
        end

        mu_New = zeros(D,K);
        for i = 1:K
            xi = temp(C==i,:)
            size_xi = size(xi);
            sk = size(xi,1);
            if sk == 1
               sumxi = xi ;
            else
                sumxi = sum(xi);
            end          
            centroid = (sumxi / sk);
            mu_New(:,i) = centroid;
        end
        
        diff = abs(mu - mu_New);
        if all(diff < tol)
            change = tol - 1;
        end

        mu = mu_New
        it = it + 1
    end
end