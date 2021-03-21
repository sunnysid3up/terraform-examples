# Terraform-examples
Use Terraform to provision AWS resources.

### Run
```bash
# 인프라 전체 생성
./devops.sh create

# 인프라 전체 삭제
./devops.sh destroy

# 앱 배포
./devops deploy
```

### Steps
1. Create AWS resources using the devops.sh script.
2. Open terminal and enter `terraform console`.
3. Enter `module.alb.web_dns_name` and copy the result.
4. Open browser and paste the DNS name.
   You should see `Hello World from IBM Cloud Essentials!`