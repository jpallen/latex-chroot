%%BeginProcSet: duplex2v.pro
%
% h duplex2v.pro
%
statusdict /setduplexmode known {
statusdict begin true setduplexmode end
} if
%
[{
%%BeginFeature: *EFDuplex Top
true XJXsetduplex
  << /Tumple true >> setpagedevice
%%EndFeature
} stopped cleartomark
%%EndProcSet
