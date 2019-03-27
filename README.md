# 【 zenbuPortable 】
# 　 Port Them All.
## Welcome to zenbuHQ, the basecamp for all of zenbuPortables.
【zenbuPortable】is Beta version now.

### Getting Started:
- See [Wiki](https://github.com/jtFuruhata/zenbuHQ/wiki)

### How to Install apps:
- put "truly" portable applications into apps slots
    - "truly" means no symlinks, no socket files, etc... be able to run on FAT32.
- that's all....... er,  applogize for inconvinience yet.

### How to use zenbuVSCode at first time (Windows + Japanese Keyboard)

- Double-click `VSCode`
- Hit `Ctrl`+`Alt`+`O` to open workspace
    - Select `home.code-workspace`
- Hit `Ctrl`+`Alt`+`@` to enable workspace shell settings
- Hit `Ctrl`+`@` to open zenbuConsole

### How to use zenbuVSCode at first time (Mac + Japanese Keyboard)

- Double-click `VSCode.command`
- Hit `Ctrl`+`Option`+`O` to open workspace
    - Select `home.code-workspace`
- Hit `Ctrl`+`Shift`+`Option`+`@` to enable workspace shell settings
- Hit `Ctrl`+`Shift`+`@` to open zenbuConsole

## Release Note:
- Beta Ver 1.20.190327c
    - zenbuVSCode selects `user-data` and `extensions` automatically
        - describe in the top of line at `*.code-workspace` such this:
            - `#zenbuVSCode default default`
        - first `default` for `user-data`, zenbuVScode directs to `.vscode/default/user-data`
        - also second one for `extensions`
        - Yep no problem if you get a JSON error, VSCode works fine.
    - add zenbuCore functions (are in zenbuEnv)
        - `zc` ... Open new zenbuConsole instance
        - `zv` ... Open new zenbuVSCode instance
        - `zs` ... Call zenbuSummoner (switching source/command automatically)
        - `zenbuenv` ... (yet experimental)
        - `zenbulib` ... (yet experimental)
    - add common functions (are in set-depends.sh)
        - `clip-key` ... Copy $SSH_ID PubKey to clipboard
        - `open-new-bash [<bash options>]`... Open a new console window
    - add SSH functions (are in zenbuSummoner)
        - `addkey` ... ssh-add $SSH_KEY
        - `rmkey`  ... ssh-add -d $SSH_KEY
    - WARNING change `.code-workspace` filenames to `default` and `HQ`
    - WARNING move `.code-workspace` files to these `.vscode`
    - change: zenbuVSCode opens `$1.code-workspace` in `ws/*/.vscode` automatically
        - you may use `default` for `ws` and `HQ` for `zenbuHQ`. default is `default`
        - you may check this exec mode by `$zenbuModeConsole` from scripts
    - change: zenbuVSCode no longer ssh-add $SSH_KEY at starting and zenbuSummoner -k at terminating
        - please use `addkey` and `zs -k` manually if necessary
        - zenbuConsole(zenbuOpenner) which is parent still recall agent at terminating
        - So, to share zenbuConsole's agent among all instances, I guess you should open zenbuConsole first, and type `zv` to open zenbuVSCode. That's more convinient for use with multi instance.
        - VSCode.lnk/.command are still remaining for noobies
    - remove portableGitPortal.sh
        - move to win/set-depend.sh and export -f all functions
    - bugfix: zenbuEnv passes $1 to zenbuSummoner unexpectedly
- Beta Ver 1.11.190325c
    - add keybindings.json.template (for Japanese keyboard)
        - `Ctrl`+`Alt`+`O`
            - Workspaces: Open Workspace
        - `Ctrl`+`Shift`+`G` `Ctrl`+`Shift`+`S`
            - Git: Sync
        - `Ctrl`+`,`
            - Preferences: Open Settings (JSON)
        - `Ctrl`+`Alt`+`@`
            - Terminal: Allow Workspace Shell Configuration
    - add ws/*.code-worspace
    - zenbuEnv restores .template files which was described "!" in MANIFEST if necessory
    - zenbuSummoner adds autoCRLF=false to .gitconfig
        - we must use LF for all scripts. Be careful.
    - WARNING change action: "zenbuSummoner -k" recalls only own SSH_AGENT_PID, just call "ssh-agent -k" (only Windows)
        - "zenbuSummoner -r" recalls all agents, same as previous "-k" (only Windows)
- Beta Ver 1.10.190325b
    - migrate to zenbuHQ
        - add "zenbuManifest"ize .gitignore
        - you can update core scripts by git pull
        - only core scripts and structures can be committed, exclude apps, etc. 
    - zenbuDetector starts to detect OS bitness on Windows
        - you can switch win/amd64 or win/32 at apps slot
        - win/arm64 and win/ia64 use win/32 via WOW64 (maybe, didn't check)
    - WARNING change dir structure: move apps/win to apps/win/amd64
    - WARNING change env: $G_ROOT holds instead of /bin
- Beta Ver 1.00.190322a
    - initial release


## Release 2.0 Plan
- zenbuEnv ... Rename all shellenvs to `zenbuCamelCase`
    - for show `export | grep "^declare -x zenbu"` 
- zenbuLib ... Move all functions into zenbuLib architecture
- zenbuManifest ... Manage zenbuPortable packages with manifest file
- zenbuDistributor ... Make a custom (light-weight) zenbuPortable
