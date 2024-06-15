# Deployment (WIP)
## リソースの作成
[Rain](https://github.com/aws-cloudformation/rain) を使用する例です。
以下のコマンドでサーバーが立ち上がります。
```bash
rain deploy cfn/root.yaml $STACK_NAME
```

## サーバーの起動
- inf インスタンスで vLLM の API サーバーを起動
    - vLLM はパッチを当てる
    - transformers-neuronx もパッチが必要な場合あり
- fastchat controller, web server を `docker compose` で起動
    - api_endpoints.json を書く
- API Gateway を設定
    - Resource Policy でアクセスを許可
- Gradio の前段の ALB を https 化
    - ドメイン取得
    - 証明書を取得