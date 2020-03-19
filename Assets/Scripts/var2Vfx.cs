using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.VFX;

[ExecuteInEditMode]
public class var2Vfx : MonoBehaviour
{
    public VisualEffect VFX;
    public string variable1;
    public string variable2;
    public string variable3;
    public string variable4;
    public string variable5;

    public void UpdateFloatVar1(float value)
{
     VFX.SetFloat(variable1, value);
     //Debug.Log("var1");
}
    public void UpdateFloatVar2(float value)
{
     VFX.SetFloat(variable2, value);
     //Debug.Log("var2");
}
    public void UpdateFloatVar3(float value)
{
     VFX.SetFloat(variable3, value);
     //Debug.Log("var3");
}
    public void UpdateFloatVar4(float value)
{
     VFX.SetFloat(variable4, value);
     //Debug.Log("var4");
}
    public void UpdateFloatVar5(float value)
{
     VFX.SetFloat(variable5, value);
     //Debug.Log("var5");
}
    
}
