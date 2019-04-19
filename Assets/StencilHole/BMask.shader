Shader "BMask" {
	SubShader{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry+2"}


		CGINCLUDE
			struct appdata {
				float4 vertex : POSITION;
			};
			struct v2f {
				float4 pos : SV_POSITION;
			};
			v2f vert(appdata v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}
			half4 fragRed(v2f i) : SV_Target {
				return half4(1, 0, 0, 1);
			}

			half4 fragGreen(v2f i) : SV_Target{
				return half4(0, 1, 0, 1);
			}
		ENDCG

		Pass {

			ColorMask 0
			ZTest Less
			ZWrite Off
			Cull Back

			Stencil{
				Ref 1
				Comp Equal
				Pass IncrSat
				Fail Keep
				ZFail Keep
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragRed
			ENDCG
		}

		Pass {

			ColorMask 0
			ZTest Greater
			ZWrite On
			Cull Front

			Stencil{
				Ref 2
				Comp Equal
				Pass IncrSat
				Fail Keep
				ZFail Keep
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragGreen
			ENDCG
		}		
	}
}
