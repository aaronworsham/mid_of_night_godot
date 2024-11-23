

import requests 
   
# Making a GET request 
r = requests.get('http://localhost:1337/api/mysteries') 
  

data = r.json()
print(data['data'][0]["guid"])
