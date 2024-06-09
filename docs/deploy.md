# Deployment (WIP)
## リソースの作成
[Rain](https://github.com/aws-cloudformation/rain) を使用する例です。
以下のコマンドでサーバーが立ち上がります。
```bash
rain deploy cfn/root.yaml $STACK_NAME
```

## ECR へのログイン
各インスタンスは IAM ロールによって ECR へのアクセスを許可しています。

Private なリポジトリにアクセスするには、以下のコマンドを実行してください。
```bash
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPOSITORY_URI 
```

## Controller の起動
Controller のインスタンスにログインし、以下のコマンドを実行してください。
```bash
docker run -d -p 3000:3000 $IMAGE_NAME -m fastchat.serve.controller --host 0.0.0.0 --port 3000
```

## Gradio Web Server の起動
Gradio Web Server のインスタンスにログインし、以下のコマンドを実行してください。
```bash
docker run -d -p 8080:8080 $IMAGE_NAME -m fastchat.serve.gradio_web_server_multi --host 0.0.0.0 --port 8080 --controller-url http://$CONTROLLER_IP
```
