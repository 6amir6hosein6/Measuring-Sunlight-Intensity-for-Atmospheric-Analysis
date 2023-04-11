import cv2
import numpy as np
import glob


images = glob.glob('w/*.png')
for image in images:

    # read image
    img = cv2.imread(image)

    # convert to grayscale
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

    # invert gray image
    gray = 255 - gray

    # threshold
    thresh = cv2.threshold(gray, 0, 250, cv2.THRESH_OTSU + cv2.THRESH_BINARY)[1]

    # apply close and open morphology to fill tiny black and white holes and save as mask
    kernel = np.ones((3,3), np.uint8)
    mask = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
    mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, kernel)
    mask = cv2.subtract(255, mask)

    # get contours (presumably just one around the nonzero pixels)
    contours = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    contours = contours[0] if len(contours) == 2 else contours[1]
    cntr = contours[0]
    x,y,w,h = cv2.boundingRect(cntr)

    # make background transparent by placing the mask into the alpha channel
    new_img = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)
    new_img[:, :, 3] = mask

    # then crop it to bounding rectangle
    crop = new_img[y:y+h, x:x+w]


    # save cropped image
    # cv2.imwrite('cow_thresh.png',thresh)
    # cv2.imwrite('cow_mask.png',mask)
    image = image[2:]
    print(image)
    #cv2.imwrite('./cropped/'+image+'_cropped.png',crop)

    # show the images
    cv2.imshow("THRESH", thresh)
    #cv2.imshow("MASK", mask)
    cv2.imshow("CROP", crop)
cv2.waitKey(0)
cv2.destroyAllWindows()
