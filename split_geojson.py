import json, sys, os

if len(sys.argv) != 2:
  print("Manca il nome del file")
  sys.exit()
  
fn=sys.argv[1]
basename=os.path.splitext(os.path.basename(fn))[0]
extension=os.path.splitext(os.path.basename(fn))[1]

if extension!='.geojson':
  print("Deve essere geojson")
  sys.exit()

with open(fn) as f:
  features = json.load(f)['features']

i=0
for f in features:
  print(str(i).zfill(3)+"|"+f['properties']['name']+"|"+f['properties']['description'])
  i=i+1

