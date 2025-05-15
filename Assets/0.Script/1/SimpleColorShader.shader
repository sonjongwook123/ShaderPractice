Shader "Custom/SimpleColorShader"
{
    Properties // 인스펙터 노출 속성
    {
        _Color ("Color", Color) = (1,1,1,1) // 에디터에 표시될 이름, 속성타입 = 속성 값 (R,G,B,A)
    }

    SubShader // 쉐이더 코드 , 하나의 쉐이더 파이른 여러개의 SubShader를 가질 수 있다.
    {
        Tags { "RenderType"="Opanque"} // 렌더링 방식을 정의, Opanque는 불투명
        LOD 100 // LOD 가장 높은 디테일인 100으로 설정.

        Pass // 실제 렌더링 단위를 정의, 한 SubShader에 여러개의 pass를 가질 수 있다.
        {
            CGPROGRAM // CGPROGRAM ~ ENDCG 블록 안에서 쉐이더 코드가 작성 됨. Cg/HLSL 언어가 사용된다.
            #pragma vertex vert // vert 라는 이름의 Cg/HLSL 함수를 쉐이더로 컴파일. vertex 쉐이더는 메쉬의 각 정점에 대해 실행되는 함수
            #pragma fragment frag // fragment는 화면의 각 픽셀에 대해 실행되는 함수. 픽셀의 최종색상을 결정.

            #include "UnityCG.cginc" // 유니티에서 자주 사용되는 매크로,구조체,함수를 로드 예)UnityObjectToClipPos (오브젝트 공간좌표 => 클립공간으로 변환환)

            struct appdata // 버텍스 쉐이더의 입력 데이터 정의 (CPU -> 쉐이더)
            {
                float4 vertex : POSITION; // float4 타입 변수 정의, POSITION 할당(공간좌표)
            };

            struct v2f // 버텍스 쉐이더 -> 프래그먼트 쉐이더로 전달할 데이터 구조체
            {
                float4 vertex : SV_POSITION; // 클립 공간에서의 정점 좌표를 의미. 최종적으로 화면의 픽셀 위치를 결정.
            };

            fixed4 _Color; 

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_TARGET // 렌더링 타켓켓
            {
                return _Color;
            }
            ENDCG
        }
    }
}
