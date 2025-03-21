%Computer graphics example
%
% define some points on a rectangle in R^3
clearvars; clc; close all
rect_pts = [1 2 2 1 1;
            2 2 5 5 2;
            3 3 3 3 3];

d = 6;

%function r3_to_hom
function rout = r3_to_hom(R, d)
    xs = R(1,:);
    ys = R(2,:);
    zs = R(3,:);
    znew = 1 - (zs ./ d);
    [rows, cols] = size(R);
    zero_vector = zeros(1, cols);
    rout = [xs; ys; zero_vector; znew];
end
hom_coords = r3_to_hom(rect_pts, d)

%function hom_to_r3
function rout = hom_to_r3(H, d)
    xs = H(1,:);
    ys = H(2,:);
    zs = (1 - H(4,:)) * d;
    rout = [xs; ys; zs];
end
r3_coords = hom_to_r3(hom_coords, d)

%function plane_rotation_mat
function rot_matrix = plane_rotation_mat(iplane, gamma)
    if iplane == 1
        rot_matrix = [cos(gamma) -sin(gamma) 0 0;
                      sin(gamma) cos(gamma) 0 0;
                      0 0 1 0;
                      0 0 0 1];
    elseif iplane == 2
        rot_matrix = [cos(gamma) 0 -sin(gamma) 0;
                      0 1 0 0;
                      sin(gamma) 0 cos(gamma) 0;
                      0 0 0 1];
    elseif iplane == 3
        rot_matrix = [1 0 0 0;
                      0 cos(gamma) -sin(gamma) 0;
                      0 sin(gamma) cos(gamma) 0;
                      0 0 0 1];
    end
end

%test of function plane_rotation_mat
figure(1)
[rows, cols] = size(rect_pts);
rect_pts_4D = [rect_pts(1,:);
               rect_pts(2,:);
               rect_pts(3,:);
               ones(1, cols)];
plot3(rect_pts(1,:), rect_pts(2,:), rect_pts(3,:));
gamma = pi/4;
iplane = 1;
rot_matrix_xy = plane_rotation_mat(iplane, gamma);
rot_rect_pts_xy = rot_matrix_xy * rect_pts_4D;
hold on
plot3(rot_rect_pts_xy(1,:), rot_rect_pts_xy(2,:), rot_rect_pts_xy(3,:));
iplane = 2;
rot_matrix_xz = plane_rotation_mat(iplane, gamma);
rot_rect_pts_xz = rot_matrix_xz * rect_pts_4D;
plot3(rot_rect_pts_xz(1,:), rot_rect_pts_xz(2,:), rot_rect_pts_xz(3,:));
iplane = 3;
rot_matrix_yz = plane_rotation_mat(iplane, gamma);
rot_rect_pts_yz = rot_matrix_yz * rect_pts_4D;
plot3(rot_rect_pts_yz(1,:), rot_rect_pts_yz(2,:), rot_rect_pts_yz(3,:));
hold off

%projection from (0, 0, d)
%function perspect_proj_mat
function rout = perspect_proj_mat(d)
    rout = [1 0 0 0;
            0 1 0 0;
            0 0 0 0;
            0 0 -1/d 1];
end
perspect_matrix = perspect_proj_mat(d)

%test of function perspect_proj_mat
rect_proj = perspect_matrix * hom_coords; 
%normalization
rect_proj(1,:) = rect_proj(1,:) ./ rect_proj(4,:);
rect_proj(2,:) = rect_proj(2,:) ./ rect_proj(4,:);
rect_proj
figure(2)
plot3(rect_proj(1,:), rect_proj(2,:), rect_proj(3,:));
hold on
plot3(rect_pts(1,:), rect_pts(2,:), rect_pts(3,:));

% draw some perspective lines
for i = 1:cols
    x1 = 0; y1 = 0; z1 = d; % perpective point
    x2 = rect_pts(1,i); y2 = rect_pts(2,i); z2 = rect_pts(3,i);
    x3 = rect_proj(1,i); y3 = rect_proj(2,i); z3 = 0;
    xs = [x1,x2,x3];
    ys = [y1,y2,y3];
    zs = [z1,z2,z3];
    plot3(xs,ys,zs,'k--');
end
hold off

%projection from (0, d1, d2)
d1 = 5;
d2 = 15;

hex_pts = [0.5 1 2 2.5 2 1 0.5;
           3.5 2 2 3.5 5 5 3.5;
           3 3 3 3 3 3 3];
[rows, cols] = size(hex_pts);
rot_matrix = plane_rotation_mat(3, acos(d2/sqrt(d1^2 + d2^2)));
hex_pts_4D = [hex_pts(1, :); 
                  hex_pts(2, :);
                  hex_pts(3, :);
                  ones(1, cols)];
rotated_pts = rot_matrix * hex_pts_4D;

homog_coords = r3_to_hom(rotated_pts, d2);
proj_matrix = perspect_proj_mat(d2);
hex_proj = proj_matrix * homog_coords;

%normalization
hex_proj(1,:) = hex_proj(1,:) ./ hex_proj(4,:);
hex_proj(2,:) = hex_proj(2,:) ./ hex_proj(4,:);
hex_proj(3,:) = hex_proj(3,:) ./ hex_proj(4,:);

reverse_rot = plane_rotation_mat(3, -acos(d2/sqrt(d1^2 + d2^2)));
hex_proj = reverse_rot * hex_proj;

figure(3)
plot3(hex_proj(1,:), hex_proj(2,:), hex_proj(3,:));
hold on
plot3(hex_pts(1,:), hex_pts(2,:), hex_pts(3,:));

% draw some perspective lines
for i = 1:cols
    x1 = 0; y1 = d1; z1 = d2; % perpective point
    x2 = hex_pts(1,i); y2 = hex_pts(2,i); z2 = hex_pts(3,i);
    x3 = hex_proj(1,i); y3 = hex_proj(2,i); z3 = hex_proj(3,i);
    xs = [x1,x2,x3];
    ys = [y1,y2,y3];
    zs = [z1,z2,z3];
    plot3(xs,ys,zs,'k--');
end
hold off