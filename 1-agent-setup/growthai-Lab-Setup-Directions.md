# growth.ai Lab — Setup Directions

## Your two new accounts

| Account | Address | Use |
|---|---|---|
| 1 · Howden | `fn.ln.ailab@howdengroup.com` | Not a working mailbox. Cannot send/receive email or access Microsoft tools. Used only to log in to the Windows 365 Cloud PC. |
| 2 · Proton | `fn.ln@growthailab.uk` | Your working lab email for the whole programme. Linked to Claude, Obsidian, and every other tool in the Lab. Access via the Proton Mail app on your phone — email isn't available on the Cloud PC. |

## 1. Activate your Proton Mail account

<img src="./qr-proton-mail.png" width="100px" height="100px">
Scan the qr to find Proton Mail on the App Store, or [use this link](https://apps.apple.com/uk/app/proton-mail-encrypted-email/id979659905).


1. On your phone, install the Proton Mail app from the App Store.
2. On your phone, open Outlook, find the Proton Mail activation invitation, and tap the activation link.
3. Set a password and save it somewhere.
4. Sign in to the Proton Mail app with your new lab email and password.

## 2. Log in to your Cloud PC

### Install the Remote Desktop client

1. Go to `https://learn.microsoft.com/en-us/previous-versions/remote-desktop-client/whats-new-windows?tabs=windows-msrdc-msi`
2. Download the Public x64 installer.
3. Run the installer.

### Launch the Cloud PC

1. Open the Remote Desktop app.
2. Click the three-dot menu, then Subscribe.
3. Click Use another account.
4. Sign in with Account 1 (`fn.ln.ailab@howdengroup.com`).
5. Launch your Cloud PC.

# !!! From here on, do everything inside your Windows 365 Cloud PC.

## 3. Activate Claude and Claude Code

### Install Google Chrome
1. Press Start, type `PowerShell`, and open it.
2. Paste and run this command:
    ```
    winget install Google.Chrome
    ```
    *(or use `winget find [browsername]` to install your preferred <ins>chrome-based</ins> browser)*
3. Type `Y` to accept winget terms if prompted.
4. Follow installation prompts and launch Google Chrome

### Accept the Claude team invite

1. Visit [http://claude.ai/] and enter your `@growthailab.uk` email address to login
2. Click through the verification email on your Proton Mail app and select "Login with code"
3. Enter the code in verification box on Claude.ai to activate your account.

### Install the Claude desktop app

1. Visit [http://claude.ai/downloads].
2. Download "Claude for Windows."
3. Run the installer.
4. Open Claude and login using your `@growthailab.uk` address.

### Install Claude Code

1. Copy this command and run it in Powershell:
    ```
    winget install Anthropic.ClaudeCode
    ```
2. Close and reopen PowerShell.
3. Run `claude` to confirm installation.
4. Follow the prompts to authenticate Claude Code.

## 4. Install Obsidian and create a vault

1. Reopen Powershell and run this command:
  ```
  winget install Obsidian.Obsidian
  ```
2. Open Obsidian.
3. Make a new Obsidian account with your Proton email.
4. Click Create new vault.
5. Name it `[your name]_ai`, or whatever you like.
6. Set the location to your Documents folder.
7. Click Create.
8. For more on Obsidian, visit `obsidian.md`.

## 5. Build your assistant in Claude Cowork

### Add the agent bootstrapping plugin

1. In Claude, click on `Customize` in the left column, and select the `Plugins` section.
2. Click `Browse`, and you should see a section called `Your organization`. 
3. The "Agent bootstrap" plugin should be avaialble. Press the '+' to install.

### Set up the project

1. Open the Claude desktop app.
2. Click the Cowork tab.
3. Click Projects, then +, then Start from scratch.
4. Give the project a suitable name, e.g. `michaelsobedientaiservant`, and open it. *(kidding.. I chose "rok")
5. Add your obdidian vault folder to the project. 

### Run setup

1. In the chat, run `/setup-agent`
2. Answer the prompts: assistant name, what it calls you, timezone (London), daily check-in time.
3. Wait for the assistant to introduce itself.

---
growth.ai Lab · A Growth Engine for Howden Specialty
