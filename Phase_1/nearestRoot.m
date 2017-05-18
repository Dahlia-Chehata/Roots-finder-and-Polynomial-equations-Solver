function [trueRoot, good] = nearestRoot(func, val)
%NEARESTROOT Summary of this function goes here
%   Detailed explanation goes here

[trueRoot,~,good] = fzero(func, val);
end

