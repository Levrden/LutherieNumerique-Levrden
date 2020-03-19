using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class eventTrigger : MonoBehaviour
{
    public Camera vCam;
    private Texture2D Text2d;
    private RenderTexture rText;
    private Rect rect;
    private float col;
    //private float indexD = 0;

    public float Col{
        get
        {
            return col;
        }
        set
        {
            col = value;
        }
    }

    /*public float IndexD{
        get
        {
            return indexD;
        }
        set
        {
            indexD = value;
        }
    }*/

    void Update()
    {
        GetTexture();

        col = Mathf.Round(Text2d.GetPixel(8,8).grayscale*100);
        //TestColor(col);
        //indexD = 0;
    }

    /*void TestColor(float col){
        Debug.Log("col : " + col);
        if(col == 8){
            Debug.Log("UN");
        } else if (col == 22){
            Debug.Log("DEUX");
        } else if (col == 34){
            Debug.Log("TROIS");
        } else if (col == 45){
            Debug.Log("QUATRE");
        } else if (col == 53){
            Debug.Log("CINQ");
        } else if (col == 58){
            Debug.Log("SIX");
        } else if (col == 64){
            Debug.Log("SEPT");
        } else if (col == 67){
            Debug.Log("HUIT");
        } else if (col == 70){
            Debug.Log("NEUF");
        } else if (col == 73){
            Debug.Log("DIX");
        } else if (col == 75){
            Debug.Log("ONZE");
        } else if (col == 77){
            Debug.Log("DOUZE");
        } else if (col < 19){
        //indexD = 1;
        }
    }*/
    
    void GetTexture(){
        Text2d = new Texture2D(16,16,TextureFormat.RGB24, false);
        RenderTexture.active = rText;
        rText = vCam.targetTexture;
        rect = new Rect(0,0,16,16);
        Text2d.ReadPixels(rect, 0, 0);
        Text2d.Apply();
    }
}


