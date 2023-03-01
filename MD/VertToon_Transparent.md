# VertToon_Transparent

透明シェーダー

## 種類
|名前|説明|
|---|---|
|VertToon_Transparent_Stencil_R|ステンシルを書き込む用|

# 共通プロパティ
## Main
|プロパティ|透過|説明|
|---|---|---|
|MainTex|×|メインテクスチャ|
|Color|○|メインテクスチャに乗算合成する色|
|UseVertColor|×|頂点カラーを使用するか？|

## OtherSetting
|プロパティ|説明|
|---|---|
|CullingMode|カリングをするかどうか|
|&emsp;Off|カリングしない|
|&emsp;Front|表面をカリング|
|&emsp;Back|裏面をカリング|

# Stencil_Rの固有プロパティ
## Main
|プロパティ|透過|説明|
|---|---|---|
|_HideColor|×|他のオブジェクトに隠れた時の色|