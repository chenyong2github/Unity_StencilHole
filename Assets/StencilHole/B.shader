Shader "B" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,0)
	}
		SubShader{
			Tags { "RenderType" = "Opaque" "Queue" = "Geometry+3"}

			ZTest Less
			Offset -1, -1
			ZWrite Off
			Cull Front

			Stencil
			{
				Ref 3
				Comp Equal
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
				o.Normal = half3(0, 0, -1);
				o.Alpha = 1;
			}
			ENDCG
	}
}