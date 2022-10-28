<h1>Host a static website with S3 bucket</h1>

<h2>Create a s3 bucket with terraform</h2>

<p>Refer to these links:</p>
<li>https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket</li>
<li>https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration</li>
<li>https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html</li>

Create s3 bucket related resources:
    <li>aws_s3_bucket</li>
    <li>aws_s3_bucket_acl</li>
    <li>Aws_s3_bucket_website_configuration</li>

Use terraform init/plan/validate before terraform apply to correct any syntax errors, such as the acl parameter only accepts certain values, single quotes ‘’ is not accepted so you have to use double quotes etc. Then verify it from the console to confirm the s3 bucket is being created. 

Now upload the index.html and error.html to the created s3 bucket. 

Access the website with the endpoint of(refer to https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteEndpoints.html):
<li>s3-website dash (-) Region ‐ http://bucket-name.s3-website-Region.amazonaws.com</li>
<li>s3-website dot (.) Region ‐ http://bucket-name.s3-website.Region.amazonaws.com</li>

It returns 403 forbidden errors. Now to troubleshoot it. Refer to https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteAccessPermissionsReqd.html to set the grant policy.  Refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy to add the s3 bucket policy with terraform. 

It can be tricky that you will need to have ACL for both s3 bucket and s3 bucket object, see the different in https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html

And quite important when creating the s3 object make sure the ACL is configured to comparing with the console(the public read for everyone):
resource "aws_s3_object" "anne-test-website-index-html" {
 bucket = aws_s3_bucket.anne-test-website.id
 key    = "index.html"
 source = "../website/helloworld/index.html"
 acl = "public-read"
}






Separately, you can try to use safari rather than Chrome browser to test the static website as Chrome may have some issue with opening the page or simply downloading the html file. 

If you still have problems of s3 not serving the website but downloading the html file itself, make sure you try with the sample template listed in AWS https://docs.aws.amazon.com/AmazonS3/latest/userguide/IndexDocumentSupport.html


<h2>Add html page and any image or videos</h2>

<h2>Add AWS Cloudfront in terraform</h2>

Refer to https://www.youtube.com/watch?v=oHOS4z6p8Bg


Now test the CDN distribution works. If it doesn’t work, eg the html displays without the image/video served, it is probably the CDN domain name you used in the html file is not updated, as you only got the CDN domain name after cloudfront being applied, in this case it means you will need to deploy the html 2 times to reflect the correct domain name, especially the image/video source using the CDN domain name. Also please be noted that you probably will need to restart the browser or clear the cache so your http/s request approaches the right domain name by inspecting the request. 



<h2>Limit s3 bucket access only to cloudfront rather than Public. </h2>

<li>Refer to the https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html to understand the procedure to set the acl and permission, refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document to create the terraform code.</li>
<li>Create aws_cloudfront_origin_access_control refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control</li>
<li>Change the s3 bucket ACL from “public-read’ to “private”.</li>
<li>(Not implemented in terraform, seems like it is not supported)Change the origin access from “legacy access identifies” to “origin access control setting” in terraform code(seems like this is not implemented in Terraform, at this stage it can only be changed from console)</li>
<li>Now test the website</li>
<li>Note, this can be useful: https://hands-on.cloud/managing-amazon-cloudfront-using-terraform/</li>
<li>Now you can access the website through the domain name provided by AWS cloudfront.</li>
