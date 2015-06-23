looc web app
=========

This is the web end point for the mobile app Looc

The web app lives here:
https://quiet-plateau-6449.herokuapp.com/

to get data for a specific category:

```
curl -i -H "access_token: QJLkdxzss4j9rC5RBD8k4GGl80G1BbkuhuIlcwxj"\
  -X GET http://localhost:9292/data/Animals%20&%20Pets

```