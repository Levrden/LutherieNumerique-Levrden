# LutherieNumerique-Levrden

https://forum.unity.com/threads/vfx-graph-accessing-particles-data-in-scripts.651709/#post-5577580

Hello sorry, i missed the answers ! For now i don't have a lot of time to comment my unity project, but i can send it !
It is a project for making haptic gloves with arduino, so i use OSC jack from Keijiro ro get and send my datas.
It is a hdrp 2019.3.3 project.

The settings are :

- There are hands controlled my leapmotion that have empty objects at the end of each finger, and on the palm. So 12 objects tracked.
- In the hierarchy, you have the SimplePartsEmission, the VFX graph.
-there a a lot of property hided, for all the 12 objects.
- the script var2vfx aims to sync my incoming osc properties to the vfx properties. You can use it or not. I used to use it before the propertybinder component.
- the propertybinder script is there to syncronize the 12 objects, the output position of the particles that depends on properties, and the position of the second camera.

In the hierarchy, the partpos object is the output position of the articules, and inside the second camera. The camera outputs a rendertexture.

Then, you have the OSC EventTrigger, that has a script for getting the color of the particle, and output it has a property, or a value, or whatever you need. In my script, it is in a value "col" that take the grayscale value of a pixel on the texture.

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

THE GRAPH


To make it less messy, i have made subgraph operators and blocks.

The principle is  : When a particle is very close to one of my fingers, it changes of color and die.
the color changes depending on the scale of the empty object the particle approches. In that way, i can know which finger has been touched.

At the end of the update, and event trigger on death another graph that outputs a single particle in front of the second camera which inherit the color of the dead particle.



I hope it is clear enough. If you have any suggestions of questions, i am of course open to it !
