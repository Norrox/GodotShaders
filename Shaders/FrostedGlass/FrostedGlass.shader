shader_type spatial;
render_mode blend_mix,depth_draw_always,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform sampler2D texture_refraction;
uniform float refraction : hint_range(-16,16);
uniform vec4 refraction_texture_channel;
uniform sampler2D texture_normal : hint_normal;
uniform float normal_scale : hint_range(-16,16);
uniform sampler2D texture_ambient_occlusion : hint_white;
uniform vec4 ao_texture_channel;
uniform float ao_light_affect;
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;
 
void vertex() {
 UV=UV*uv1_scale.xy+uv1_offset.xy;
}

void fragment() {
 vec2 base_uv = UV;
 vec4 albedo_tex = texture(texture_albedo,base_uv);
 ALBEDO = albedo.rgb * albedo_tex.rgb;
 METALLIC = metallic;
 ROUGHNESS = roughness;
 SPECULAR = specular;
 NORMALMAP = texture(texture_normal,base_uv).rgb;
 NORMALMAP_DEPTH = normal_scale;
 vec3 ref_normal = normalize( mix(NORMAL,TANGENT * NORMALMAP.x + BINORMAL * NORMALMAP.y + NORMAL * NORMALMAP.z,NORMALMAP_DEPTH) );
 vec2 ref_ofs = SCREEN_UV - ref_normal.xy * dot(texture(texture_refraction,base_uv),refraction_texture_channel) * refraction;
 float ref_amount = 1.0 - albedo.a * albedo_tex.a;
 EMISSION += textureLod(SCREEN_TEXTURE,ref_ofs,ROUGHNESS * 8.0).rgb * ref_amount;
 ALBEDO *= 1.0 - ref_amount;
 ALPHA = 1.0;
 AO = dot(texture(texture_ambient_occlusion,base_uv),ao_texture_channel);
 AO_LIGHT_AFFECT = ao_light_affect;
}