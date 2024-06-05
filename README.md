# llmjp-playground
## システム構成 (WIP)
- Public Subnet
    - FastChat Gradio Web Server
    - Bastion Host
    - NAT Gateway
- Private Subnet
    - FastChat Controller 
    - Model Endpoint

補足:
- NAT Gateway は Private Subnet からのインターネットアクセスのために使用
- Bastion Host は Public/Private Subnet の各インスタンスに SSH するために使用 (デバッグ用)
- 最終的には Gradio Web Server も Private Subnet に配置し、ALB で公開したい

## デプロイ方法
- AWS CLI がインストールされていることを前提とします。
- 事前に S3 Bucket を作成してください。
(CloudFormation Template のアップロードに使います。)

プロジェクトルートで以下のようにスクリプトを実行してください。
```bash
S3_BUCKET="<bucket_name>" STACK_NAME="<stack_name>" scripts/deploy.sh
```

スタックを更新する場合は、`scripts/update.sh` を同様に実行してください。

(⚠️ CLI の設定によっては、そのままでは動きません。)

## サーバーへの SSH
テンプレートで踏み台サーバー、及びその他のサーバー用に 2 種類のキーペアを作成しています。
(秘密鍵はパラメータストアを参照し、保存してください。)

`~/.ssh/config` に以下の設定を書くことで、各サーバーに SSH できます。
```
Host bastion
    Hostname <bastion_public_ip>
    User <login_user>
    IdentityFile <path_to_bastion_key_pair>
    ForwardAgent yes
    
Host controller
    Hostname <controller_private_ip>
    User <login_user>
    IdentityFile <path_to_controller_key_pair>
    ProxyJump bastion
    
# その他のサーバーも同様
```

上の例の場合、踏み台サーバーへの SSH は `ssh bastion`, Controller サーバーへの SSH は `ssh controller` を実行します。