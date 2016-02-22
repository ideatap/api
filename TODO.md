## TODO Items

- Token authentication... probably using Guardian or something similar.
- Chat Channels and authentication for projects/ideas...

// User Model

Username
First Name
Last Name
Email Address
Password :virtual
Password Confirm :virtual
Hashed Password
Authentication Tokens

// The FLOW

To think about:
- Confirmation of email or something...
- MailGun or mail provider for sending confirmation emails

Create user using %{username, email, password, password_confirm}
  1. Hash password using Bcrypt hashpwsalt/1
  2. Generate token using built in Phoenix.Token
  3. Return the newly authenticated user and token

Login using %{username or email, password}
  1. get user using username or email provided
  2. checkpw/2 to check whether passwords match
