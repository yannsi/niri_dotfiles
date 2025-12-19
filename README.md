# Niri Dotfiles

Arch Linux + Niri デスクトップ環境の設定ファイル集です。
統一感のあるパステルテーマ（Catppuccin Macchiato風）で構成されています。

## 収録されている設定

- **Window Manager**: Niri
- **Status Bar**: Waybar
- **Terminal**: Alacritty
- **Launcher**: Fuzzel
- **Screen Locker**: Swaylock
- **Shell Prompt**: Starship

---

## 新しい環境でのセットアップ手順

新しい Arch Linux 環境でこれらの設定を使用するための手順です。

### 1. GitとSSHの準備

まず Git をインストールし、GitHub に接続できるように SSH 鍵を設定します。

```bash
sudo pacman -S git openssh

# SSH鍵の生成（既に鍵を持っている場合はスキップ）
ssh-keygen -t ed25519 -C "your_email@example.com"

# 公開鍵を表示してコピーし、GitHubの設定画面に登録してください
cat ~/.ssh/id_ed25519.pub
```

### 2. リポジトリのクローン

ホームディレクトリに設定をダウンロードします。

```bash
git clone git@github.com:yannsi/niri_dotfiles.git ~/dotfiles
```

### 3. 設定の適用（自動スクリプト）

付属のセットアップスクリプトを実行すると、自動的にシンボリックリンクが作成されます。

```bash
~/dotfiles/setup.sh
```

### 4. 必要パッケージのインストール

設定を正しく動作させるために、必要なアプリケーションとフォントをインストールします。

```bash
# 必須パッケージ
sudo pacman -S niri waybar alacritty fuzzel swaylock starship

# フォント（アイコン表示に必須）
# AURヘルパー（yayなど）を使用している場合:
yay -S ttf-hack-nerd
```

インストール後、一度ログアウトして再ログインするか、再起動してください。
