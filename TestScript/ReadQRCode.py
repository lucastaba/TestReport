from pyzbar.pyzbar import decode
from pyzbar import pyzbar
import sys
import cv2

if (len(sys.argv) == 2):
    image = cv2.imread(sys.argv[1])
    result = decode(image, symbols=[pyzbar.ZBarSymbol.QRCODE])
    for i in result:
        print(i.data.decode("utf-8"))

else:
    print("")