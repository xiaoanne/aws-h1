import os
from datetime import datetime
print(os.name)

now = datetime.now()

current_time = now.strftime("%D:%H:%M:%S")
print("Current Time =", current_time)


a = -7
b = 4
c = a%b
print(a, "%", b, "is:", c)
