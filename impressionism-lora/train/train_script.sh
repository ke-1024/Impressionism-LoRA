# 印象派LoRA训练命令（基础训练）
cd /root/kohya_ss/sd-scripts && python train_network.py \
  --train_data_dir /root/autodl-tmp/train_parent \
  --output_dir /root/autodl-tmp/lora_output \
  --pretrained_model_name_or_path /root/autodl-tmp/models/v1-5-pruned.safetensors \
  --network_module networks.lora \
  --train_batch_size 2 \
  --max_train_epochs 10 \
  --learning_rate 2e-4 \
  --text_encoder_lr 5e-5 \
  --resolution 512 \
  --caption_extension .txt \
  --save_model_as safetensors \
  --mixed_precision fp16 \
  --enable_bucket \
  --xformers \
  --save_every_n_steps 500

# 微调命令（补充数据后）
cd /root/kohya_ss/sd-scripts && python train_network.py \
  --train_data_dir /root/autodl-tmp/train_parent \
  --output_dir /root/autodl-tmp/lora_output_finetune \
  --pretrained_model_name_or_path /root/autodl-tmp/models/v1-5-pruned.safetensors \
  --network_module networks.lora \
  --train_batch_size 2 \
  --max_train_epochs 3 \
  --learning_rate 1e-4 \
  --text_encoder_lr 2.5e-5 \
  --resolution 512 \
  --caption_extension .txt \
  --save_model_as safetensors \
  --mixed_precision fp16 \
  --enable_bucket \
  --xformers \
  --network_weights /root/autodl-tmp/lora_output/last.safetensors

