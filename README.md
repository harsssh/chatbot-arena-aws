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

## ECR へのイメージの push
`fastchat` という名前の ECR リポジトリを作成します。
(現状、Workflow でリポジトリ名をハードコードしているため、他の名前は不可)

以下の Cfn を実行し、CI 用の IAM Role を作成します。
- [provisioning/configure-aws-credentials.yaml](provisioning/configure-aws-credentials.yaml)
- [provisioning/attach-ecr-policy.yaml](provisioning/attach-ecr-policy.yaml)

Repository Secret に `AWS_IAM_ROLE_ARN` を設定します。

`fastchat` から始まるタグを push することで、イメージの build と push が実行されます。

タグの push は以下のように行います。
```bash
git tag fastchat-v0.1.0
git push --tags
```