Shader "Unlit/VertToon_opaque"
{
    Properties
    {
        // Main
        [Toggle] _UseVertColor ("Use vertex Color", int) = 1
    }

    SubShader
    {
        Tags 
        {
            "RenderPipeline" = "UniversalPipeline"
            "RenderType" = "Opaque"
            "IgnoreProjector" = "True"
            "Queue" = "Geometry"
        }
        LOD 100

        Pass
        {
            Name "Opaque"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma enable_d3d11_debug_symbols

            #include "../VertToon/HLSL/VertToon_Core.hlsl"
            ENDHLSL
        }
    }
}
