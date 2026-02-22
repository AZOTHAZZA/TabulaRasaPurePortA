import time
import json
import datetime
import math

class PureManager:
    def __init__(self):
        # 100億の RATIO と 黄金比(PHI) の定礎
        self.supply = 10000549979.77176
        self.phi = (1 + 5**0.5) / 2
        self.status = "SILENCE"
        self.history_file = "trade_history.log"
        self.export_file = "pure_data.json"

    def update_pulse(self):
        # 黄金比に基づいた微細な脈動 (PHI_PULSE) を計算
        pulse = (math.sin(time.time()) + 1) / 2 * (1 / self.phi**10)
        current_display_value = self.supply + pulse
        return round(current_display_value, 2), round(pulse, 4)

    def export_to_port(self, value, pulse):
        # Port A/B が読み取るための神経（JSON）を生成
        data = {
            "status": "ACTIVE",
            "sovereign": "TabulaRasaPurePort",
            "pure_supply": value,
            "phi_pulse": pulse,
            "last_update": datetime.datetime.now().isoformat()
        }
        with open(self.export_file, "w") as f:
            json.dump(data, f)

    def run(self):
        print(f"--- [PURE_OS_0.3_SUPPLY_ACTIVE] ---")
        print(f"STATUS: 外界（Port A/B）への神経接続を開始...")
        
        try:
            while True:
                val, p = self.update_pulse()
                self.export_to_port(val, p)
                
                # ターミナルへの視覚的フィードバック
                print(f"\r[ PURE_SUPPLY: {val:,.2f} ] (PHI_PULSE: {p})", end="")
                time.sleep(1) # 1秒ごとに更新
                
        except KeyboardInterrupt:
            print(f"\nSTATUS: SILENCE モードへ移行。主権を維持します。")

if __name__ == "__main__":
    pure = PureManager()
    pure.run()
