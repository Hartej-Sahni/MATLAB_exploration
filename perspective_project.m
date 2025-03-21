function rout = perspective_project(rin,d)
    %PERSPECTIVE_PROJECT
    %
    % this function applies the perspective projection
    % based on the point [0,0,d] with the formula
    %
    % xnew = x/(1-z/d)
    % ynew = y/(1-z/d)
    %
    % input:
    % rin - a 3 x n array, each column rin(:,j) is a point to
    % be projected
    % d - the distance of the perspective point to the origin
    %
    % output:
    % rout - a 2 x n array, each column rout(:,j) is the perspective
    % projection of rin(:,j) onto the plane using the formula above
    x = rin(1,:);
    y = rin(2,:);
    z = rin(3,:);
    xnew = x./(1-z/d);
    ynew = y./(1-z/d);
    rout = [xnew; ynew];
