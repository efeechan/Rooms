import time
import threading
import numpy as np

def simulate_day_cycle(room_data):
    for _, data in room_data.items():
        if 'temperature' in data:
            data['temperature'] += np.random.uniform(-1, 1)
            data['temperature'] = round(max(15, min(30, data['temperature'])), 1)

        if 'humidity' in data:
            data['humidity'] += np.random.randint(-5, 5)
            data['humidity'] = max(30, min(60, data['humidity']))

def run_simulation(room_data):
    while True:
        simulate_day_cycle(room_data)
        time.sleep(1) #1 minute

def start_simulation(room_data):
    simulation_thread = threading.Thread(target=run_simulation, args=(room_data,))
    simulation_thread.start()
