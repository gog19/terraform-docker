# GitHub on AWS Cloud9 with SSH

Create an EC2 environment. For Platform, choose the type of Ubuntu EC2 instance.
```
https://console.aws.amazon.com/cloud9/
```

Clone your GitHub project inside of your AWS Cloud9 environment.
```
git clone https://github.com/gog19/terraform-docker.git
```

Resize an Amazon EBS volume that an environment uses.
Run the following command, replacing 20 with the size in GiB that you want to resize the Amazon EBS volume to.
```
cd terraform-docker
chmod +x resize.sh
./resize.sh 20
```
Generate RSA Key Pair.
```
ssh-keygen -t rsa
```

Copy the Public Key to You GitHub Account.
```
cat ~/.ssh/id_rsa.pub
```

In your Github profile go to setting->SSH and GPG keys-> New SSH key.
```
https://github.com/settings/ssh/new
```

### Add SSH Key to the SSH Agent
Start your ssh-agent in the background.
```
eval $(ssh-agent -s)
```
Add your ssh key.
```
ssh-add ssh-add ~/.ssh/id_rsa
```

### Change Git Remote to use SSH authentication
```
git remote -v
git remote set-url origin git@github.com:gog19/terraform-docker.git
```