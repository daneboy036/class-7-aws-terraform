#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Background the curl requests
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)

echo "
<!doctype html>
<html lang=\"en\" class=\"h-100\">
<head>
<title>Homework 1</title>
</head>
<body>
    <div>
        <p>I, Daniel, Thank Theo and *TBD Group Leader*, For Teaching Me About EC2s In AWS. One Step Closer To Escaping Keisha!</p>
        <p>With This Class, I Will Net 300k Per Year!</p>
        <img src="https://static.wixstatic.com/media/bb2fa5_09d7830dabc649bfa24db5086c793a87~mv2.jpg" alt="Beach in Madagascar" />
    </div>
    <div>
        <p>I found my wife on a party yacht in Bali! Her name is Maribel!</p>
        <img src="https://thebogotapost.com/wp-content/uploads/2017/05/C8D_c6nXUAU8Rr4-e1494906310862-300x261.jpg" alt="Afro Latina" />
    </div>
<div>
<h1>AWS Instance Details</h1>
<p><b>Instance Name:</b> $(hostname -f) </p>
<p><b>Instance Private Ip Address: </b> ${local_ipv4}</p>
<p><b>Availability Zone: </b> ${az}</p>
<p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>
</div>
</body>
</html>
" > /var/www/html/index.html

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid