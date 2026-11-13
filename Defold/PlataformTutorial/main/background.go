components {
  id: "paralax"
  component: "/main/paralax.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"blue_grass\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 1024.0\n"
  "  y: 1024.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/hero.atlas\"\n"
  "}\n"
  ""
  position {
    x: -1024.0
  }
}
embedded_components {
  id: "sprite1"
  type: "sprite"
  data: "default_animation: \"blue_grass\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 1024.0\n"
  "  y: 1024.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/hero.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "sprite2"
  type: "sprite"
  data: "default_animation: \"blue_grass\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 1024.0\n"
  "  y: 1024.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/hero.atlas\"\n"
  "}\n"
  ""
  position {
    x: 1024.0
  }
}
