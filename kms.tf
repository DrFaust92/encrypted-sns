resource "aws_kms_key" "topic_key" {
  description             = "Topic Key"
  policy                  = "${data.aws_iam_policy_document.topic_key_kms_policy.json}"

}
data "aws_iam_policy_document" "topic_key_kms_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["s3.amazonaws.com"]
      type = "Service"
    }
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
    resources = ["${aws_s3_bucket.bucket.arn}"]
  }
  # allow root user to administrate key
  statement {
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${account_id}:root"]
      type = "AWS"
    }
    actions = [
      "kms:*"
    ]
    resources = ["*"]
  }
}
resource "aws_kms_alias" "topic_key_alias" {
  name          = "alias/topic-key"
  target_key_id = "${aws_kms_key.topic_key.key_id}"
}