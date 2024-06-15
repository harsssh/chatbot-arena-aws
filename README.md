# Chatbot Arena AWS
## システム構成

## デプロイ
[docs/deploy.md](docs/deploy.md) を参照してください。

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