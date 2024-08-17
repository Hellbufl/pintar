@echo off

echo:
echo === Fullscreen Quad ===
.\fxc.exe "fullscreen_quad.hlsl" /nologo /T vs_4_0 /D VS /E VSMain /Fo "fullscreen_quad_vs.cso"
.\fxc.exe "fullscreen_quad.hlsl" /nologo /T ps_4_0 /D PS /E PSMain /Fo "fullscreen_quad_ps.cso"

echo:
echo === Default ===
.\fxc.exe "default.hlsl" /nologo /T vs_4_0 /D VS /E VSMain /Fo "default_vs.cso"
.\fxc.exe "default.hlsl" /nologo /T ps_4_0 /D PS /E PSMain /Fo "default_ps.cso"

echo:
echo === Line ===
.\fxc.exe "line.hlsl" /nologo /T vs_4_0 /D VS /E VSMain /Fo "line_vs.cso"
.\fxc.exe "line.hlsl" /nologo /T ps_4_0 /D PS /E PSMain /Fo "line_ps.cso"^

echo:
echo === GSLine ===
.\fxc.exe "gs_line.hlsl" /nologo /T vs_4_0 /D VS /E VSMain /Fo "gs_line_vs.cso"
.\fxc.exe "gs_line.hlsl" /nologo /T ps_4_0 /D PS /E PSMain /Fo "gs_line_ps.cso"
.\fxc.exe "gs_line.hlsl" /nologo /T gs_4_0 /D GS /E GSMain /Fo "gs_line_gs.cso"

.\fxc.exe "gs_line.hlsl" /nologo /T gs_4_0 /D DEFAULT_GS /E GSMain /Fo "default_gs.cso"