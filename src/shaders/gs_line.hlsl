struct vOut
{
    float4 position : SV_POSITION;
    float4 color : COLOR;
};

cbuffer viewMatrixBuffer
{
    matrix viewMatrix;
    float3 sun_direction;
};

#ifdef VS

struct vInput
{
	float4 position : POSITION;
	float4 color : COLOR;
	float thickness : THICKNESS;
};

vInput VSMain(const vInput input)
{
	float4 pos = input.position;
    vInput output;
    output.position = mul(pos, transpose(viewMatrix));
    output.color = input.color;
    output.thickness = input.thickness;

    return output;
}

#endif

#ifdef GS

struct vInput
{
	float4 position : POSITION;
	float4 color : COLOR;
	float thickness : THICKNESS;
};

[maxvertexcount(6)]
void GSMain(line vInput input[2], inout TriangleStream<vOut> output)
{
	float3 startPos = input[0].position.xyz;
	float3 endPos = input[1].position.xyz;

	float3 tangent = normalize(endPos - startPos);
	float3 normal = normalize(cross(startPos, tangent));

	vOut v[6];
	v[0].position.xyz = startPos + normal * input[0].thickness;
	v[1].position.xyz = endPos + normal * input[1].thickness;
	v[2].position.xyz = startPos - normal * input[0].thickness;
	v[3].position.xyz = startPos - normal * input[0].thickness;
	v[4].position.xyz = endPos + normal * input[1].thickness;
	v[5].position.xyz = endPos - normal * input[1].thickness;

	v[0].position.w = input[0].position.w;
	v[1].position.w = input[1].position.w;
	v[2].position.w = input[0].position.w;
	v[3].position.w = input[0].position.w;
	v[4].position.w = input[1].position.w;
	v[5].position.w = input[1].position.w;

	v[0].color = input[0].color;
	v[1].color = input[1].color;
	v[2].color = input[0].color;
	v[3].color = input[0].color;
	v[4].color = input[1].color;
	v[5].color = input[1].color;

	output.Append(v[0]);
	output.Append(v[1]);
	output.Append(v[2]);
	output.RestartStrip();
	output.Append(v[3]);
	output.Append(v[4]);
	output.Append(v[5]);
	output.RestartStrip();
}

#endif

#ifdef DEFAULT_GS

[maxvertexcount(3)]
void GSMain(triangle vOut input[3], inout TriangleStream<vOut> output)
{
	vOut v[3];
	v[0].position = input[0].position;
	v[1].position = input[1].position;
	v[2].position = input[2].position;
	v[0].color = input[0].color;
	v[1].color = input[1].color;
	v[2].color = input[2].color;

	output.Append(v[0]);
	output.Append(v[1]);
	output.Append(v[2]);
}

#endif

#ifdef PS

float4 PSMain(const vOut input) : SV_TARGET
{
    return input.color;
}

#endif