im = imread('Nils_overlay.jpg');


new_img = createDice(im, im, im, im, im);

image(new_img)