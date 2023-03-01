using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

namespace AyahaShader.VertToon
{
    public class VertToonGUI : ShaderGUI
    {
        private MaterialProperty mainTex;
        private MaterialProperty color;
        private MaterialProperty hideColor;
        private MaterialProperty useVertColor;

        // OtherSetting
        private MaterialProperty cullingMode;

        private bool otherSettingFoldoutOpen = false;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] prop)
        {
            var material = (Material)materialEditor.target;
            FindProperties(prop);

            // äÓñ{èÓïÒÇï`âÊ
            VertToonCustomUI.Information();

            // èâä˙èÛë‘ÇÃGUIÇï\é¶Ç≥ÇπÇÈ
            //base.OnGUI(materialEditor, prop);

            // Color
            VertToonCustomUI.Title("Color");
            EditorGUI.indentLevel++;
            using (new EditorGUILayout.VerticalScope(GUI.skin.box))
            {
                materialEditor.TexturePropertySingleLine(new GUIContent("Main Texture"), mainTex);
                materialEditor.ShaderProperty(color, new GUIContent("Color"));
                materialEditor.ShaderProperty(useVertColor, new GUIContent("Use Vertex Color"));

                if(hideColor != null)
                {
                    materialEditor.ShaderProperty(hideColor, new GUIContent("Hide Color"));
                }
            }
            EditorGUI.indentLevel--;

            // OtherSetting
            otherSettingFoldoutOpen = VertToonCustomUI.Foldout("OtherSetting", otherSettingFoldoutOpen);
            if(otherSettingFoldoutOpen)
            {
                EditorGUI.indentLevel++;
                using (new EditorGUILayout.VerticalScope(GUI.skin.box))
                {
                    materialEditor.ShaderProperty(cullingMode, new GUIContent("Culling Mode"));
                    materialEditor.RenderQueueField();
                }
                EditorGUI.indentLevel--;
            }
        }

        private void FindProperties(MaterialProperty[] prop)
        {
            mainTex = FindProperty("_MainTex", prop, false);
            color = FindProperty("_Color", prop, false);
            hideColor = FindProperty("_HideColor", prop, false);
            useVertColor = FindProperty("_UseVertColor", prop, false);

            // OtherSetting
            cullingMode = FindProperty("_CullingMode", prop, false);
        }
    }
}
