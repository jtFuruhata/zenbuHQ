# 【 zenbuPortable 】
# 　 Port Them All.
## Welcome to zenbuHQ, the basecamp for all of zenbuPortables.
【zenbuPortable】is still UNDER CONSTRUCTION here.

How to Install apps:
- put "truly" portable applications into apps slots
    - "truly" means no symlinks, no socket files, etc... be able to run on FAT32.
- that's all....... er,  applogize for inconvinience yet.

How to use zenbuVSCode at first time (Windows + Japanese Keyboard)

- Double-click `VSCode`
- Hit `Ctrl`+`Alt`+`O` to open workspace
    - Select `home.code-workspace`
- Hit `Ctrl`+`Alt`+`@` to enable workspace shell settings
- Hit `Ctrl`+`@` to open zenbuConsole

How to use zenbuVSCode at first time (Mac + Japanese Keyboard)

- Double-click `VSCode.command`
- Hit `Ctrl`+`Option`+`O` to open workspace
    - Select `home.code-workspace`
- Hit `Ctrl`+`Shift`+`Option`+`@` to enable workspace shell settings
- Hit `Ctrl`+`Shift`+`@` to open zenbuConsole

## Release Note:
- Ver 1.11.190325c
    - add keybindings.json.template (for Japanese keyboard)
        - Ctrl+Alt+O
            - Workspaces: Open Workspace
        - Ctrl+Shift+G Ctrl+Shift+G
            - Git: Sync
        - Ctrl+,
            - Preferences: Open Settings (JSON)
        - Ctrl+Alt+@
            - Terminal: Allow Workspace Shell Configuration
    - add ws/*.code-worspace
    - zenbuEnv restores .template files which was described "!" in MANIFEST if necessory
    - zenbuSummoner adds autoCRLF=false to .gitconfig
        - we must use LF for all scripts. Be careful.
    - WARNING change action: "zenbuSummoner -k" recalls only own SSH_AGENT_PID, just call "ssh-agent -k" (only Windows)
        - "zenbuSummoner -r" recalls all agents, same as previous "-k" (only Windows)
- Ver 1.10.190325b
    - migrate to zenbuHQ
        - add "zenbuManifest"ize .gitignore
        - you can update core scripts by git pull
        - only core scripts and structures can be committed, exclude apps, etc. 
    - zenbuDetector starts to detect OS bitness on Windows
        - you can switch win/amd64 or win/32 at apps slot
        - win/arm64 and win/ia64 use win/32 via WOW64 (maybe, didn't check)
    - WARNING change dir structure: move apps/win to apps/win/amd64
    - WARNING change env: $G_ROOT holds instead of /bin
- Ver 1.00.190322a
    - initial release