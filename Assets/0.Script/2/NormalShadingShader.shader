Shader "Custom/NormalShadingShader"
{
    SubShader
    {
        Tags{"RenderType"="Opaque"}
        LOD 100

        Pass
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
                float3 worldNormal : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET
            {
                // 램버트 조명 계산
                float3 lightDir = normalize(float3(1,1,1)); // 빛의 방향
                float dotProduct = dot(normalize(i.worldNormal), lightDir); 
                fixed4 color = fixed4(dotProduct, dotProduct, dotProduct, 1.0); // 빛의 내적값 색상으로 사용
                return color;
            }
            ENDCG
        }
    }
}
