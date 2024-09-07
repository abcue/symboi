terraform {
  backend "cos" {
    bucket = "terraform-backend-appid"
    region = "ap-shanghai"
    prefix = "symboi/tencentcloud/account/cos/bucket"
  }
}
