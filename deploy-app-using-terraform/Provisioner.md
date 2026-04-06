# 🚀 Deploy Flask App on AWS using Terraform

## 📌 Project Overview

This project demonstrates how to deploy a simple Flask web application on an AWS EC2 instance using Terraform.

It includes:
- Infrastructure provisioning using Terraform
- VPC, Subnet, Internet Gateway setup
- Security Group configuration
- SSH access using key pairs
- Automated app deployment using provisioners
- Running a Flask application on EC2

---

## 🏗️ Architecture

```
Terraform
   ↓
AWS VPC
   ↓
Public Subnet
   ↓
EC2 Instance
   ↓
Flask App (Port 80)
   ↓
Browser
```

---

## ⚙️ Technologies Used

- Terraform
- AWS EC2
- AWS VPC
- Python (Flask)
- SSH

---

## 📁 Project Structure

```
deploy-app-using-terraform/
│
├── main.tf        # Terraform configuration
├── app.py         # Flask application
├── README.md      # Project documentation
```

---

## 🔑 Prerequisites

- AWS Account
- Terraform installed
- AWS CLI configured (`aws configure`)
- SSH key pair generated

---

## 🔐 Generate SSH Key

```bash
ssh-keygen
```

Keys will be stored in:

```
C:\Users\<your-username>\.ssh\
```

---

## 🚀 Deployment Steps

### 1. Initialize Terraform

```bash
terraform init
```

---

### 2. Plan Infrastructure

```bash
terraform plan
```

---

### 3. Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted.

---

## 🔗 Connect to EC2

```bash
ssh -i C:\Users\<your-username>\.ssh\id_ed25519 ubuntu@<public-ip>
```

---

## ▶️ Run the Application

```bash
cd /home/ubuntu
sudo python3 app.py
```

---

### Run in Background (Recommended)

```bash
nohup sudo python3 app.py > app.log 2>&1 &
```

---

## 🌐 Access the Application

Open in browser:

```
http://<public-ip>
```

---

## 🔧 Troubleshooting

### ❌ App not loading
- Ensure Security Group allows:
  - HTTP (port 80)
  - SSH (port 22)

---

### ❌ Flask installation error

```bash
sudo apt update
sudo apt install python3-flask
```

---

### ❌ Check logs

```bash
cat app.log
```



## 👨‍💻 Author

Abinesh

---

## ⭐ Summary

This project demonstrates:
- Infrastructure as Code using Terraform
- Cloud deployment on AWS
- Running a web application on EC2