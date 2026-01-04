#!/usr/bin/env python3
import json
import urllib.request
import urllib.parse
import time
import sys

import os

# 設定: 場所設定ファイルのパス
CONFIG_FILE = os.path.join(os.path.dirname(__file__), "weather_location.txt")

def get_city():
    try:
        with open(CONFIG_FILE, "r") as f:
            city = f.read().strip()
            if city:
                return city
    except Exception:
        pass
    return "Tokyo"

CITY = get_city()

def get_weather():
    # URLエンコード
    city_encoded = urllib.parse.quote(CITY)
    
    # 表示用テキスト (format=1: 天気アイコン + 気温)
    text_url = f"https://wttr.in/{city_encoded}?format=1"
    # ツールチップ用詳細 (format=4: 地名 + 天気 + 気温 + 風)
    tooltip_url = f"https://wttr.in/{city_encoded}?format=4"

    max_retries = 3
    for _ in range(max_retries):
        try:
            # テキスト取得
            with urllib.request.urlopen(text_url, timeout=10) as response:
                text = response.read().decode('utf-8').strip()
            
            # ツールチップ取得
            with urllib.request.urlopen(tooltip_url, timeout=10) as response:
                tooltip = response.read().decode('utf-8').strip()

            # データが正常か簡易チェック
            if "Unknown location" in text or "not found" in text:
                 # 自動判定失敗などの場合、エラーとして扱うか、そのまま出すか。
                 # wttr.inはエラーでも200を返すことがあるので文字列チェックが必要
                 pass 
            else:
                # 成功
                output = {
                    "text": text,
                    "tooltip": tooltip
                }
                print(json.dumps(output, ensure_ascii=False))
                return

        except Exception:
            # エラー時はリトライ
            time.sleep(2)
            continue
    
    # 全てのリトライに失敗、または無効なデータの場合
    print(json.dumps({"text": "...", "tooltip": "Weather data unavailable"}, ensure_ascii=False))

if __name__ == "__main__":
    get_weather()
