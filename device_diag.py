from netmiko import ConnectHandler
import datetime

device = {
    "device_type": "cisco_ios",
    "host": "10.199.199.254",  # Replace with your router's IP
    "username": "admin",
    "password": "C1sc0123!",
}

now = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
filename = f"/diagnostics/show_version_{now}.log"

try:
    connection = ConnectHandler(**device)
    output = connection.send_command("show version")
    with open(filename, "w") as f:
        f.write(output)
    print(f"Output saved to {filename}")
    connection.disconnect()
except Exception as e:
    print(f"Failed to run command: {e}")
