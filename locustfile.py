from locust import HttpUser, task, between
import json


class CheshireCatUser(HttpUser):
    host = "http://localhost:1865"
    wait_time = between(1, 3)

    def on_start(self):
        pass

    @task(1)
    def get_status(self):
        with self.client.get("/", catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Error: {response.text}")

    @task(2)
    def send_message(self):
        payload = {"text": "Hello, Cheshire Cat!"}
        headers = {'Content-Type': 'application/json'}
        with self.client.post("/message", data=json.dumps(payload), headers=headers, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Error: {response.text}")
