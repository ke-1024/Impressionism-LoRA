# 部署教程
## 本地部署
1. 安装Stable Diffusion WebUI
2. 将models/Impressionism-LoRA-v1.0.safetensors复制到webui/models/Lora/
3. 启动WebUI，按README中的提示词测试

## 服务器部署（Autodl）
1. 租用带GPU的容器，安装WebUI
2. 上传模型到/root/stable-diffusion-webui/models/Lora/
3. 启动命令：./webui.sh --listen --port 6006
