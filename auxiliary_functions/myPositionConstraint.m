function [ actualConstraintFct ] = myPositionConstraint( varargin )
%MYPOSITIONCONSTRAINT Summary of this function goes here
%   Detailed explanation goes here

persistent positionX;
persistent positionY;

if nargin
   handles=varargin{1};
    positionX=handles.calculated.xCenter;
    positionY=handles.calculated.yCenter;   
elseif isempty(positionX)||isempty(positionY)
    error('This shoudn''t happen. 0 Parameter myPositionConstraint called with empty posX/posY');
end

actualConstraintFct=makeConstrainToRectFcn('impoint', [positionX,positionX], [positionY,positionY]); 

end

