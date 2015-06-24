looc web app
=========

This is the web end point for the mobile app Looc

The web app lives here:
https://quiet-plateau-6449.herokuapp.com/

to get data for a specific category:

```
curl -i -H "access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicGV0ZXJrYWlzZXJ0YWxlbnRAZ21haWwuY29tIn0.05cbRebyfjhEutR329jrSimWhgvVU7qX_w_vx-17W5s"\
  -X GET http://localhost:9292/data/Animals%20&%20Pets

```