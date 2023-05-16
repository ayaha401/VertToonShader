#ifndef VT_INPUT
#define VT_INPUT

CBUFFER_START(UnityPerMaterial)
    uniform float4 _MainTex_ST;
    uniform float4 _Color;
    uniform int _UseVertColor;
    uniform int _UseHideColor;
    uniform float3 _HideColor;
CBUFFER_END

#endif