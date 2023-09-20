import json, sys, os
import random, string


if len(sys.argv) != 2:
  print("Manca il nome del file")
  sys.exit()
  
fn=sys.argv[1]
basename=os.path.splitext(os.path.basename(fn))[0]
extension=os.path.splitext(os.path.basename(fn))[1]

if extension!='.geojson':
  print("Deve essere geojson")
  sys.exit()

with open(fn,"r") as f:
  data = json.load(f)
f.close

i=0
for f in data['features']:
  if f['properties']['fid'] == "":
    for i in range(6):
      f['properties']['fid'] += random.choice(string.ascii_lowercase + string.digits)

  print(f['properties']['fid']+"|"+f['properties']['name']+"|"+f['properties']['description'])
  i=i+1

jsonString=json.dumps(data)
with open(fn,"w") as f:
  f.write(jsonString);
f.close
# Bisogna salvare sul geojson

