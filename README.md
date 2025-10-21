# System architecture

This system uses the microservices architecture. It comprises of these services:

- **[Users microservice](https://github.com/Pasobeso/medbook-userservice)** - manages user use cases and authentication.

- **[Bookings microservice](https://github.com/Pasobeso/medbook-bookingservice)** - manages booking/appointment use cases.

- **[Inventory microservice](https://github.com/Pasobeso/medbook-inventoryservice)** - manages inventory and products.

- **[Orders microservice](https://github.com/Pasobeso/medbook-orderservice)** - manages carts and orders, and handles the order lifecycle.

- **[Deliveries microservice](https://github.com/Pasobeso/medbook-deliveryservice)** - manages deliveries and delivery addresses, and the delivery lifecycle.

These services have their own dedicated databases. A service cannot directly access another service's database. However, services can directly communicate with each other through HTTP and message queues. For the message queue, we decided to use **RabbitMQ** for its simplicity and hassle-free setup. We also used the **Outbox pattern** to ensure atomicity as we have transformed the message publishing process into a DB operation, ensuring it can be rolled back in a transaction.

External requests (i.e. from the frontend) are sent to the gateway **(NGINX)**, which forwards them to their respective microservices. 

## System diagram

![System diagram](https://github.com/Pasobeso/medbook-gateway/blob/main/System%20Diagram.png?raw=true)

# Video demonstration

- [Update 1 (Google Drive)](https://drive.google.com/file/d/10VuvLtiBaTC37-yt-nzk58lruu1MXWZd/view?usp=drive_link)

- [Update 2 (Google Drive)](https://drive.google.com/file/d/10VuvLtiBaTC37-yt-nzk58lruu1MXWZd/view?usp=drive_link)

# Installation

## 1. First steps

1. Ensure that Docker CLI and Docker Compose are installed.
2. Clone this repository.

```bash
git clone https://github.com/Pasobeso/medbook-deployment.git
```

## 2. Initialize .env files

Create the .env files from provided example files by running:

```bash
make init-env-files
```

If you need to clean the created .env files, run:

```bash
make clean-env-files
```

## 3. Running

Once the .env files have been initialized, we can run the system out of the box with no configuiration. 

Use Docker Compose to pull the latest images.

```bash
docker compose pull
```

Next, start the system as daemons (runs in background)

```bash
docker compose up -d
```

Check if all services are running properly by running `docker ps`. If all services work just fine, we can test if they actually work.

## 4. Testing the services

### Gateway

Try going to `http://localhost:3000/health-check` on your web browser. It should return a mostly blank page with only:

```
ok
```

This means that the gateway is running properly.

### Services

You can check if the services are running through the `health-check` route. For example,

`http://localhost:3000/users-service/health-check` should return:

```
ok
```

Replace `users-service` with these services to check them.

- users-service
- bookings-service
- inventory-service
- orders-service
- deliveries-service

## 5. Install the frontend

This system has a [frontend](https://github.com/Pasobeso/SA-Frontend.git) as well. Before installing, ensure that:

- A Node package manager (npm, pnpm, yarn, etc.) is installed. **pnpm v9.9.0** is preferred. Using other package manager might break the frontend's functionalities, but the chances are slim.

  - [npm](https://www.npmjs.com/) (comes with Node installation)
  - [pnpm](https://pnpm.io/)
  - [yarn](https://yarnpkg.com/)

- Have the system running (steps 1 through 4)

Once all of these are done, you can clone the frontend repository itself:

```bash
git clone https://github.com/Pasobeso/SA-Frontend
```

Change directory to the frontend project root, and install dependencies by:

```bash
cd SA-Frontend
pnpm i
# npm i
# yarn add
```

If you wish to see changes to the source code apply in real time at the cost of performance, run:

```bash
pnpm dev
# npm run dev
# yarn run dev
```

Otherwise, if you want a more performant build at the expense of losing the ability to live edit, build the project by:

```bash
pnpm build
# npm run build
# yarn run build
```

Wait until the build finishes, then from now on, run:

```bash
pnpm start
# npm run start
# yarn run start
```

You will need to rebuild the project if you make any changes to the source code.

Now you can access the frontend through your web browser. Go to `http://localhost:8080/login` to see the login page.

# Contributors

### [1. Kanathip Pandee (6510503247)](https://github.com/KanathipP)

- Users and Bookings services
- Bookings service
- Deployment setup

### [2. Ittidet Namlao (6510503905)](https://github.com/tirenton)

- Frontend

### [3. Ittiwat Chuchoet (6510503913)](https://github.com/ciaabcdefg)

- Inventory, Orders and Deliveries services
- Deployment setup
