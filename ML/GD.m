function [theta, J_history] = GD(X, y, theta, alpha, num_iters, costFunction )
%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
  
    m = length(y); % number of training examples

    J_history = zeros(num_iters, 1);
    for iter = 1:num_iters
        theta = theta - alpha/m * ( X' * (  X * theta - y ));
        if exist('costFunction', 'var' ) 
          J = costFunction(X,y,theta);
        else
          J = 1/(2*m)*sum((X*theta-y).^2);
        endif
        J_history(iter) = J;
    end    
end
