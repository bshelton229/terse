# Terse

An example url shortener application.

[http://terse.herokuapp.com/](http://terse.herokuapp.com/)

## Development ##

This app uses Github authentication. Create a github application, and either set the GITHUB_KEY and GITHUB_SECRET
environment variables, or put them in config/config.yml.

config/config.yml

```yaml
github_key: 123somekey
github_secret: 456somesecret
```

You can also visit /auth/developer, when in development or test mode, and input a username to log in, without setting
up Github authentication.
