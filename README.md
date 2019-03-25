# 【 zenbuPortable 】
# 　 Port Them All.
## Welcome to zenbuHQ, the basecamp for all of zenbuPortables.
【zenbuPortable】is still UNDER CONSTRUCTION here.

## Release Note:
- Ver 1.10.190325b
  - Migrate to zenbuHQ
  - zenbuDetector starts to detect OS bitness on Windows
    - you can switch win/amd64 or win/32 at apps slot
    - win/arm64 and win/ia64 use win/32 via WOW64 (maybe, didn't check)
  - WARNING change dir structure: move apps/win to apps/win/amd64
  - WARNING change env: $G_ROOT holds instead of /bin
- Ver 1.00.190322a
