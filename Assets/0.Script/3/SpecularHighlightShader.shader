Shader "Custom/SpecularHighlightShader"
{
    Properties
    {
        _Color("Color",Color) = (0.5,0.5,0.5,1)
        _SpecularColor("Specular Color",Color) = (0.9,0.9,0.9,1)
        _Glossiness("Glossiness",Range(2,256)) = 20
    }

    SubShader
    {
        Tags{"RenderType"="Opaque"}
        LOD 100

        pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
            };

            fixed4 _Color;
            fixed4 _SpecularColor;
            float _Glossiness;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldPos = UnityObjectToWorldNormal(v.normal);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_TARGET
            {
                float3 normalDir = normalize(i.worldNormal);
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz); // 유니티 내장 광원 방향
                float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos); // 카메라에서 쉐이더 픽셀로 향하는 방향
                float3 halfDir = normalize(lightDir + viewDir); // 시선방향과 광원 방향의 중간 벡터
                
                // 램버트 비퓨즈 
                float diffuse = max(0.0, dot(normalDir,lightDir));
                fixed4 diffuseColor = _Color * diffuse;

                // 스페큘러 블린-퐁
                float specular = pow(max(0.0, dot(normalDir,halfDir)), _Glossiness);
                fixed4 specularColor = _SpecularColor * specular;

                return diffuseColor + specularColor;
            }
            ENDCG
        }
    }
}
