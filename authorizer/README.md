
Authorizer
==========

A ruby application to authorize "banking" transactions.

## 1. Application

### 1.1. Architecture

The application's architecture is based on a __N-Layered architectural style__ mixed with other like __Domain Driven Design__, __Saga Pattern__, among others.

It consist in 3 primary layers

- Data aka. Persistance layer.
- Service aka. Application layer.
- Domain aka. BusinessLogic layer.

To know more about the functional requirements, see [SPEC.md](SPEC.md)

### 1.2. Workflows

#### 1.2.1. Operation Rules

Current application's operation rules validation for violations support

| Operation                      | Support |
|:-------------------------------|:--------|
| account_already_initialized    | __Yes__ |
| account_not_initialized        | __Yes__ |
| card-not-active                | __Yes__ |
| double_transaction             | __Yes__ |
| insufficient_limit             | __Yes__ |
| high-frequency-small- interval | __No__  |

## 2. Environment

Currently working ruby version is `2.6.5` in the operating system __`OS-X 10.11 El capitan`__

> __Note! Currently are being performed tests in other environments, you should expect a containarized version__

### 2.1. Run

To run the aplication simply, from your terminal inside the apps path enter to the __`bin`__ directory and execute

```bash
ruby ahuthorizer < operations
```

#### 2.1.1. Docker

In the app root's path, build the container:

```bash
docker build . -t authorizer
```

Once it finish, run the container

```bash
docker run -it authorizer
```

Then

```bash
cd bin && ruby ahuthorizer < operations
```

### 2.2. Tests

To run the tests suite, you need to install __Bundler__(_gems manager_) and __Rspec__ gem. 

To install __Bundler__, from your terminal execute

```bash
gem install bundler
```

Then, to install rspec execute:

```bash
bundle install
```

Once it has finished, you can run all the spec by executing:

```bash
bundle exec rspec
```

## 3. Changelog

See [CHANGELOG.md](CHANGELOG.md)
