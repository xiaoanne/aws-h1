import os
from datetime import datetime
print(os.name)

now = datetime.now()

current_time = now.strftime("%D:%H:%M:%S")
print("Current Time =", current_time)
