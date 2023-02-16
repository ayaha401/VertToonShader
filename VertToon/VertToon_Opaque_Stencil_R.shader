Shader "VertToon/Opaque_Stencil_R"
{
    Properties
    {
        // Main
        _MainTex("Main Texture", 2D) = "white"{}
        _Color("Color", Color) = (1, 1, 1, 1)
        _HideColor("Hide Color", Color) = (0.8, 0.8, 0.8, 1)
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

        // StencilWritePass
        Pass
        {
            Name "StencilWrite"
            Tags
            {
                "LightMode" = "SRPDefaultUnlit"
            }
            Stencil
            {
                Ref 1
                Comp Equal
                Pass IncrSat
            }
            ColorMask 0
            ZTest Always
            ZWrite Off

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma target 4.5
            #pragma enable_d3d11_debug_symbols
            
            #include "../VertToon/HLSL/Toon/VertToon_StencilWrite.hlsl"
            ENDHLSL
        }

        // ForwardPass
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
            Cull Off
            ZWrite ON
            Stencil
            {
                Ref 3
                Comp Always
                Pass Replace
            }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma target 4.5
            #pragma enable_d3d11_debug_symbols

            #include "../VertToon/HLSL/Toon/VertToon_Core.hlsl"
            ENDHLSL
        }

        // StencilReadPass
        Pass
        {
            Name "StencilRead"
            Tags
            {
                "LightMode" = "UniversalForwardOnly"
            }
            Stencil
            {
                Ref 2
                Comp Equal
            }
            ZTest Always

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma target 4.5
            #pragma enable_d3d11_debug_symbols

            #include "../VertToon/HLSL/Toon/VertToon_HideStencil.hlsl"
            ENDHLSL
        }

        // ShadowPass
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            Cull Back
            ZWrite On
            ZTest LEqual

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma target 4.5
            #pragma enable_d3d11_debug_symbols

            #include "../VertToon/HLSL/Toon/VertToon_ShadowCaster.hlsl"
            ENDHLSL
        }

        // DepthPass
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            Cull Off
            ZWrite On
            ZTest LEqual
            ColorMask 0

            HLSLPROGRAM
            #pragma target 4.5

            #pragma vertex depthOnlyVertex
            #pragma fragment depthOnlyFragment

            #pragma multi_compile_instancing

            #include "../VertToon/HLSL/Toon/VertToon_DepthOnly.hlsl"
            ENDHLSL
        }
    }
}
