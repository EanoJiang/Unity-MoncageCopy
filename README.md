# 模板测试

Buffer(缓存)

![1748934986235](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175506175-1390682726.png)

当看到当前帧的时候，下一帧的画面会渲染到buffer中

![1748934893456](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175506595-736224833.png)

![1748934873032](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175506866-233478254.png)

## Stencil Buffer模板缓存

![1748935032057](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175507172-1086899163.png)

> 为什么不用ShaderGraph？

因为这里需要改渲染管线，只能用Shader

## 需要的模型：

![1748938983752](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175507446-2138026603.png)

加上两片Quad

![1748939144352](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175507707-2128968331.png)

## Shader

1. 新建一个Unlit Shader

代码如下：

```glsl
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

```



1. 新建2个材质Material：st1、st2，勾选Unlit Shader

![1748939105254](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175507968-968889545.png)

![1748939111998](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175508233-164338333.png)

然后分别添加到Quad1和2

3. 为两个物体分别建Layer

![1748941853886](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175508447-1161265683.png)

![1748941870829](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175508638-1690150343.png)

4. URP里的Filtering，反勾选这两个Layer

![1748941919158](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175508838-1483575307.png)

新建Render Objects

![1748942205788](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175509090-1180740982.png)

效果如下：

![演示](https://img2023.cnblogs.com/blog/3614909/202506/3614909-20250603175509819-1845953759.gif)
