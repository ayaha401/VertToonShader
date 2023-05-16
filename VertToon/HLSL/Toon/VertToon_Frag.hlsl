#ifndef VT_FRAG
#define VT_FRAG

float4 frag(Varyings i) : SV_Target
{
    UNITY_SETUP_INSTANCE_ID(i);

    // Normal
    float3 normalWS = i.normalWS;

    // Albedo
    float4 col = (float4)1.;
    float3 mainTexColor = tex2D(_MainTex, i.uv).rgb;
    col.rgb = mainTexColor;
    col *= i.vertColor;

    // Light
    float4 shadowCoord = TransformWorldToShadowCoord(i.positionWS);
    Light mainLight = GetMainLight(shadowCoord);
    float3 attenuatedLightColor = mainLight.color * (mainLight.distanceAttenuation * mainLight.shadowAttenuation);
    
    // Diffuse
    float3 diffuseColor = LightingLambert(attenuatedLightColor, mainLight.direction, normalWS);            
    diffuseColor = diffuseColor * 0.5 + 0.5;
    col.rgb *= diffuseColor;

    // LastColor
    float4 lastCol = float4(0.0, 0.0, 0.0, 1.0);
    lastCol = col;
    return lastCol;
}

#endif