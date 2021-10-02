

### Features
* Auto-discover cloud hosts
* Auto-protect cloud hosts
* Vulnerability assessment
	* For OS (Linux and Windows), Applications and  Code (Java, Python,..) and risk prioritization & scoring
* Compliance checks for CIS for Linux, windows checks and custom compliance
	* Evaluate  for PCI, GDPR, HIPAA, NIST compliance regimes
* FIM for Linux OS
* Host BOM with observations on SSH activities, process, ports, and network connections. 
* Runtime protection - Anti-malware detection integrated with WildFire
	* Detect anomalies across process, network, logs, and support for custom runtime protection rules
* WaaS


ONBOARDING and VISIBILITY

### 1. Auto-discover and auto-protect unsecured cloud hosts
* Automated cloud discovery and protection for Cloud hosts
* AWS EC2 (Linux and Windows???)
* Azure VMs (Linux only, Can still deploy on Windows using a different method)
* GCP VMs (Linux and Windows???)

**Step 1 - Add credentials for auto-discover and protect**
* [https://github.com/davidokeyode/prismacloud-workshops-labs/blob/main/workshops/azure-cloud-protection-pcce/modules/6-implement-cloud-discovery.md](https://github.com/davidokeyode/prismacloud-workshops-labs/blob/main/workshops/azure-cloud-protection-pcce/modules/6-implement-cloud-discovery.md)

* What exact permissions are needed? Is the contributor role required?

* **`Manage`** → **`Authentication`** → **`Credential store`** → **`Compliance`** → **`Cloud Platforms`**
	* If in SaaS environment, you can directly import the account you have previously onboarded in Prisma Cloud
	* **`Add credential`** → **`Type`**: Prisma Cloud

**Step 2 - Enable cloud auto-discovery**
* **`Defend`** → **`Compliance`** → **`Cloud Platforms`** → **`Add account`**

**Step 3 – Review discovered workloads**
* **`Radar`** → **`Cloud`** → **`Review workload`**

**Step 4 – Configure auto-protect**
* **`Manage`** → **`Defenders`** → **`Deploy`** → **`Host auto-defend`** → **`Add rule`**
	* **`Rule name`**: 
	* **`Provider`**:
	* **`Console`**: 
	* **`Scope`**:
	* **`Credential`**: 

* **`Radar`** → **`Cloud`** → **`Review workload`** → **`Defend`**


### 2. Deploy host defenders manually

**Step 1 - Protect single hosts**
* **`Manage`** → **`Defenders`** → **`Deploy`** → **`Defenders`** → **`Single Defender`**
	* **`Host Defender – Linux`**
	* **`Host Defender – Windows`**
	* **`Container Defender – Linux`**
	* **`Container Defender – Windows`**


### 3. Visibility – Network connections and overall security

**Step 1 – Enable host network monitoring**
* **Radar** → Settings → Host network monitoring → Enable

* Trigger some network connections
```
Destination host (to listen on port 2002): nc -lkvp 2002 
Source host (to connect to the target host): nc -v <target IP> 2002
```

**Step 2 – Review network connections**
* **`Radar`** → **`Hosts`**

**`Step 3 – Show full security posture of a host from the radar view`**
**`Radar`** → **`Hosts`** → **`Top left corner`** → **`Runtime, Vulnerabilities, Compliance`**


### 4. Security Capabilities – Vulnerability Management
**Step 1 – Configure Vulnerability Management**
* **`Defend`** → **`Vulnerabilities`** → **`Hosts`** → **`Running Hosts`** → **`Add rule`**
	* **Rule Name**: Org Host Vulnerability Policy
	* **Alert Threshold**: Low
	* **Expand Advanced Settings**
		* **Apply rule only when vendor fixes are available**: On
	* Leave other settings at default value
	* Click on **`Save`**

**Step 2 – Review vulnerabilities**
* **`Monitor`** → **`Vulnerability`** → **`Vulnerability Explorer`** → **`Top critical vulnerabilities (CVEs)`** → **`Hosts`**
	* Select vulnerability and review risk factors

* **`Monitor`** → **`Vulnerability`** → **`Vulnerability Explorer`** → **`Trend by Resources`**

* **`Monitor`** → **`Vulnerability`** → **`Hosts`** → **`Running Hosts`** → **`Select Host`** 
	* **`Vulnerabilities`** → **`Expand Vulnerability`** → **`Tags`** → **`Add Tags to CVE`**
		* We can use this to filter at the top
	* **`Package Info`** → **`Expand Vulnerability`** → **`Tags`** → **`Add Tags to CVE`**




### 4. Security Capabilities – Runtime Protection
* **`Use cases`**
	* Multi-layer protection against known and unknown malware and cryptominers
	* Exploit protection (crypto miners, exploitation tools, C2 infrastructure, password attacks, sniffing and spoofing tools)
	* Prevent usage of software not installed via package manager
	* Customizable to protect against any emerging threats or organization specific requirements.

**Step 1 – Configure Runtime Protection**
* **`Defend`** → **`Runtime`** → **`Host Policy`** → **`Add rule`**
	* **Rule Name**: Org Host Runtime Protection Policy
	* **Anti-malware**
		* **`Denied process effect`**: Prevent
		* **`Deny process by category`**: Exploit tools; Persistent access; Password attacks; Sniffing and spoofing; Add **`nc`**
		* 

**Step 2 - Configure wildfire Detection**
* Wildfire can be used to receive a verdict for any file it has previously seen, as well as analyze new files with ML based detection and behavior analytics.

* **Enable wildfire**:
	* **`Manage`** → **`System`** → **`Wildfire`** → **`Enable`** → **`Save`**

* **Configure wildfire analysis**
	* **`Defend`** → **`Runtime`** → **`Host Policy`** → **`Add or edit rule`**
		* **`Non-packaged binaries created or run by service`**: Prevent or Alert
		* **`Non-packaged binaries created or run by user`**: Prevent or Alert
		* **`Use WildFire malware analysis`**: Alert

* **Wildfire malware sample**
	* **`Search`** → **`Sample`**
	* **`WildFire Verdict`** is **`Malware`**
	* **`File Type`** is **`ELF`**

* **Process detection step - NMAP**
	* Install and run
		```
		apt install nmap -y
		nmap -h
		```
	* Review
		* **`Monitor`** → **`Events`** → **`Host audits`**

* **Cryptominer**
	* Install and run
		```
		apt update -y
		apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
		git clone https://github.com/xmrig/xmrig.git
		cd xmrig && mkdir build && cd build
		cmake ..
		make
		./xmrig
		```
	* Review
		* **`Monitor`** → **`Events`** → **`Host audits`**
		* **`Monitor`** → **`Runtime`**

* **Processes running from temporary storage**
	* Typically legitimate binaries should not be executed from temporary storage
	* 
	```
	 cp /bin/ls /tmp
	 /tmp/ls
    ```

* **Suspicious ELF headers**
	* By examining various characteristics of ELF headers, we can determine if a file is suspicious. 
	* In the following example, we demonstrate how a binary that does not match the machine architecture can indicate that malicious software/user that is not aware of the machine architecture is trying all sorts of binaries until one would work.
	* Ensure "Processes running from temporary storage" is set to alert:

	```
	curl -L https://github.com/Miraje/dropbear/blob/master/dropbear?raw=true -o dropbear-arm-32
	```




on a target VM affected by the selected policy, and execute it from /tmp.
If “Processes running from a temporary storage is set to prevent, demonstrate that execution of ls from /tmp is prevented:













Set packaged binaries detection to either alert or disable and explain the reasoning behind it:

Prevent/Alert unwanted processes



	* **Expand Advanced Settings**
		* **Apply rule only when vendor fixes are available**: On
	* Leave other settings at default value
	* Click on **`Save`**















Comprehensive vulnerability assessment  for OS (Linux and Windows), Applications and  Code (Java, Python,..) and risk prioritization & scoring
Compliance checks for CIS for Linux, windows checks and custom compliance. Evaluate  for PCI, GDPR, HIPAA, NIST compliance regimes
FIM for Linux OS
Host BOM with observations on SSH activities, process, ports, and network connections. 
Runtime protection - Anti-malware detection integrated with WildFire. Detect anomalies across process, network, logs, and support for custom runtime protection rules







