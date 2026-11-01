# Tutorial Exercise 7: Transformations & Shading in Godot

---

## 1. Introduction & Objectives
In this lab exercise, you will explore model transformations, coordinate spaces, and lighting inside the Godot Engine using a 3D bunny model. 

By completing this tutorial, you will:
* Observe how camera projections alter spatial perception.
* Implement vertex transformations and animation inside a custom spatial shader using local coordinate spaces.
* Complete the Phong lighting model by implementing the specular highlight component with built-in GLSL functions.

---

## 2. Camera Projections & Scene Exploration
You are provided with a 3D scene containing a bunny model and a camera equipped with a script that allows you to toggle between projection modes (perspective or orthographic) in run mode.

### Tasks:
1. Run the project and press the **'C' key** to toggle between orthographic and perspective projection. At this point, the model will be static. 
2. Compare your runtime observations with the behaviour you see in **Editor Mode**. Keep these visual differences in mind as you work on the shader tasks below.

---

## 3. Vertex Transformations & Coordinate Spaces
You will modify the shader file (`rotation_and_lighting.gdshader`) to animate the rotation of the 3D bunny model around the Y-axis.

### Tasks:
* Inside the `vertex()` function, call the provided `buildRMatrixY(current_angle)` function to generate your rotation matrix.
* Apply the rotation matrix to transform both the `VERTEX` and `NORMAL` built-in variables. Consider how linear transformations affect position vectors versus normal vectors. 
* Both `VERTEX` and `NORMAL` are of type `vec3`. Refer to the official [Godot Spatial Shaders Documentation](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html)for details on on spatial shader built-ins and coordinate spaces.

---

## 4. Implementing Phong Specular Lighting
Next, you will complete the illumination model by implementing the specular highlight component of the Phong reflection model inside the `light()` processor function.

### Tasks:
* Look up the built-in GLSL [reflect function](https://registry.khronos.org/OpenGL-Refpages/gl4/html/reflect.xhtml) which calculates the reflection direction given an incident vector (pointing towards the surface) and a normal vector. The resulting reflection vector points away from the surface.
* You can use the built-in [`LIGHT` variable](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html#light-built-ins) to determine the light direction in view space.
* Combine `reflect()`, the view direction (`VIEW`), surface `shininess`, and the specular coefficient (`k_s`) to calculate and assign the `SPECULAR_LIGHT` built-in. 
* Once implemented, experiment with the `shininess` and `k_s` sliders in the Inspector panel to observe how highlight intensity and sharpness respond.

---

## 5. Visual Verification
Once your vertex rotation and specular shading are fully functional:
* Observe the head of the bunny mesh as it rotates around the Y-axis under both projection modes. 
* **Self-Check:** Notice how the perceived size and proportions of the bunny's head fluctuate under perspective projection, while remaining constant under orthographic projection. Be prepared to explain why this occurs!

---

## Submission
Submit your completed exercise via Gradescope under the assignment titled Tutorial Exercise 7 before the end of your scheduled tutorial session.

Upload only the modified shader file `rotation_and_lighting.gdshader`.