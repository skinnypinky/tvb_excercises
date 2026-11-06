%% 1. Compute the average u of the numbers a = 6.371 and b = 6.373 using
% equation (1.1) and based 10 arithmetic. Compare the result u to the value û
% obtained when the result of each arithmetic operation is rounded to 4
% significant figures
clear;
clc;
close all;

a = 6.371;
b = 6.373;

c = a + b;
u = c / 2;

% Rounded to four significant figures:
c_r = round(a + b, 4, "significant");
u_r = round(c_r / 2, 4, "significant");

disp(u - u_r)

% result u = 6.3720, û = 6.3700, difference = 0.0020

%% 2. show that the average u of two numbers can also be computed using the
% following three steps:
%
%               d = b - a     (1.5)
%               p = d/2       (1.6)
%               u = a + p     (1.7)
%
% Verify that this algorithm avoids the problems found in Example 1.1 and
% Problem 1
clear;
clc;
close all;

a = 6.371;
b = 6.373;

d = b - a;
p = d / 2;
u = a + p;

% Rounded to four significant figures:
d_r = round(b - a, 4, "significant");
p_r = round(d / 2, 4, "significant");
u_r = round(a + p, 4, "significant");

assert(u == u_r)

% result u = 6.3720, û = 6.3720

%% 3. Write a MATLAB function myHarmonic which computes the harmonic 
% numbers H_n given by equation (1.2). The call sequence should be
%
%           s = myHarmonic(n, direction)
%
% where n is the number of terms and direction is an integer which
% specifies the summation order.

% let mod(direction, 2) act as a boolean (0; left, 1; right). Meaning odd
% inputs for direction subtracts and even adds.
clear;
clc;
close all;

n = 2^22;

backward = myHarmonic(n, 0);
forward = myHarmonic(n, 1);

% results:
% backward = 15.8296
% forward = 15.4037

function s = myHarmonic(n, direction)
    if not((n > 0) && (floor(n) == n)) || (floor(direction) ~= direction)
        myException = MException('myHarmonic:inputError', 'n must be Natural number and direction must be integer');
        throw(myException);
    end

    if mod(direction, 2) == 0
        start_val = n;
        increment_by = -1;
        end_val = 1;
    else
        start_val = 1;
        increment_by = 1;
        end_val = n;
    end
    

    s = single(0);
    for j = start_val:increment_by:end_val
        s = s + single(1 / j);
    end
end

%% 4. Consider three polynomials p_i: R -> R given by
%
%           p_1(x) = x^4 - 4x^3 + 6x^2 - 4x + 1,
%           p_2(x) = (((x-4)x + 6)x-4)x+1,
%           p_3(x) = (x-1)^4
%
%   (a) Show that
%
%               p_1(x) = p_2(x) = p_3(x)
%
%       in exact arithmetic.
%
%   (b) Plot the graph of three polynomials using MATLAB and n = 2^8 + 1
%   equidistant points in the interval [1 - 2^-20, 1 + 2^-20].
%   Use the subplot command to create a separate subfigure for each
%   expression
%
%   (c) Which of the three curves matches the mathematical reality?
%
%   (d) What information is hidden inside the equations for p_1 and p_2,
%   but exposed by equation for p_3

% (a)

% p_1(x) = x^4 - 4x^3 + 6x^2 - 4x + 1,
% p_2(x) = (((x-4)x + 6)x-4)x+1,
% p_3(x) = (x-1)^4

% (x - 1)^4 = (x-1)^2 * (x-1)^2 = (x^2-2x+1)(x^2-2x+1) =
% x^4 - 2x^3 + x^2 - 2x^3 + 4x^2 - 2x + x^2 - 2x + 1 =
% x^4 - 4x^3 + 6x^2 - 4x + 1            (p_3(x) = p_1(x))
% (x^3 - 4x^2)x + 6x^2 - 4x + 1
% ((x^2 - 4x)x + 6x)x - 4x + 1
% (((x - 4)x + 6)x - 4)x + 1           (p_3(x) = p_1(x) = p_2(x))

% (b)
clear;
clc;
close all;

p_1 = @(x) x.^4 - 4*x.^3 + 6*x.^2 - 4*x + 1;
p_2 = @(x)(((x - 4).*x + 6).* x - 4).*x + 1;
p_3 = @(x)(x - 1).^4;

x = linspace(1 - 2^-20, 1 + 2^-20, 2^8 + 1);

figure;

subplot(2,2,1);
plot(x - 1, p_1(x));
title("Polynomial 1")
grid on;

subplot(2,2,2);
plot(x - 1, p_2(x));
title("Polynomial 2")
grid on;

subplot(2,2,[3,4]);
plot(x - 1, p_3(x));
title("Polynomial 3")
grid on;

% (c)
% Polynomial 3 matches the mathematical reality because
% p_3(x) = (x-1)^4 is always nonnegative.
% Polynomials 1 and 2 produce negative values due to
% rounding errors

% (d)
% p_3 explicitly shows that the polynomial is nonnegative for every real x,
% and that its minimum value is zero. Which is not immediately apparent
% from the expressions for p_1 and p_2.