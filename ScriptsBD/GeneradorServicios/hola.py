import base64
def main():
  with open('scooter.jpeg', 'rb') as image:
    print(base64.b64encode(image.read()))

main()