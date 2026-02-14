# -My-Opt-Journey

Godot 4 기반 DAY1 세로 슬라이스(준비 → 방송전투 2개 → 리포트/저장) 프로젝트입니다.

## 현재 포함된 것
- Autoload 3종: `GameState`, `SaveManager`, `Data`
- 씬 4종: `Title`, `Prep`, `StreamBattle`, `Report`
- UI 씬 3종: `ChatLog`, `CommandBar`, `QTE`
- 데이터: `data/day1_enemies.json` (상황 2개)
- 실행 설정: `project.godot`에 `run/main_scene`와 autoload 등록 포함

## 실행 방법
1. Godot 4에서 프로젝트 폴더를 열기
2. `project.godot`를 읽어 메인 씬/autoload가 자동 적용되는지 확인
3. F5로 실행 (Title → Prep → StreamBattle → Report)

## 폴더 구조

```text
res://
  autoload/
    GameState.gd
    SaveManager.gd
    Data.gd
  data/
    day1_enemies.json
  scenes/
    Title.tscn
    Prep.tscn
    StreamBattle.tscn
    Report.tscn
  ui/
    ChatLog.tscn
    QTE.tscn
    CommandBar.tscn
    ChatLog.gd
    QTE.gd
    CommandBar.gd
  scripts/
    Title.gd
    Prep.gd
    StreamBattle.gd
    Report.gd
  assets/
    portraits/
    bg/
    icons/
```

## 노드 이름 계약(중요)
스크립트는 아래 노드 이름을 직접 조회합니다. 이름이 다르면 실행 오류가 납니다.

- `Title.tscn`: `NewGameButton`, `ContinueButton`
- `Prep.tscn`: `DayLabel`, `TopicOption`, `PrepOption`, `StartStreamButton`, `StatsLabel`
- `StreamBattle.tscn`: `Portrait`, `ChatLog`, `CommandBar`, `QTE`
- `Report.tscn`: `ReportLabel`, `ExitButton`
- `ui/ChatLog.tscn`: `Log`
- `ui/CommandBar.tscn`: `TalkButton`, `JokeButton`, `ModButton`, `ItemButton`
- `ui/QTE.tscn`: `PromptLabel`, `Choice1`, `Choice2`, `Choice3`

## 이미지 리소스 갈아끼우기
`assets/` 경로에 플레이스홀더를 넣은 뒤, 동일 파일명으로 교체하는 방식을 권장합니다.

예시:
- `res://assets/portraits/pungchi_neutral.png`
- `res://assets/bg/stream_room.png`
- `res://assets/icons/water.png`
- `res://assets/icons/lipstick.png`

## 트러블슈팅
- `Node not found`: 노드 이름 오타 확인
- `Attempt to call function on null`: 씬 인스턴스/Autoload 등록 확인
- `Invalid get index`: `day1_enemies.json` 키 이름 확인
