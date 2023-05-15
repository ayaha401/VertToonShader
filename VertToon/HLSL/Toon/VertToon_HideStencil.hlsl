#ifndef VT_HIDESTENCIL
#define VT_HIDESTENCIL

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

struct Attributes
{
    float4 positionOS : POSITION;
    float2 uv : TEXCOORD0;
    float3 color : COLOR;
    float3 normalOS : NORMAL;

    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    float2 uv : TEXCOORD0;
    float4 positionHCS : SV_POSITION;
    float4 vertColor : COLOR;
    float3 normalWS : NORML;
    float4 lightDirWS : TEXCOORD1; // w : 未使用

    UNITY_VERTEX_INPUT_INSTANCE_ID
};

// Main
uniform sampler2D _MainTex;

// CBUFFER
#include "../VertToon/HLSL/Toon/VertToon_Input.hlsl"

Varyings vert(Attributes v)
{
    Varyings o = (Varyings)0;

    UNITY_SETUP_INSTANCE_ID(v);
    UNITY_TRANSFER_INSTANCE_ID(v, o);

    VertexPositionInputs vertexInput = GetVertexPositionInputs(v.positionOS.xyz);
    o.positionHCS = vertexInput.positionCS;

    // uv
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);

    // normal
    o.normalWS = TransformObjectToWorldNormal(v.normalOS);

    // DL
    Light light = GetMainLight();
    float3 dlColor = light.color;
    o.lightDirWS.xyz = light.direction.xyz;
    
    // vertColor
    o.vertColor = (float4)1.;
    o.vertColor.rgb *= dlColor;
    if(_UseVertColor)
    {
        o.vertColor.rgb *= v.color.rgb;
    }

    // Color
    o.vertColor *= _Color;

    return o;
}

float4 frag(Varyings i) : SV_Target
{
    UNITY_SETUP_INSTANCE_ID(i);

    float3 hideColor = (float3)1;
    if(_UseHideColor)
    {
        hideColor = _HideColor;
    }
    else
    {
        // Normal
        float3 normalWS = i.normalWS;

        // Light
        float3 lightDirWS = i.lightDirWS.xyz;

        // Albedo
        float3 mainTexColor = tex2D(_MainTex, i.uv).rgb;
        hideColor.rgb = mainTexColor;
        hideColor *= i.vertColor;

        // Diff
        float NdotL = dot(normalWS, lightDirWS);
        float halfLambert = NdotL * 0.5 + 0.5;
        float diff = halfLambert;
        hideColor.rgb *= diff;
    }
    
    return float4(hideColor, 1);
}
#endif