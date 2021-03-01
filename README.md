Take home terraform assignment

<strong>Prerequisites:</strong>
<ul>
  <li>AWS Account</li>
  <li>IAM User with Access Key & Secret Key</li>
  <li>AWS CLI</li>
  <li>Terraform(0.12.29)</li>
</ul>

<strong>1. Configure local machine:</strong>
<ul>
  <li>Install AWS CLI</li>
  <li>Open terminal(linux/mac)/command prompt(windows)</li>
  <li>Run <code>aws configure</code></li>
  <li>Provide the access key, secret key and region as requested</li>
</ul>

<strong>2. Setup Infrastructure:</strong>
<ul>
  <li>Download all files from the repository. Make sure you are in the directory where the root main.tf file is. <strong>Note: You must generate your own public key and place it in a file called public-key at the root level.</strong></li>
  <li>Open terminal(linux)/command prompt(windows)</li>
  <li>Run <code>terraform init</code> command</li>
  <li>Run <code>terraform apply</code> command. Provide <strong>yes</strong> as input when asked and hit enter</li>
</ul>


<p>3. Test the Infrastructure:</p>
<ul>
  <li>Terraform outputs the load balancer dns. Copy the dns name.</li>
  <li>Paste the dns name in your browser's URL bar and hit enter</li>
  <li>You should now see a "Hello World" meesage</li>
</ul>
