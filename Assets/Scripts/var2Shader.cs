using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class var2Shader : MonoBehaviour
{
    public Material mat;
    public string variable1;
    public string variable2;
    public string variable3;
    public string variable4;

void Start(){
    mat = GetComponent<Renderer>().material;
}

    public void UpdateFloatVar1(float value)
{
     mat.SetFloat(variable1, value);
     //Debug.Log("var1");
}
    public void UpdateFloatVar2(float value)
{
     mat.SetFloat(variable2, value);
     //Debug.Log("var2");
}
    public void UpdateFloatVar3(float value)
{
     mat.SetFloat(variable3, value);
     //Debug.Log("var3");
}
    public void UpdateFloatVar4(float value)
{
     mat.SetFloat(variable4, value);
     //Debug.Log("var3");
}

}
