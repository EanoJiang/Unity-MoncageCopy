Shader "Unlit/StencilShader"
{
    Properties
    {
        //�ο�ֵ
        [IntRange]_index("stencil index",Range(0,255)) = 0
    }
    SubShader
    {
        Tags
        {
            //��͸������
            "RenderType" = "Opaque"
            //��Ⱦ���У���������
            "Queue" = "Geometry"
            //��Ⱦ���ߣ�URP
            "RenderPipeLine" = "UniversalPipeline"
        }


        Pass
        {
            //���ģʽ����Դ��Ŀ���͸����Alphaֱ�ӻ��
            Blend Zero One
            //�ر����д��
            ZWrite Off

            //����ģ�����
            Stencil
            {
                //�ο�ֵ index
                Ref [_index]
                //�ο�ֵ�͵�ǰֵ�Ƚϣ���Զͨ��
                Comp Always
                //ͨ�����òο�ֵ�滻ģ��ֵ
                Pass Replace
                //ʧ�ܺ󣬵�ǰֵ����
                Fail Keep
            }
            
        }
    }
}
