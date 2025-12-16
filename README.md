# PLANNING

## Products section:

i want to have a section products in the home page. this partial page already created in the app/views/home/_products.html.erb, the products resources already exist in the database (model name: Product). the data is already seeded.

i want to have this section to be the same as the screenshots i provided, heres the details about how it should be:

1. All products data can get from the database (model name: Product)
2. Theres should be a tab navigation with the name of the products ( `@product.name` )
3. on the left side theres a tab-content to display the image of the products ( `@product.image` )
4. on the right side above the navigation, theres a section title and description.
5. while displaying i like to have some kind of animation like accordion. so the image not open will shrink to the size of the container and the image open will be displayed in the full size. (please check the screenshots)
6. i want to have the animation transition to be smooth. consider using `    transition: transform 0.3s ease-in-out;` in the css.
7. Please add "see details" link in the center of each image. while hover the image the link will be displayed. and the image will scale up to 1.1 and will have overlay black color with opacity 0.7.
8. also while image in the close / shrink state, the image should have overlay black color with opacity 0.5.

i want you to give me a reference online or some plugin / library can be use for implement this section.