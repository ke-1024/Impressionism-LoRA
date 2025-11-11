#Impressionism-LoRA 模型
#Impressionism-LoRA：印象派风格迁移轻量化模型
本模型基于Stable Diffusion 1.5架构开发，专注于印象派艺术风格的精准还原与高效生成。通过定向训练，模型能够复现印象派标志性的光影捕捉、松散笔触肌理与明快色彩叠加特征，适配莫奈、雷诺阿等经典印象派大师风格，可广泛应用于艺术创作、设计原型开发、视觉内容风格化等场景。

#模型特性

- 风格还原度高：聚焦印象派核心艺术特征，生成结果兼具风格辨识度与视觉完整性；
- 轻量化部署：模型体积仅50MB左右，兼容主流硬件环境，支持4GB及以上显存设备本地运行；
- 兼容性强：可与SD1.5系列衍生基础模型协同使用，支持通过权重调整平衡风格强度与细节表现；
- 扩展能力丰富：支持结合ControlNet实现结构约束，或适配Stable Video Diffusion扩展至动态视频生成。

#快速部署与使用
环境依赖
- 基础模型：Stable Diffusion 1.5（推荐v1-5-pruned-emaonly.safetensors版本）；
- 部署工具：Stable Diffusion WebUI（推荐）或Diffusers 0.20.0及以上版本；
- 硬件要求：本地部署需至少4GB显存，云端部署支持GPU加速环境。

模型获取
通过Git克隆仓库获取完整模型及配套资源：
git clone https://github.com/ke-1024/Impressionism-LoRA.git
cd Impressionism-LoRA
核心模型文件路径：models/Impressionism-LoRA-v1.0.safetensors

WebUI部署（适用于快速验证）
1. 模型安装：
  - 将Stable Diffusion 1.5基础模型放入WebUI的models/Stable-diffusion/目录；
  - 将本项目LoRA模型文件放入models/Lora/目录，重启WebUI即可加载。
2. 生成参数示例：
  - 提示词（Prompt）：water lilies in a pond, morning light, soft reflection, impressionist style <lora:Impressionism-LoRA-v1.0:0.8>；
  - 反向提示词（Negative Prompt）：low resolution, blurry, sharp edges, photorealistic, text, watermark；
  - 采样配置：采样器DPM++ 2M Karras，推理步数20-30，分辨率512x512/768x512，CFG Scale 7-9；
  - 风格强度调整：通过LoRA权重参数（0.6-1.0）控制风格化程度，权重越高风格特征越显著。

代码调用（Diffusers库）
from diffusers import StableDiffusionPipeline
import torch

# 加载基础模型与硬件配置
pipe = StableDiffusionPipeline.from_pretrained(
    "runwayml/stable-diffusion-v1-5",
    torch_dtype=torch.float16
).to("cuda")

加载LoRA模型
pipe.load_lora_weights("./models/Impressionism-LoRA-v1.0.safetensors")

生成印象派风格图像
prompt = "Paris street scene, summer afternoon, dappled sunlight, impressionist style"
negative_prompt = "low quality, blurry, noise, text"

image = pipe(
    prompt=prompt,
    negative_prompt=negative_prompt,
    num_inference_steps=25,
    guidance_scale=7.5,
    width=512,
    height=512
).images[0]

保存生成结果
image.save("impressionist_paris.jpg")

#训练详情

数据集说明
训练数据来源于Kaggle平台的Painter by Numbers项目，从中筛选200张高质量印象派作品，涵盖风景、人像、静物三大核心类别。该数据集的图像主要源自WikiArt.org，所有素材均受版权保护，本项目仅将其用于数据挖掘与模型训练，符合合理使用原则。

训练配置
- 基础模型：Stable Diffusion 1.5（v1-5-pruned-emaonly.safetensors）；
- 训练工具：kohya_ss sd-scripts；
- 核心参数：文本编码器学习率5e-5，UNet学习率2e-4，10轮基础训练+3轮微调，训练分辨率512x512（启用Bucket机制）；
- 优化配置：AdamW8bit优化器，FP16混合精度训练，Batch Size根据硬件自适应调整；
- 训练日志：详细参数与过程记录见docs/training_log.txt。

#项目结构
Impressionism-LoRA/
├── models/                # 核心模型文件目录
│   └── Impressionism-LoRA-v1.0.safetensors  # 主模型文件
├── train/                 # 训练脚本目录
│   └── train_script.sh    # 训练与微调执行脚本
├── examples/              # 生成效果示例目录
│   └── test_info.txt      # 示例生成参数记录
├── docs/                  # 文档目录
│   ├── training_log.txt   # 训练日志
│   └── deploy.md          # 部署说明
└── README.md              # 项目说明文档

#License
本项目采用MIT License授权，允许非商业与商业场景下的使用、修改及分发。使用者需遵守相关版权规定，不得将模型用于侵权或违规场景，模型开发者不对使用过程中产生的任何损失承担责任。

#致谢
- 基础模型支持：Stable Diffusion 1.5（runwayml）；
- 训练工具支持：kohya_ss sd-scripts；
- 数据集来源：Kaggle Painter by Numbers项目、WikiArt.org公开艺术资源。
