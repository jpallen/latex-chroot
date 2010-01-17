% Animation of polyhedra
% Example of use of 3d and poly packages
% METAPOST
% Denis Roegel, 17 August 2003

% package 3d
input 3d

% polyhedra definitions
input 3dpoly

% animations
input 3danim

% set scale
drawing_scale:=8cm;

%
filled_faces:=true; % default value
%filled_faces:=false;

%
%show_animation_parameters:=true; % default value is |false|

% animations
%animate_object("tetrahedron",1,100,100);
%animate_object("cube",1,100,100);
%animate_object("octahedron",1,100,100);
%animate_object("dodecahedron",1,100,100);
%animate_object("icosahedron",1,100,100);
%animate_two_objects("dodecahedron","icosahedron",1,100,100);
animate_three_objects("dodecahedron","icosahedron","octahedron",1,100,100);
%animate_two_identical_objects("dodecahedron",1,100,100);

end
