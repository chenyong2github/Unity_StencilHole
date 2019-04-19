Shader "ADepth" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,0)
	}
		SubShader{
			Tags { "RenderType" = "Opaque" "Queue" = "Geometry+1"}

			ColorMask 0
			ZTest Less
			ZWrite On
			Cull Back

			Stencil{
				Ref 1
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}

			CGPROGRAM
			#pragma surface surf Lambert
			float4 _Color;
			struct Input {
				float4 color : COLOR;
			};
			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = _Color.rgb;
				o.Alpha = 1;
			}
			ENDCG
	}
}