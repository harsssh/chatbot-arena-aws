# Chatbot Arena AWS
## システム構成
![Architecture](assets/architecture.jpg)

## デプロイ
[docs/deploy.md](docs/deploy.md) を参照してください。

## インスタンスへのログイン
Session Manager Plugin のインストールが必要です。(refs: [AWS CLI 用の Session Manager プラグインをインストールする](https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html))

```bash
aws ssm start-session --target $INSTANCE_ID
```

参考: インスタンスの一覧取得
```bash
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`]|[0].Value, InstanceId]' --output table
```
