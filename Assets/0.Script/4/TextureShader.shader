Shader "Custom/TextureShader"
{
    Properties
    {
        _MainTex ("Texture",2D) = "white" {}
        _Color ("Tint Color",Color) = (1,1,1,1)
    }

    SubShader
    {
        Tags{"RenderType"="Opanque"}
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
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            fixed4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_TARGET
            {
                fixed4 texColor = tex2D(_MainTex,i.uv);

                fixed4 finalColor = texColor * _Color;

                return finalColor;
            }
            ENDCG
        }
    }
}
