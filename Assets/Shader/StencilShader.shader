Shader "Unlit/StencilShader"
{
    Properties
    {
        //参考值
        [IntRange]_index("stencil index",Range(0,255)) = 0
    }
    SubShader
    {
        Tags
        {
            //不透明材质
            "RenderType" = "Opaque"
            //渲染队列：几何物体
            "Queue" = "Geometry"
            //渲染管线：URP
            "RenderPipeLine" = "UniversalPipeline"
        }


        Pass
        {
            //混合模式：来源和目标的透明度Alpha直接混合
            Blend Zero One
            //关闭深度写入
            ZWrite Off

            //开启模板测试
            Stencil
            {
                //参考值 index
                Ref [_index]
                //参考值和当前值比较，永远通过
                Comp Always
                //通过后，用参考值替换模板值
                Pass Replace
                //失败后，当前值不变
                Fail Keep
            }
            
        }
    }
}
