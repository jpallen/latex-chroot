% MetaUML, a MetaPost library for typesetting exquisite UML diagrams.
% Copyright (C) 2005 Ovidiu Gheorghies
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

if known _metauml_mp:
  expandafter endinput
fi;
_metauml_mp:=1;

input boxes;

input util_infrastructure;
input util_object;
input util_commons;
input util_margins;
input util_picture;
input util_group;
input util_picture_stack;
input util_positioning;
input util_shade;

input metauml_base;

input metauml_links;
input metauml_paths;

input metauml_note;

input metauml_stereotype;

input metauml_class_clipart;
input metauml_class;
input metauml_instance;
input metauml_class_relations;
input metauml_class_assoc;

input metauml_package;
input metauml_package_relations;

input metauml_behavioral_common;
input metauml_activity;
input metauml_state;

input metauml_usecase_clipart;
input metauml_usecase;

input metauml_templates;
