# Product list app

#### Application features:
- Add new product
- Edit existing product
- List all products
- Tag a product
- Delete an existing product

#### Installation
In the root dir of project:
```sh
$ rvm install 2.4.0
$ rvm use 2.4.0@product-list-app --create
$ bundle install
$ rails db:setup
$ rails s
```

#### Available API endpoints:
| Method | endpoint | Description |
| ------ | ------ | ------ |
| GET | `/api/v1/products` | List all available products |
| POST | `/api/v1/products` | Create new product |
| GET | `/api/v1/products/:id` | Show product |
| PATCH | `/api/v1/products/:id` | Update product |
| DELETE | `/api/v1/products/:id` | Delete product |
| GET | `/api/v1/tags` | List all available tags |
| POST | `/api/v1/tags` | Create new tag |
| GET | `/api/v1/tags/:id` | Show tag |
| PATCH | `/api/v1/tags/:id` | Update tag |
| DELETE | `/api/v1/tags/:id` | Delete tag |


