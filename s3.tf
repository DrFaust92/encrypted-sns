resource "aws_s3_bucket" "bucket" {
  bucket        = "some-bucket"
}

resource "aws_s3_bucket_notification" "s3_notif" {
  bucket = "${aws_s3_bucket.bucket.id}"

  topic {
    topic_arn = "${aws_sns_topic.topic.arn}"

    events = [
      "s3:ObjectCreated:*",
    ]

  }
}