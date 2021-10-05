## SinatraAPI Endpoints

Some local tests(no unit test!) with my old trusty pal CURL.

### GET /api/contact_message

Get all contact messages stored in the DynamoDB table.

__request__

```bash
curl -i -X GET -H "Content-Type: application/json" http://localhost:9292/api/contact_message
```

__response__

```console
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 255
X-Content-Type-Options: nosniff
Server: WEBrick/1.6.1 (Ruby/2.5.8/2020-03-31)
Date: Sat, 05 Dec 2020 20:26:30 GMT
Connection: Keep-Alive

[{"created_at":"2020-12-05T20:11:41.876+00:00","updated_at":"2020-12-05T20:11:41.876+00:00","id":"b9913871-436d-4e42-9389-d04cab5d0d70","sk":"Kinedu::Models::ContactMessage","email":"makenoizee@gmail.com","first_name":"francisco","content":"hello world"}]
```

### GET /api/contact_message?email=*@*.*

__request__

```bash
curl -i -X GET -H "Content-Type: application/json" http://localhost:9292/api/contact_message?email=makenoizee@gmail.com
```

__response__

```console
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 255
X-Content-Type-Options: nosniff
Server: WEBrick/1.6.1 (Ruby/2.5.8/2020-03-31)
Date: Sat, 05 Dec 2020 21:12:51 GMT
Connection: Keep-Alive

[{"created_at":"2020-12-05T20:11:41.876+00:00","updated_at":"2020-12-05T20:11:41.876+00:00","id":"b9913871-436d-4e42-9389-d04cab5d0d70","sk":"Kinedu::Models::ContactMessage","email":"makenoizee@gmail.com","first_name":"francisco","content":"hello world"}]
```

### POST /api/contact_message

Create a new contact message (POST).

__request__

```bash
 curl -i -X POST -H "Contenoizee@gmail.com", "name": "francisco", "content": "hello world"}' http://localhost:9292/api/contact_messages
```

__response__

```console
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 113
X-Content-Type-Options: nosniff
Server: WEBrick/1.6.1 (Ruby/2.5.8/2020-03-31)
Date: Sat, 05 Dec 2020 17:38:48 GMT
Connection: Keep-Alive

{"id":"1ec24e0f-9fca-4717-afa7-fd412775adde","next":"/api/contact_messages/1ec24e0f-9fca-4717-afa7-fd412775adde"}
```

### GET /api/contact_message/:id

Get contact message from a given pre created message id.

__request__

```bash
curl -i -X GET -H "Content-Type: application/json" http://localhost:9292/api/contact_message/b9913871-436d-4e42-9389-d04cab5d0d70
```

__response__

```console
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 253
X-Content-Type-Options: nosniff
Server: WEBrick/1.6.1 (Ruby/2.5.8/2020-03-31)
Date: Sat, 05 Dec 2020 20:12:48 GMT
Connection: Keep-Alive

{"created_at":"2020-12-05T20:11:41.876+00:00","updated_at":"2020-12-05T20:11:41.876+00:00","id":"b9913871-436d-4e42-9389-d04cab5d0d70","sk":"Kinedu::Models::ContactMessage","email":"makenoizee@gmail.com","first_name":"francisco","content":"hello world"}
```
