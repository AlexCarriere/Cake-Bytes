# Spring framework with Tomcat server.


## Usage

### Login
**Definition**

`Post /login`

**Response**

- 200: success , return a token for current user
- 400: unknown id or passward

***Argument***

- `"username":string` username/userid
- `"password":string` password -> password will be hased with salt before stored into database



### Register

`POST /register`

**Response**
- 201: created successfully , return a token for current user
- 400: username exist

***Argument***

- `"username":string` username/userid
- `"password":string` password -> will be hased before stored in db

### List all Order of certain customer
**Definition**

`GET order/<username> (Need to add the current user's token in the request header)`

**Response**

- 200: success

```json
[
    {
        "order_id": "73b6e4c6-10e5-4465-8849-d614758f9507",
        "first_name": "Anna",
        "last_name": "Banana",
        "timestamp": "2019-01-16 12:08:43",
        "status": "processing",
        "detail": {
            "base": "regular",
            "icing": "lemon",
            "deco": "sprinkle",
            "other_request": "draw heart shape on top please"
        },
        "amount": 2
    },
    {
        "order_id": "609bbf46-d87e-48b8-be87-56b14f06cbad",
        "timestamp": "2019-03-16 14:08:43",
        "first_name": "James",
        "last_name": "Bond",
        "status":"done",
        "detail": {
            "base": "chocolate",
            "icing": "pink",
            "deco": "lollipop",
            "other_request": ""
        },
        "amount": 4
    }
]
```

### Create a new order for a customer
**Definition**

`POST /order/<username>`

**Arguments**

- `"first_name":string` first name
- `"last_name":string` last name
- `"detail":array` an array of detail information about cupcake
    - `"base":string` cupcake base type
	- `"icing":string` cupcake icing type/color
	- `"deco":string` cupcake deco info
	- `"other_request":string` other special request from customer
- `"amount":int` number of dosen; qty of cupcakes 

**Response**

```json
{
    "order_id": "e96a97c7-4d27-4939-acbe-fe1a6ab9264a",
    "first_name": "Anna",
    "last_name": "Banana",
    "timestamp": "2019-01-16 12:08:43",
    "status":"ready",
    "detail": {
        "base": "regular",
        "icing": "lemon",
        "deco": "sprinkle",
        "other_request": "draw heart shape on top please"
    },
    "amount": 2
}
```
on success Unique order id will be return from server
- 400: unknow username
- 201: created succesfully

### Get an Order by orderID
**Definition**

`GET order/{username}/{orderID}`

**Response**

```json
{
    "order_id": "e96a97c7-4d27-4939-acbe-fe1a6ab9264a",
    "first_name": "Anna",
    "last_name": "Banana",
    "timestamp": "2019-01-16 12:08:43",
    "status":"processing",
    "detail": {
        "base": "regular",
        "icing": "lemon",
        "deco": "sprinkle",
        "other_request": "draw heart shape on top please"
    },
    "amount": 2
}
```
- 400: unknow username/orderID
- 200: success

###Update order by orderID      // NOT IMPLEMENTED YET
**Definition**

`POST /{username}/{orderID}}`

**Arguments**
update can take only the argument that needs tobe updated.

- `"first_name":string` first name
- `"last_name":string` last name
- `"detail":array` an array of detail information about cupcake
    - `"base":string` cupcake base type
    - `"icing":string` cupcake icing type/color
    - `"deco":string` cupcake deco info
    - `"other_request":string` other special request from customer
- `"amount":int` number of dosen; qty of cupcakes 

**Response**
- 400: unknown username/orderID
- 201: updated succesfully


### Delete order by orderID
**Definition**

`DELETE /{username}/{orderID}}`

**Response**
- 400: unknow username/orderID
- 200: deleted


### Reset mock database: (FOR DEVELOPING PURPOSE ONLY)
**Definition**

`POST /resetdb`
* db will be cleared.
* use in case of maess up something


* framework is deployed to aws EC2
* 54.201.255.168:8080/
